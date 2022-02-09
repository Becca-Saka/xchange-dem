import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';

class ForgotPasswordView extends GetView<AuthenticationController> {
  ForgotPasswordView({Key? key}) : super(key: key);

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
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ),
                Center(
                  child: SizedBox(
                      height:isSmall
                              ? 125
                              : isMedium
                                  ? 180
                                  : 300,
                      width:  isSmall
                              ? 125
                              : isMedium
                                  ? 180
                                  : 300,
                      child: SvgPicture.asset(
                          'assets/images/Deck Logo Transparent.svg')),
                ),
                appHeader(
                    isSmall
                            ? 26
                            : isMedium
                                ? 42
                                : 58,
                   isSmall
                            ? 5.5
                            : isMedium
                                ? 8
                                : 13),
                heightMin(size: isLarge ? 10 : 3),
                Text('Enter your email address to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isSmall 
                            ? 12
                            : isMedium
                                ? 16
                                : 20,
                        fontWeight: FontWeight.w500)),
                heightMin(size: isLarge ? 10 : 3),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(isSmall ? 15 : 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ).copyWith(
                          top: isSmall  ? 20 : 16,
                          bottom: 12,
                        ),
                        child: customTextField(
                          hintText: 'Email',
                          controller: controller.emailController,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (value) {
                            controller.enableForgotButton();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                heightMin(size: isLarge ? 10 : 3),
                Obx(() => authButton('Send Recovery Email',
                        height: isSmall ? 40 : 50,
                        fontSize: isLarge
                            ? 18
                            : isMedium
                                ? 17
                                : 13, onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.sendPasswordEmail();
                    },
                        isButtonEnabled:
                            controller.isRecoverButtonEnable.value)),
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
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: IconButton(
  //                     onPressed: () {
  //                       Get.back();
  //                     },
  //                     icon: Icon(Icons.arrow_back_ios)),
  //               ),
  //               Center(
  //                 child: SizedBox(
  //                     height: 200.w,
  //                     width: 200.w,
  //                     child: SvgPicture.asset(
  //                         'assets/images/Deck Logo Transparent.svg')),
  //               ),
  //               appHeader(50.sp, 11.sp),
  //               heightMini(size: 25.h),
  //               Text('Enter your email address to reset your password',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       fontFamily: 'Poppins',
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w500)),
  //               heightMini(size: 25.h),
  //               Container(
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     color: appGrey.withOpacity(0.3),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(20.0),
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
  //                       child: customTextField(
  //                         hintText: 'Email',
  //                         controller: controller.forgot,
  //                         textInputType: TextInputType.emailAddress,
  //                         onChanged: (value) {
  //                           controller.enableForgot();
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               heightMini(size: 25.h),
  //               Obx(() => authButton('Send Recovery Email', onTap: () {
  //                     FocusScope.of(context).unfocus();
  //                     controller.sendPasswordEmail();
  //                   },
  //                       isButtonEnabled:
  //                           controller.isRecoverButtonEnable.value)),
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
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: IconButton(
  //                     onPressed: () {
  //                       Get.back();
  //                     },
  //                     icon: Icon(Icons.arrow_back_ios)),
  //               ),
  //               Center(
  //                 child: SizedBox(
  //                     height: isMini
  //                         ? 80
  //                         : isSmall
  //                             ? 125
  //                             : isMedium
  //                                 ? 180
  //                                 : 300,
  //                     width: isMini
  //                         ? 80
  //                         : isSmall
  //                             ? 125
  //                             : isMedium
  //                                 ? 180
  //                                 : 300,
  //                     child: SvgPicture.asset(
  //                         'assets/images/Deck Logo Transparent.svg')),
  //               ),
  //               appHeader(
  //                   isMini
  //                       ? 18
  //                       : isSmall
  //                           ? 26
  //                           : isMedium
  //                               ? 42
  //                               : 58,
  //                   isMini
  //                       ? 4.0
  //                       : isSmall
  //                           ? 5.5
  //                           : isMedium
  //                               ? 8
  //                               : 13),
  //               heightMin(size: isLarge ? 10 : 3),
  //               Text('Enter your email address to reset your password',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       fontFamily: 'Poppins',
  //                       fontSize: isSmall || isMini
  //                           ? 12
  //                           : isMedium
  //                               ? 16
  //                               : 20,
  //                       fontWeight: FontWeight.w500)),
  //               heightMin(size: isLarge ? 10 : 3),
  //               Container(
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     color: appGrey.withOpacity(0.3),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(isSmall || isMini ? 15 : 20.0),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 16,
  //                       ).copyWith(
  //                         top: isSmall || isMini ? 20 : 16,
  //                         bottom: 12,
  //                       ),
  //                       child: customTextField(
  //                         hintText: 'Email',
  //                         controller: controller.forgot,
  //                         textInputType: TextInputType.emailAddress,
  //                         onChanged: (value) {
  //                           controller.enableForgot();
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               heightMin(size: isLarge ? 10 : 3),
  //               Obx(() => authButton('Send Recovery Email',
  //                       height: isSmall ? 40 : 50,
  //                       fontSize: isLarge
  //                           ? 18
  //                           : isMedium
  //                               ? 17
  //                               : 13, onTap: () {
  //                     FocusScope.of(context).unfocus();
  //                     controller.sendPasswordEmail();
  //                   },
  //                       isButtonEnabled:
  //                           controller.isRecoverButtonEnable.value)),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
