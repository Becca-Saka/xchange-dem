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

  
  Future<void> initAgoraRtcEngine(channelID) async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(appId);

    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    _addEventHandlers(
        onChannelJoined: () {}, onUserJoined: () {}, onUserOffline: () {});
    await _engine.joinChannel(null, channelID, null, 0);
  }

  _addEventHandlers(
      {required Function() onChannelJoined,
      required Function() onUserJoined,
      required Function() onUserOffline}) {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('$uid successfully joined channel: $channel ');
      },
      userJoined: (int uid, int elapsed) {
        print('remote user $uid joined channel');
      },
      userOffline: (int uid, UserOfflineReason reason) {
        print('remote user $uid left channel');
      },
      rtcStats: (stats) {
        //updates every two seconds
        // if (_showStats) {
        //   _stats = stats;
        // }
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
      // await doc.set(call.toJson());
      call.hasDialled = true;

      return call;
    } catch (e) {
      log('Error making call: $e');
      rethrow;
    }

    //  return null;
  }
  stopAgora(){
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
    ;
  }
}
