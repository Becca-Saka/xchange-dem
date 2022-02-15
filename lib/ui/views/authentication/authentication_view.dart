import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';

import 'phone_signup_view.dart';
import 'user_info_view.dart';
import 'verify_phone_view.dart';
class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PhoneSignUp(),
            VerifyPhoneView(),
            UserInfoView(),

          ],
        ),
      )
    );

  }
}