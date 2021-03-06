import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/controllers/call_controller.dart';
import 'package:xchange/data-old/models/call_details/call_details.dart';
import 'package:xchange/data-old/services-old/call_service.dart';
import 'package:xchange/ui/views/chat/call/call_view.dart';
import 'package:xchange/ui/views/chat/message/view_image.dart';

class ChatController extends GetxController {
  TextEditingController chat = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  Rx<MatchDetails?> matchDetails = Rx<MatchDetails?>(null);
  RxList<Message> messages = <Message>[].obs;
  RxList<Message> chatMessages = <Message>[].obs;
  static final AccountController _accountController = Get.find();
  RxString currentImage = ''.obs;
  final UserDetails _currentUser = _accountController.userDetails.value;
  UserDetails get currentUser => _currentUser;
  final UserDetails _currentChat = _accountController.currentChat;
  UserDetails get currentChat => _currentChat;
  final resp = ''.obs;
  final CallService _callService = CallService();
  Rx<int?> remoteUid = 0.obs;
  @override
  void onInit() {
    getMatchDetails();
    // addPostFrameCallback();
    //  matchDetails = Get.arguments['match'];
    super.onInit();
  }

  getMatchDetails() async {
    if (currentChat.currentChatrooms.isNotEmpty) {
      final match = currentChat.currentChatrooms
          .where((element) => currentUser.currentChatrooms.contains(element))
          .toList();
      if (match.isNotEmpty) {
        final details =
            await _firestoreService.privateChatCollection.doc(match.first).get();
        matchDetails.value = MatchDetails.fromJson(details.data()!);
      }
    }
  }

  getInitialMessage() async {
    messages.value =
        await _firestoreService.getFirstMessage(matchDetails.value!.uid!);
  }

  updateIsRead() {
    log('updateIsRead');
    if (matchDetails.value != null &&
        matchDetails.value!.unReadMessagesList != null &&
        matchDetails.value!.messageId != currentUser.uid) {
      _firestoreService.updateReadMessage(matchDetails.value!.uid!, currentUser.uid!);
    }
  }

  Stream<List<Message>> getMessageStream() => _firestoreService
      .getMessage(matchDetails.value!.uid!)
      .asBroadcastStream();

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
      matchDetails.value = await _firestoreService.sendMessage(
          text, matchDetails.value, currentChat,
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
      time = DateFormat.yMMMd().format(times);
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

  void goBack() => Get.back();

  dialVideoCall() async {
    CallDetails callDetails =
        await _callService.makeCall(currentUser, currentChat);
    if (callDetails.hasDialled) {
      Get.put(CallController(callDetails: callDetails));
      Get.to(
        const CallView(),
      );
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

  Future<void> blockUser() async {
    showLoadingDialogWithText(msg: 'Blocking ${currentChat.userName}');
    await FirestoreService()
        .blockUser(currentChat, matchDetails.value!)
        .whenComplete(() => Get.offAllNamed(Routes.main, arguments: 'blocked'));
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
