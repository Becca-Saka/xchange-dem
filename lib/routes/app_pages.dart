import 'package:get/get.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/bindings/account_binding.dart';
import 'package:xchange/bindings/authentication_binding.dart';
import 'package:xchange/bindings/chat_binding.dart';
import 'package:xchange/ui/chat/chat_view.dart';
import 'package:xchange/ui/chat/view_user.dart';
import 'package:xchange/ui/edit_profile/account_settings.dart';
import 'package:xchange/ui/edit_profile/edit_profile_controller.dart';
import 'package:xchange/ui/edit_profile/edit_profile_view.dart';
import 'package:xchange/ui/home/home_view.dart';
import 'package:xchange/ui/authentication/forgotpassword_view.dart';
import 'package:xchange/ui/authentication/login_view.dart';
import 'package:xchange/ui/authentication/signup_view.dart';
import 'package:xchange/ui/authentication/startup.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => StartUp(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignUpView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.VIEWUSER,
      page: () => ViewUser(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNTSETTING,
      page: () => AccountSetting(),
    ),
  ];
}
