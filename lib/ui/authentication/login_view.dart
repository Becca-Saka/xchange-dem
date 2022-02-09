import 'dart:developer';

import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';

class LoginView extends GetView<AuthenticationController> {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // bool isMini = MySize.isMini(context);
    bool isSmall = MySize.isSmall(context);
    bool isMedium = MySize.isMedium(context);
    bool isLarge = MySize.isLarge(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: isSmall
                              ? 130
                              : isMedium
                                  ? 200
                                  : 300,
                      width: isSmall
                              ? 130
                              : isMedium
                                  ? 200
                                  : 300,
                      child: SvgPicture.asset(
                        'assets/images/Deck Logo Transparent.svg',
                      )),
                ),
                appHeader(
                    isSmall
                            ? 28
                            : isMedium
                                ? 44
                                : 60,
                  isSmall
                            ? 6.3
                            : isMedium
                                ? 10
                                : 15),
                heightMin(size: isLarge ? 10 : 3),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:  EdgeInsets.all(isSmall ?15:20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ).copyWith(
                          top: isSmall ? 22 : 16,
                          bottom: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customTextField(
                              hintText: 'Email',
                              controller: controller.emailController,
                              textInputType: TextInputType.emailAddress,
                              onChanged: (value) {
                                controller.enableButton();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 2, right: 2, bottom: isSmall ? 10 : 4),
                              child: Divider(),
                            ),
                            customTextField(
                              hintText: 'Password',
                              controller: controller.passwordController,
                              isLast: true,
                              onSubmitted: (value) {
                                controller.doLogin();
                              },
                              onChanged: (value) {
                                controller.enableLoginButton();
                              },
                              textInputType: TextInputType.visiblePassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                heightMin(size: isLarge ? 10 : 3),
                InkWell(
                  onTap: controller.navigateToForgotPassword,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: MySize.textSize(isLarge ? 3 : 4)),
                  ),
                ),
                heightMin(),
                Obx(() => authButton('Login',
                        height: isSmall
                                ? 40
                                : 50,
                        fontSize: isLarge
                            ? 18
                            : isMedium
                                ? 17
                                : 13, onTap: () {
                      controller.doLogin();
                    }, isButtonEnabled: controller.isButtonEnable.value)),
                heightMin(),
               
                heightMin(size: isSmall ? 3 : 6),
                Center(
                  child: InkWell(
                    onTap: () {
                      controller.goToSignUp();
                    },
                    child: Text('Signup',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: appRed,
                          fontFamily: 'League Spartan',
                          fontSize: isLarge
                              ? 20
                              : isMedium
                                  ? 18
                                  : 13,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(18.0),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Center(
  //                 child: SizedBox(
  //                     height: 230.w,
  //                     width: 230.w,
  //                     child: SvgPicture.asset(
  //                       'assets/images/Deck Logo Transparent.svg',
  //                     )),
  //               ),
  //               appHeader(46.sp, 12.sp),
  //               heightMini(size: 35.h),
  //               Container(
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     color: appGrey.withOpacity(0.3),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(20),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 16,
  //                       ).copyWith(
  //                         top: 16,
  //                         bottom: 12,
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           customTextField(
  //                             hintText: 'Email',
  //                             controller: controller.email,
  //                             textInputType: TextInputType.emailAddress,
  //                             onChanged: (value) {
  //                               controller.enableButton();
  //                             },
  //                           ),
  //                           Padding(
  //                             padding:
  //                                 EdgeInsets.only(left: 2, right: 2, bottom: 4),
  //                             child: Divider(),
  //                           ),
  //                           customTextField(
  //                             hintText: 'Password',
  //                             controller: controller.password,
  //                             isLast: true,
  //                             onSubmitted: (value) {
  //                               controller.doLogin();
  //                             },
  //                             onChanged: (value) {
  //                               controller.enableButton();
  //                             },
  //                             textInputType: TextInputType.visiblePassword,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               heightMini(size: 20.h),
  //               InkWell(
  //                 onTap: controller.navigateToForgotPassword,
  //                 child: Text(
  //                   'Forgot Password',
  //                   style: TextStyle(
  //                       decoration: TextDecoration.underline,
  //                       fontFamily: 'Poppins',
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 18.sp),
  //                 ),
  //               ),
  //               heightMini(size: 20.h),
  //               Obx(() => authButton('Login', onTap: () {
  //                     controller.doLogin();
  //                   }, isButtonEnabled: controller.isButtonEnable.value)),
  //               heightMini(size: 20.h),
  //               authButton(
  //                 'Login With Facebook',
  //                 onTap: () {
  //                   controller.doFacebookLogin();
  //                 },
  //                 isFacebook: true,
  //               ),
  //               heightMini(size: 25.h),
  //               Center(
  //                 child: InkWell(
  //                   onTap: () {
  //                     controller.goToSignUp();
  //                   },
  //                   child: Text('Signup',
  //                       style: TextStyle(
  //                           letterSpacing: 1.2,
  //                           color: appRed,
  //                           fontFamily: 'League Spartan',
  //                           fontSize: 18.sp)),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   bool isMini = MySize.isMini(context);
  //   bool isSmall = MySize.isSmall(context);
  //   bool isMedium = MySize.isMedium(context);
  //   bool isLarge = MySize.isLarge(context);
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(18.0),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Center(
  //                 child: SizedBox(
  //                     height: isMini
  //                         ? 80
  //                         : isSmall
  //                             ? 130
  //                             : isMedium
  //                                 ? 200
  //                                 : 300,
  //                     width: isMini
  //                         ? 80
  //                         : isSmall
  //                             ? 130
  //                             : isMedium
  //                                 ? 200
  //                                 : 300,
  //                     child: SvgPicture.asset(
  //                       'assets/images/Deck Logo Transparent.svg',
  //                     )),
  //               ),
  //               appHeader(
  //                   isMini
  //                       ? 20
  //                       : isSmall
  //                           ? 28
  //                           : isMedium
  //                               ? 44
  //                               : 60,
  //                   isMini
  //                       ? 4.0
  //                       : isSmall
  //                           ? 6.3
  //                           : isMedium
  //                               ? 10
  //                               : 15),
  //               heightMin(size: isLarge ? 10 : 3),
  //               Container(
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     color: appGrey.withOpacity(0.3),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding:  EdgeInsets.all(isSmall||isMini ?15:20.0),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 16,
  //                       ).copyWith(
  //                         top: isSmall ? 22 : 16,
  //                         bottom: 12,
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           customTextField(
  //                             hintText: 'Email',
  //                             controller: controller.email,
  //                             textInputType: TextInputType.emailAddress,
  //                             onChanged: (value) {
  //                               controller.enableButton();
  //                             },
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.only(
  //                                 left: 2, right: 2, bottom: isSmall ? 10 : 4),
  //                             child: Divider(),
  //                           ),
  //                           customTextField(
  //                             hintText: 'Password',
  //                             controller: controller.password,
  //                             isLast: true,
  //                             onSubmitted: (value) {
  //                               controller.doLogin();
  //                             },
  //                             onChanged: (value) {
  //                               controller.enableButton();
  //                             },
  //                             textInputType: TextInputType.visiblePassword,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               heightMin(size: isLarge ? 10 : 3),
  //               InkWell(
  //                 onTap: controller.navigateToForgotPassword,
  //                 child: Text(
  //                   'Forgot Password',
  //                   style: TextStyle(
  //                       decoration: TextDecoration.underline,
  //                       fontFamily: 'Poppins',
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: MySize.textSize(isLarge ? 3 : 4)),
  //                 ),
  //               ),
  //               heightMin(),
  //               Obx(() => authButton('Login',
  //                       height: isMini
  //                           ? 35
  //                           : isSmall
  //                               ? 40
  //                               : 50,
  //                       fontSize: isLarge
  //                           ? 18
  //                           : isMedium
  //                               ? 17
  //                               : 13, onTap: () {
  //                     controller.doLogin();
  //                   }, isButtonEnabled: controller.isButtonEnable.value)),
  //               heightMin(),
  //               authButton(
  //                 'Login With Facebook',
  //                 height: isMini
  //                     ? 35
  //                     : isSmall
  //                         ? 40
  //                         : 50,
  //                 fontSize: isLarge
  //                     ? 18
  //                     : isMedium
  //                         ? 17
  //                         : 13,
  //                 onTap: () {
  //                   controller.doFacebookLogin();
  //                 },
  //                 isFacebook: true,
  //               ),
  //               heightMin(size: isSmall ? 3 : 6),
  //               Center(
  //                 child: InkWell(
  //                   onTap: () {
  //                     controller.goToSignUp();
  //                   },
  //                   child: Text('Signup',
  //                       style: TextStyle(
  //                         letterSpacing: 1.2,
  //                         color: appRed,
  //                         fontFamily: 'League Spartan',
  //                         fontSize: isLarge
  //                             ? 20
  //                             : isMedium
  //                                 ? 18
  //                                 : 13,
  //                       )),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
