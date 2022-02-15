import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/controllers/call_controller.dart';
import 'package:xchange/data/models/call_details/call_details.dart';
import 'package:xchange/ui/views/chat/call/make_call.dart';

class CallLayout extends GetView<AccountController> {
  const CallLayout({required this.scaffold, Key? key}) : super(key: key);
  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<CallDetails>>(
      stream: controller.getCallStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          final callInSession = snapshot.data!.docs.first.data();
          Get.put(CallController(callDetails: callInSession));

          if (!callInSession.hasDialled) {
            return const MakeCallScreen();
          }
        }
        return scaffold;
      },
    );
  }
}
