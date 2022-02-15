import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:xchange/app/barrel.dart';
import 'package:xchange/ui/views/chat/call/sample_cont.dart';

class CallView extends StatelessWidget {
   CallView({Key? key}) : super(key: key);
  
   final controller = Get.put(SampleChatController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.endCall();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() => Center(
                  child: _remoteVideo(),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: rtc_local_view.SurfaceView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (controller.remoteUid.value != null && controller.remoteUid.value != 0) {
      return rtc_remote_view.SurfaceView(uid: controller.remoteUid.value!);
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
