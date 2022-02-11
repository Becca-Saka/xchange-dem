// import 'dart:developer';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xchange/barrel.dart';

class VerifyPhoneView extends GetView<AuthenticationController> {
  const VerifyPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmall = MySize.isSmall(context);
    return WillPopScope(
      onWillPop: () async {
        controller.pinController.clear();
        controller.goBackPage();
        return false;
      },
      child: Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 18),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                    const SizedBox(height: kToolbarHeight),
                       SizedBox(
                        height: isSmall ? 140 : 200,
                        width: isSmall ? 140 : 200,
                        child: CircleAvatar(
                            backgroundColor: appColor.withOpacity(0.2),
                            child: SvgPicture.asset(
                                'assets/images/svg/confirm_no.svg',
                                height: isSmall ? 60 : 120,
                                width: isSmall ? 60 : 120,
                                fit: BoxFit.contain))),
                     SizedBox(height:isSmall ? 35 : 60),
                      const Text('Enter Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 5),
                      Text(
                          'We have sent you an SMS with the code to ${controller.phoneNumber}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                       SizedBox(height: isSmall ? 6 :20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 30.0),
                            child: Column(
                              children: [
                                PinCodeTextField(
                                  length: 6,
                                  obscureText: false,
                                  autoDisposeControllers: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.underline,
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      inactiveColor: Colors.grey[200],
                                      activeFillColor: Colors.white,
                                      activeColor: appColor.withOpacity(0.2),
                                      selectedColor: appColor,
                                      selectedFillColor: Colors.transparent,
                                      inactiveFillColor: Colors.transparent),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  controller: controller.pinController,
                                  onCompleted: (v) {
                                    controller.otp = v;
                                    controller.verifyOTP(v);
                                  },
                                  onChanged: (value) {
                                  },
                                  appContext: context,
                                ),
                                const SizedBox(height: 40),
                                authButtons(
                                  controller.timeTillResendToken.value != 0
                                      ? ' Resend in ${controller.timeTillResendToken.value}'
                                      : 'Resend Code',
                                  onTap: controller.resendVerifyPhoneNUmber,
                                  isButtonEnabled: controller
                                      .isPhoneVerifyButtonEnable.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }
}
