import 'package:xchange/barrel.dart';

class AuthController extends GetxController {
  Rx<UserDetails> currentUser = UserDetails().obs;
  FirestoreService firestoreService = FirestoreService();
  AuthenticationService _authenticationService = AuthenticationService();
  @override
  void onInit() {
    currentUser.bindStream(_authenticationService.getUserStream());
    ever(currentUser, updateUser);
    super.onInit();
  }

  updateUser(UserDetails user) {
    AppRepo.currentUser = user;

    return currentUser.value = user;
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
