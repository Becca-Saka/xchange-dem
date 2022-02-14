import 'package:xchange/barrel.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (LocalStorage.userLoggedIn.val &&
        LocalStorage.authenticationStarted.val) {
      return const RouteSettings(name: Routes.authentication);
    } else if (LocalStorage.userLoggedIn.val &&
        LocalStorage.authenticationStarted.val == false) {
      return const RouteSettings(name: Routes.main);
    } else {
      return null;
    }
  }
}
