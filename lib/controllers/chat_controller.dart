import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/models/message_details/message_details.dart';

class ChatController extends GetxController {
 late UserDetails currentChat, currentUser;
 final AccountController _accountController = Get.find<AccountController>();
//  final 
 final TextEditingController chat = TextEditingController();
//  final FirebaseService _firebaseService = FirebaseService();
  @override
  void onInit() {
    currentChat = Get.arguments['chatUser'];
    currentUser = _accountController.userDetails.value;
    print(currentChat);
    super.onInit();
  }
  //  Stream<List<Message>> getMessageStream() =>
  //     _firebaseService.getMessage(currentUser.uid!).asBroadcastStream();

  updateIsRead(){
    //TODO: update isRead to true
  }
  
  void sendMessage() {
    //TODO: send message to firebase
  }
   DateTime parseTimeStamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(
          timestamp.millisecondsSinceEpoch);
    }
  }

  String readTimeStampDaysOnly(String timeStamp) {
    var now = DateTime.now();
    final times = DateTime.parse(timeStamp);
    var diff = now.difference(times);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays <= 1) {
      time = 'Today';
    } else if (diff.inDays > 1 && diff.inDays < 2) {
      time = 'Yesterday';
    } else {
      time = '${DateFormat.yMMMd().format(times)}';
    }
    return time;
  }
  

}
