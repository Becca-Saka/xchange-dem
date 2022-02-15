import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/services/call_service.dart';

class SampleChatController extends GetxController {
  TextEditingController chat = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  Rx<MatchDetails?> matchDetails = Rx<MatchDetails?>(null);
  RxList<Message> messages = <Message>[].obs;
  RxList<Message> chatMessages = <Message>[].obs;
  // static final AccountController _accountController = Get.find();
  // RxString currentImage = ''.obs;
  // final UserDetails _currentUser = _accountController.userDetails.value;
  // UserDetails get currentUser => _currentUser;
  // final UserDetails _currentChat = _accountController.currentChat;
  // UserDetails get currentChat => _currentChat;
  // final resp = ''.obs;
  final CallService _callService = CallService();
  Rx<int?> remoteUid = 0.obs;
  @override
  void onInit() {
    startVideoCall();
    // getMatchDetails();
    //  matchDetails = Get.arguments['match'];
    super.onInit();
  }


  void goBack() => Get.back();

  startVideoCall() {
    // Get.to( CallView());
    _callService.makeVideoCall(UserDetails(), UserDetails(), clearRemoteUid: () {
      remoteUid.value = null;
    }, setRemoteUid: (int remoteId) {
      remoteUid.value = uid;
    });
  }
  endCall() {
    _callService.endCall();
  }

 
}
