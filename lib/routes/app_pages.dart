import 'package:get/get.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/bindings/account_binding.dart';
import 'package:xchange/bindings/authentication_binding.dart';
import 'package:xchange/bindings/chat_binding.dart';
import 'package:xchange/ui/authentication/authentication_view.dart';
import 'package:xchange/ui/authentication/onbarding_view.dart';
import 'package:xchange/ui/authentication/phone_signup_view.dart';
import 'package:xchange/ui/authentication/user_info_view.dart';
import 'package:xchange/ui/authentication/verify_phone_view.dart';
import 'package:xchange/ui/chat/chat_view.dart';
import 'package:xchange/ui/chat/view_user.dart';
import 'package:xchange/ui/home/home_view.dart';
import 'package:xchange/ui/authentication/startup.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.root;

  static final routes = [
    GetPage(
      name: Routes.root,
      page: () => const StartUp(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: AuthenticationBinding(),
    ),
    
    GetPage(
      name: Routes.authentication,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.phoneSignUp,
      page: () => const PhoneSignUp(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.verifyPhone,
      page: () => const VerifyPhoneView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.userInfo,
      page: () => const UserInfoView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.VIEWUSER,
      page: () => ViewUser(),
    ),
  ];
}
