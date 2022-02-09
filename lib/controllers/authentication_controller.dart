import 'dart:developer';

import 'package:xchange/barrel.dart';

class AuthenticationController extends GetxController {
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  final AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isButtonEnable = false.obs;
RxBool isRecoverButtonEnable = false.obs;
  doSignUp() async {
    log('doSignUp');
    if (nameController.text.isEmpty) {
      errorSnackbar(msg: 'Name field cannot be empty');
    } else if (emailController.text.isEmpty) {
      errorSnackbar(msg: 'Email field cannot be empty');
    } else if (!GetUtils.isEmail(emailController.text)) {
      errorSnackbar(msg: 'Please provide a valid email');
    } else if (passwordController.text.length < 6) {
      errorSnackbar(msg: 'Password can\'t be less than 6 characters');
    } else {
      if (useCheckInternet()) {
        await _authenticationService.signUp(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        Get.offAllNamed(Routes.HOME);
      }
    }
  }

  enableButton() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isButtonEnable.value = true;
    } else {
      isButtonEnable.value = false;
    }
  }

  doLogin() {
    if (emailController.text.isEmpty) {
      errorSnackbar(msg: 'Email field cannot be empty');
    } else if (!GetUtils.isEmail(emailController.text)) {
      errorSnackbar(msg: 'Pleae provide a valid email');
    } else if (passwordController.text.length < 6) {
      errorSnackbar(msg: 'Password can\'t be less than 6 characters');
    } else {
      if (useCheckInternet()) {
        _authenticationService.login(
            emailController.text, passwordController.text);
      }
    }
  }
   enableLoginButton() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isButtonEnable.value = true;
    } else {
      isButtonEnable.value = false;
    }
    
  }

  enableForgotButton() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isButtonEnable.value = true;
    } else {
      isButtonEnable.value = false;
    }
    
  }
  
  

 

  sendPasswordEmail() async {
    if (!GetUtils.isEmail(emailController.text)) {
      errorSnackbar(msg: 'Pleae provide a valid email');
    } else {
      if (useCheckInternet()) {
        await _authenticationService.forgotPassword(emailController.text);
        emailController.clear();
      }
    }
  }

  goToSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }

   navigateToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }
}
