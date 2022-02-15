import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/call_controller.dart';

class MakeCallScreen extends GetView<CallController> {
  const MakeCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Center(
              child: controller.getRemoteView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: controller.getLocalView(),
                ),
              ),
            ),
        ],
      )
    );
  }
  }
