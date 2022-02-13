import 'dart:convert';
import 'dart:developer';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/shared/const_dialogs.dart';

class AuthenticationController extends GetxController {
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  final AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  PageController pageController = PageController();
  RxBool isPhoneButtonEnable = false.obs;
  RxBool isPhoneVerifyButtonEnable = false.obs;
  RxBool isProfileButtonEnable = false.obs;
  RxBool isButtonEnable = false.obs;
  RxBool isRecoverButtonEnable = false.obs;
  RxBool loadWithAnimation = false.obs;
  late UserCredential currentUserCredentials;
  String? phoneNumber, numberWithoutCode;
  String? otp, verificationId;
  String countryCode = 'NG';
  int? resendToken;
  RxString path = ''.obs;
  final ContactService _contactService = ContactService();
  RxInt timeTillResendToken = 60.obs;
  Timer? _timer;
  FormatPhoneResult? formatPhoneResult;
  // Rx<CountryWithPhoneCode> countryPhoneCode = const CountryWithPhoneCode.us().obs;
  @override
  onInit() {
    getUserFromLocalStorage();
    super.onInit();
  }

  getUserFromLocalStorage() {
    if (LocalStorage.userDetail.val.isNotEmpty) {
      final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
      userDetails.value = UserDetails.fromJson(userFromStorage);
      nameController.text = userDetails.value.userName!;
    }
  }

  navigateToAuthenticationPage() async {
    await _contactService.getContactPermission();
    Get.toNamed(Routes.authentication);
  }

  checkNumber() async {
    if (numberWithoutCode != null && isPhoneButtonEnable.value) {
      formatPhoneResult = await _contactService.getFormattedNumber(
          countryCode, numberWithoutCode!);
      if (formatPhoneResult != null) {
        ConstDialogs.showNumberVerificationDialog(
            number: formatPhoneResult!.formattedNumber,
            title: 'A verification code will be sent to: ',
            onPressed: verifyPhoneNUmber);
      } else {
        ConstDialogs.showNumberVerificationDialog(
            number: '$phoneNumber', title: 'Invalid number');
        log('invalid number');
      }
    }
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

    loadWithAnimation.value = true;
    await _authenticationService
        .verifyPhoneNumber(formatPhoneResult!.formattedNumber,
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

  Future<void> resendVerifyPhoneNUmber() async {
    if (isPhoneVerifyButtonEnable.value) {
      loadWithAnimation.value = true;
      await _authenticationService.verifyPhoneNumber(formatPhoneResult!.formattedNumber,
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
        final userExist = await _authenticationService.getUser();
        if (userExist) {
          final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
          final user =
              UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
          nameController.text = user.userName!;
          if (nameController.text.isNotEmpty) {
            isProfileButtonEnable.value = true;
          }
        }

        pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
