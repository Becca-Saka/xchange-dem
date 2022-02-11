import 'dart:developer';

import 'package:xchange/barrel.dart';

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
  RxBool loadWithAnimation = false.obs;
  late UserCredential currentUserCredentials;
  String? phoneNumber, otp, verificationId;
  String countryCode = 'NG';
  int? resendToken;
  RxString path = ''.obs;
  bool isSignUp = false;
  final ContactService _contactService = ContactService();
  RxInt timeTillResendToken = 60.obs;
  Timer? _timer;
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

  enableProfileButton() {
    if (nameController.text.isNotEmpty) {
      isProfileButtonEnable.value = true;
    } else {
      isProfileButtonEnable.value = false;
    }
  }

  Future<void> verifyPhoneNUmber() async {
    if (isPhoneButtonEnable.value) {
      loadWithAnimation.value = true;
      await _authenticationService.verifyPhoneNumber(phoneNumber!,
          onCodeSent: (String id, {int? token}) {
        verificationId = id;
        resendToken = token;
        loadWithAnimation.value = false;
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);

        timeTillResendToken.value = 60;
        startResendTokenTimer();
      }, onError: () {
        loadWithAnimation.value = false;
      });
    }
  }

  Future<void> resendVerifyPhoneNUmber() async {
    if (isPhoneVerifyButtonEnable.value) {
      loadWithAnimation.value = true;
      await _authenticationService.verifyPhoneNumber(phoneNumber!,
          onCodeSent: (String id, {int? token}) {
            verificationId = id;
            resendToken = token;
            loadWithAnimation.value = false;

            timeTillResendToken.value = 60;
            startResendTokenTimer();
          },
          resendToken: resendToken,
          onError: () {
            loadWithAnimation.value = false;
            if (_timer != null) {
              _timer!.cancel();
              timeTillResendToken.value = 60;
              isPhoneVerifyButtonEnable.value = false;
            }
          });
    }
  }

  startResendTokenTimer() {
    if (_timer != null) {
      _timer!.cancel();
      timeTillResendToken.value = 60;
      isPhoneVerifyButtonEnable.value = false;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeTillResendToken.value == 0) {
        timer.cancel();

        isPhoneVerifyButtonEnable.value = true;
      } else {
        timeTillResendToken.value--;
      }
    });
  }

  goBackPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> verifyOTP(String? code) async {
    if (code != null && otp! == code) {
      loadWithAnimation.value = true;
      final currentUser = await _authenticationService.verifyOTP(
        verificationId!,
        otp!,
        onError: () {
          loadWithAnimation.value = false;
        },
      );

      loadWithAnimation.value = false;
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
          nameController.text, currentUserCredentials, path.value, countryCode);

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
