import 'package:get/get.dart';
import 'package:xchange/app/middlewares/authentication_middleware.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/bindings/account_binding.dart';
import 'package:xchange/bindings/authentication_binding.dart';
import 'package:xchange/bindings/chat_binding.dart';
import 'package:xchange/ui/views/authentication/authentication_view.dart';
import 'package:xchange/ui/views/authentication/onbarding_view.dart';
import 'package:xchange/ui/views/authentication/phone_signup_view.dart';
import 'package:xchange/ui/views/authentication/user_info_view.dart';
import 'package:xchange/ui/views/authentication/verify_phone_view.dart';
import 'package:xchange/ui/views/chat/chat_view.dart';
import 'package:xchange/ui/views/chat/view_user.dart';
import 'package:xchange/ui/views/home/main_view.dart';
// import 'package:xchange/ui/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.root;

  static final routes = [
    GetPage(
      name: Routes.root,
      page: () => const OnboardingView(),
      binding: AuthenticationBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
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
      name: Routes.main,
      page: () => MainView(),
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
