import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/call_controller.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:xchange/data/models/call_details/call_details.dart';

class CallView extends StatelessWidget {
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CallController>(
        builder: (CallController controller) => Scaffold(
            body: controller.callDetails.callerId == controller.currentUserId &&
                    controller.remoteuid.value == null
                ? callRingingScreen(controller)
                : controller.callDetails.receiverId ==
                            controller.currentUserId &&
                        controller.remoteuid.value == null
                    ? callRingingRecieverScreen(controller)
                    : Stack(
                        children: [
                          Center(
                            child: renderRemoteView(controller),
                          ),
                         
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: rtc_local_view.SurfaceView(),
                            ),
                          ),
                           Align(
                            alignment: Alignment.bottomCenter,child: toolBar(controller)),
                        ],
                      )));
  }

  callRingingRecieverScreen(CallController controller) {
    final CallDetails callDetails = controller.callDetails;
    return Stack(
      children: [
        Center(
          child: rtc_local_view.SurfaceView(),
        ),
        Column(
          children: [
            const Spacer(),
            profileAvatar(callDetails.callerId, callDetails.callerName,
                radius: 60),
            const SizedBox(
              height: 5,
            ),
            Text(callDetails.callerName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const SizedBox(
              height: 5,
            ),
            const Text('Incoming Video call...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const Spacer(
              flex: 8,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roundIcon(Icons.call, controller.answerVideoCall,
                      color: appColor),
                  roundIcon(Icons.call_end, controller.endCall,
                      color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  callRingingScreen(CallController controller) {
    final CallDetails callDetails = controller.callDetails;
    return Stack(
      children: [
        Center(
          child: rtc_local_view.SurfaceView(),
        ),
        Column(
          children: [
            const Spacer(),
            profileAvatar(callDetails.receiverPic, callDetails.receiverName,
                radius: 60),
            const SizedBox(
              height: 5,
            ),
            Text(
              callDetails.receiverName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Calling...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const Spacer(
              flex: 8,
            ),
            toolBar(controller),
          ],
        ),
      ],
    );
  }

  Padding toolBar(CallController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            roundIcon(
              Icons.cameraswitch_rounded,
              controller.switchCamera,
            ),
            roundIcon(
              controller.videoDisabled.value
                  ? Icons.videocam_rounded
                  : Icons.videocam_off_rounded,
              controller.disableVideo,
            ),
            roundIcon(
              controller.micMuted.value ? Icons.mic_off : Icons.mic,
              controller.muteMic,
            ),
            roundIcon(Icons.call_end, () {
              controller.endCall();
            }, color: Colors.red),
          ],
        ),
      ),
    );
  }

  ElevatedButton roundIcon(IconData icon, Function() onPressed,
      {Color color = Colors.grey}) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Icon(icon, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        primary: color, // <-- Button color
        onPrimary: appColor, // <-- Splash color
      ),
    );
  }

  Center renderRemoteView(CallController controller) {
    if (controller.remoteuid.value == null) {
      return const Center(
        child: Text('User not joined'),
      );
    }
    return Center(
      child: rtc_remote_view.SurfaceView(uid: controller.remoteuid.value!),
    );
  }
}
