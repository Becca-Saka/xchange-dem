import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';
import 'package:xchange/ui/authentication/contact_view.dart';
import 'package:xchange/ui/authentication/phone_signup_view.dart';
import 'package:xchange/ui/authentication/user_info_view.dart';
import 'package:xchange/ui/authentication/verify_phone_view.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PhoneSignUp(),
            VerifyPhoneView(),
            ContactView(),
            UserInfoView(),

          ],
        ),
      )
    );

  }
}