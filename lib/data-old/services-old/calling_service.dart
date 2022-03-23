import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xchange/app/barrel.dart';

/// Get your own App ID at https://dashboard.agora.io/
const String appId = "2c4ce455060c4026a824580799b20435";

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
const String token =
    "0062c4ce455060c4026a824580799b20435IAA44yMvBkM3j/s1JfoFasVJkjNS3Rj+68Am5W8g4ukBwSBPEZkAAAAAEAAxc9bWqSkHYgEAAQCpKQdi";

/// Your channel ID
const String channelId = "Xchange Temp";

/// Your int user ID
const int uid = 0;

/// Your string user ID
const String stringUid = '0';

class CallService {
  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  int? remoteUid;
  makeVideoCall(UserDetails userToCall, UserDetails userCalling,
      {required Function(int remoteId) setRemoteUid,
      required Function() clearRemoteUid}) async {
// retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);

    _engine.leaveChannel();
    await _engine.enableVideo();
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        log("local user $uid joined");
      },
      userJoined: (int uid, int elapsed) {
        setRemoteUid(uid);
        log("remote user $uid joined");
        remoteUid = uid;
      },
      userOffline: (int uid, UserOfflineReason reason) {
        clearRemoteUid();
        log("remote user $uid left channel");

        remoteUid = null;
      },
    ));

    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    await _engine.joinChannel(token, "video", null, 0);
  }

  endCall() {
    _engine.leaveChannel();
    _engine.stopPreview();
    _engine.destroy();
  }
}
