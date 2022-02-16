import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:permission_handler/permission_handler.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/data/models/call_details/call_details.dart';

class CallService {
  late final RtcEngine _engine;
  CollectionReference callCollection =
      FirebaseFirestore.instance.collection('Calls');
  String appId = "2c4ce455060c4026a824580799b20435";
  String token =
      '0062c4ce455060c4026a824580799b20435IAB5oAtSkUI5G5f1NY8Br6Jhm/qZGDJtLX2hLzu66BZY3Ca/dKoAAAAAEADzxwcSB04OYgEAAQAHTg5i';
  String channelName = 'Test users';

  Future<void> initAgoraRtcEngine(channelID,
      {required Function(int uid) onChannelJoined,
      required Function(int uid) onJoined}) async {
    try {
      await [Permission.microphone, Permission.camera].request();
      _engine = await RtcEngine.create(appId);

      await _engine.enableVideo();
      await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
      await _engine.setClientRole(ClientRole.Broadcaster);

      _addEventHandlers(
          onChannelJoined: onChannelJoined,
          onUserJoined: onJoined,
          onUserOffline: () {});
      // await _engine.joinChannel(token, channelName, null, 0);
    } catch (e) {
      log('Agora Erro $e');
    }
  }

  joinChannel() {
    _engine.joinChannel(token, channelName, null, 0);
  }

  _addEventHandlers(
      {required Function(
        int uid,
      )
          onChannelJoined,
      required Function(
        int uid,
      )
          onUserJoined,
      required Function() onUserOffline}) {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        log('$uid successfully joined channel: $channel ');
        onChannelJoined(uid);
      },
      userJoined: (int uid, int elapsed) {
        onUserJoined(uid);
        log('remote user $uid joined channel');
      },
      userOffline: (int uid, UserOfflineReason reason) {
        log('remote user $uid left channel');
      },
      rtcStats: (stats) {
        log('stats: ${stats.toString()}');
      },
    ));
  }

  Future<CallDetails> makeCall(UserDetails from, UserDetails to) async {
    try {
      final doc = callCollection.doc();
      CallDetails call = CallDetails(
        callerId: from.uid!,
        callerName: from.userName!,
        callerPic: from.imageUrl,
        receiverId: to.uid!,
        receiverName: to.nameInContact!,
        receiverPic: to.imageUrl,
        channelId: doc.id,
        hasDialled: false,
      );
      await doc.set(call.toJson());
      call.hasDialled = true;

      return call;
    } catch (e) {
      log('Error making call: $e');
      rethrow;
    }
  }

  stopAgora() {
    _engine.leaveChannel();
    _engine.destroy();
  }

  Future<bool> endCall(CallDetails call) async {
    try {
      await callCollection.doc(call.channelId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot<CallDetails>> listenForCall(uid) {
    return callCollection
        .where('receiverId', isEqualTo: uid)
        .withConverter(
            fromFirestore: (doc, v) => CallDetails.fromJson(doc.data()!),
            toFirestore: (CallDetails call, _) => call.toJson())
        .snapshots();
  }

  Stream<DocumentSnapshot> listenForCallEnd(uid) {
    return callCollection.doc(uid).snapshots();
  }

  void muteMic(bool muted) {
    if(muted){
      _engine.muteLocalAudioStream(false);
    }else{
      _engine.muteLocalAudioStream(true);
    }
  }

  disableVideo(bool disabled) {
    if(disabled){
      _engine.disableVideo();
      
    }else{
      _engine.enableVideo();
    }
  }
  

  flipCamera() {
    _engine.switchCamera();
  }

}
