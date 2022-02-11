import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/ui/chat/view_image.dart';



class ChatController extends GetxController {
  TextEditingController chat = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

    MatchDetails? matchDetails;
  RxList<Message> messages = <Message>[].obs;
  RxList<Message> chatMessages = <Message>[].obs;
 static final AccountController _accountController = Get.find();
  RxString currentImage = ''.obs;
 final UserDetails _currentUser  = _accountController.userDetails.value;
 UserDetails get currentUser => _currentUser;
 final UserDetails _currentChat = _accountController.currentChat;
 UserDetails get currentChat => _currentChat;
  final resp = ''.obs;
  @override
  void onInit() {
    //  matchDetails = Get.arguments['match'];
    super.onInit();
  }


  getInitialMessage() async {
    messages.value = await _firestoreService.getFirstMessage(matchDetails!.uid!);
  }

  updateIsRead() {
    log('updateIsRead');
    if (matchDetails!=null && matchDetails!.unReadMessagesList != null &&
        matchDetails!.messageId != currentUser.uid) {
      _firestoreService.updateReadMessage(matchDetails!.uid!);
    }
  }

  Stream<List<Message>> getMessageStream() =>
      _firestoreService.getMessage(matchDetails!.uid!).asBroadcastStream();

  Future<void> sendMessage({String? url}) async {
    final text = chat.text;
    if ((text.isNotEmpty || url != null) && useCheckInternet()) {
      final temp = Message(
          senderId: currentUser.uid,
          message: text,
          isImage: url != null,
          imageUrl: url,
          time: DateTime.now().toString());
      messages.add(temp);
      chat.clear();
      await _firestoreService.sendMessage(text, matchDetails, currentChat,
          hasImage: url != null, imagePath: url);
    }
  }

  DateTime parseTimeStamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(
          timestamp.millisecondsSinceEpoch);
    }
  }

  String readTimeStampDaysOnly(timeStamp) {
    var now = DateTime.now();
    final times = parseTimeStamp(timeStamp);
    var diff = DateTime(now.year, now.month, now.day)
        .difference(DateTime(times.year, times.month, times.day));
    var time = '${diff.inDays}';
    if (diff.inDays == 0) {
      time = 'Today';
    } else if (diff.inDays == 1) {
      time = 'Yesterday';
    } else {
      time = '${DateFormat.yMMMd().format(times)}';
    }
    return time;
  }

  openImageLocationDialog() async {
    final result = await Get.dialog(const ImageService());
    if (result != null) {
      resp.value = result;
      await sendMessage(url: result);
      resp.value = '';
    }
  }

  navigateToViewImage(Message element) {
    Get.to(
        () => ViewImage(
              url: element.imageUrl!,
              sentBy: element.senderId == currentUser.uid
                  ? 'You'
                  : currentChat.userName!,
              time:
                  '${readTimeStampDaysOnly(element.time)},  ${DateFormat.Hm().format(parseTimeStamp(element.time))}',
            ),
        fullscreenDialog: true);
  }

  navigateToViewUser() {
    currentImage.value = currentChat.imageUrl!;
    Get.toNamed(Routes.VIEWUSER, arguments: {'user': currentChat});
  }

  void changeImage(String image) {
    currentImage.value = image;
  }

  void goBack() => Get.back();
  Future<void> blockUser() async {
    showLoadingDialogWithText(msg: 'Blocking ${currentChat.userName}');
    await FirestoreService()
        .blockUser(currentChat, matchDetails!)
        .whenComplete(() => Get.offAllNamed(Routes.home, arguments: 'blocked'));
  }

  Future<void> showConfirmationDialog() async {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Block ${currentChat.userName}?',
          style: const TextStyle(
            fontSize: 17.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Blocking match will remove them from your deck and you won\'t get matched with them in future.',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            heightMin(size: 1),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Block'),
            onPressed: () async {
              await blockUser();
            },
          ),
        ],
      ),
    );
  }
}
