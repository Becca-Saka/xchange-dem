import 'dart:developer';

import 'package:xchange/barrel.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:xchange/controllers/authentication_controller.dart';

class PhoneSignUp extends GetView<AuthenticationController> {
  const PhoneSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  'assets/images/svg/put_no.svg',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.contain))),
                      const SizedBox(height: 60),
                      Text(controller.isSignUp ? 'Registration' : 'Login',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text('Enter your phone number to continue',
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
                                IntlPhoneField(
                                  // controller: controller.phoneController,
                                  disableLengthCheck: true,
                                  showDropdownIcon: false,
                                  flagsButtonPadding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  initialCountryCode: 'NG',
                                  onChanged: (phone) {
                                    controller.enablePhoneButton();
                                    controller.phoneNumber = phone.number;
                                    controller.countryCode = phone.countryCode;
                                    log('${controller.countryCode} gg ${controller.phoneNumber}, ${phone.completeNumber} ${phone.toString()}');
                                  },
                                ),
                                const SizedBox(height: 25),
                                const SizedBox(height: 16),
                                authButtons(
                                  'Continue',
                                  onTap: controller.verifyPhoneNUmber,
                                  isButtonEnabled:
                                      controller.isPhoneButtonEnable.value,
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
