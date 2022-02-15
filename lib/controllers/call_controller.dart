import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/scheduler.dart';
import 'package:xchange/app/barrel.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:xchange/data/models/call_details/call_details.dart';
import 'package:xchange/data/services/call_service.dart';

class CallController extends GetxController {
  CallController({required this.callDetails});
  int? uid;

  final CallService _callService = CallService();
  CallDetails callDetails;
  @override
  void onInit() {
    log('onInit ${callDetails.callerId}');
    // callDetails = Get.arguments['callDetails'];
    initAgora();
    super.onInit();
  }

  @override
  onClose() {
    _callService.stopAgora();
    super.onClose();
  }

  initAgora() async {
    await _callService.initAgoraRtcEngine(callDetails.channelId);
  }

  getLocalView() => rtc_local_view.SurfaceView();
  getRemoteView() {
    if (uid != null) {
      return rtc_remote_view.SurfaceView(uid: uid!);
    }
  }

  addPostFrameCallback() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      //TODO: Listen for call documents'

      // userProvider = Provider.of<UserProvider>(context, listen: false);

      // callStreamSubscription = callMethods
      //     .callStream(uid: userProvider.getUser.uid)
      //     .listen((DocumentSnapshot ds) {
      //   // defining the logic
      //   switch (ds.data) {
      //     case null:
      //       // snapshot is null which means that call is hanged and documents are deleted
      //       Navigator.pop(context);
      //       break;

      //     default:
      //       break;
      //   }
      // });
    });
  }

  endCall() async {
    await _callService.endCall(callDetails);
  }
}
