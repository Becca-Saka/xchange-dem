import 'package:flutter/scheduler.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/data/models/call_details/call_details.dart';
import 'package:xchange/data/services/call_service.dart';
import 'package:xchange/ui/views/chat/call/call_view.dart';

class CallController extends GetxController {
  CallController({required this.callDetails});
  Rx<int?> remoteuid = Rx<int?>(null);
  final CallService _callService = CallService();
  CallDetails callDetails;
  RxBool joinedChannel = RxBool(false);
  final AccountController _accountController = Get.find();
  String get currentUserId => _accountController.userDetails.value.uid!;
  RxBool micMuted = RxBool(false);
  RxBool videoDisabled = RxBool(false);

  @override
  void onInit() {
    initializeCall();
    super.onInit();
  }

  @override
  void onReady() {
    addCallStatusListener();
    super.onReady();
  }

  @override
  onClose() {
    _callService.stopAgora();
    super.onClose();
  }

  initializeCall() async {
    await initAgora();
    if (callDetails.receiverId != currentUserId) {
      _callService.joinChannel();
    }
  }

  initAgora() async => await _callService
          .initAgoraRtcEngine(callDetails.channelId, onChannelJoined: (uid) {
        joinedChannel.value = true;
        update();
      }, onJoined: (int uid) {
        remoteuid.value = uid;
        update();
      });

  addCallStatusListener() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _callService
          .listenForCallEnd(callDetails.channelId)
          .listen((DocumentSnapshot ds) async {
        if (!ds.exists && ds.data() == null) {
          await _callService.stopAgora();
          Get.back();
        }
      });
    });
  }

  answerVideoCall() async {
    _callService.joinChannel();
    joinedChannel.value = true;
    update();
  }

  muteMic() {
    _callService.muteMic(micMuted.value);
    if(micMuted.value) {
      micMuted.value = false;
    } else {
      micMuted.value = true;
    }
  }
  disableVideo() {
   _callService.disableVideo(videoDisabled.value);
    if(videoDisabled.value) {
      videoDisabled.value = false;
    } else {
      videoDisabled.value = true;
    }
  }

  switchCamera() {
    _callService.flipCamera();
  }


  endCall() async => await _callService.endCall(callDetails);
}
