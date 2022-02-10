import 'dart:developer';

import 'package:xchange/barrel.dart';
import 'package:xchange/services/contact_service.dart';

class AuthenticationController extends GetxController {
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  final AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  PageController pageController = PageController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isPhoneButtonEnable = false.obs;
  RxBool isPhoneVerifyButtonEnable = false.obs;
  RxBool isProfileButtonEnable = false.obs;
  RxBool isButtonEnable = false.obs;
  RxBool isRecoverButtonEnable = false.obs;
  late UserCredential currentUserCredentials;
  String? phoneNumber, otp, verificationId;
  RxString path = ''.obs;
  bool isSignUp = false;
  final ContactService _contactService = ContactService();
  
  navigateToPhonePage(bool signUp) {
    isSignUp = signUp;
    Get.toNamed(Routes.authentication);
  }

  enablePhoneButton() {
    if (phoneNumber != null && phoneNumber!.length >= 10) {
      isPhoneButtonEnable.value = true;
    } else {
      isPhoneButtonEnable.value = false;
    }
  }

  enablePhoneVerifyButton() {
    if (otp != null && otp!.length >= 6) {
      isPhoneVerifyButtonEnable.value = true;
    } else {
      isPhoneVerifyButtonEnable.value = false;
    }
  }

  enableProfileButton() {
    if (nameController.text.isNotEmpty) {
      isProfileButtonEnable.value = true;
    } else {
      isProfileButtonEnable.value = false;
    }
  }

  Future<void> verifyPhoneNUmber() async {
    if (isPhoneButtonEnable.value) {
      await _authenticationService.verifyPhoneNumber(phoneNumber!,
          onCodeSent: (String id) {
        verificationId = id;
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
  }

  goBackPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> verifyOTP() async {
    if (isPhoneVerifyButtonEnable.value) {
      final currentUser = await _authenticationService.verifyOTP(
        verificationId!,
        otp!,
      );
      if (currentUser.user != null) {
        currentUserCredentials = currentUser;
        if (isSignUp) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        } else {
          logInUser();
        }
      }
    }
  }

  requestContactPermission() async {
    await _contactService.getContactPermission();
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  navigateToUserInfo() {
    Get.toNamed(Routes.userInfo);
  }

  Future<void> signUpUser() async {
    if (isProfileButtonEnable.value) {
      await _authenticationService.saveUser(
          nameController.text, currentUserCredentials, path.value);

      Get.offAllNamed(Routes.home);
    }
  }

  pickImage() async {
    final result = await Get.dialog(const ImageService(
      isSignUp: true,
    ));
    if (result != null) {
      path.value = result;
    }
  }

  Future<void> logInUser() async {
    final userExist = await _authenticationService.getUser();
    if (userExist) {
      Get.offAllNamed(Routes.home);
    } else {
      errorSnackbar(msg: 'Account does not exist, please sign up');
    }
  }

}
