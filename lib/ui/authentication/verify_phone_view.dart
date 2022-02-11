// import 'dart:developer';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xchange/barrel.dart';

class VerifyPhoneView extends GetView<AuthenticationController> {
  const VerifyPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.goBackPage();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: CircleAvatar(
                                backgroundColor: appColor.withOpacity(0.2),
                                child: SvgPicture.asset(
                                    'assets/images/svg/confirm_no.svg',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain))),
                        const SizedBox(height: 60),
                        const Text('Registration',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text('Enter the 6-digit code sent to your phone',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w100)),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
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
                                        // borderRadius: BorderRadius.circular(5),
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
                                    // errorAnimationController: errorController,
                                    controller: controller.pinController,
                                    onCompleted: (v) {
                                      controller.otp = v;
                                      controller.enablePhoneVerifyButton();
                                      controller.verifyOTP();
                                    },
                                    onChanged: (value) {
                                      controller.enablePhoneVerifyButton();
                                    },
                                    appContext: context,
                                  ),
                                  const SizedBox(height: 25),
                                  const SizedBox(height: 16),
                                  authButtons(
                                    'Continue',
                                    onTap: controller.verifyOTP,
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
      ),
    );
  }
}
