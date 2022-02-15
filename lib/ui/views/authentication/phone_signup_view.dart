import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:xchange/app/barrel.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneSignUp extends GetView<AuthenticationController> {
  const PhoneSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmall = MySize.isSmall(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
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
                                'assets/images/svg/put_no.svg',
                                height: isSmall ? 60 : 120,
                                width: isSmall ? 60 : 120,
                                fit: BoxFit.contain))),
                    SizedBox(height: isSmall ? 35 : 60),
                    const Text('Enter Your Phone Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 5),
                    const Text(
                        'Please confirm your country code and enter your phone number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                    SizedBox(height: isSmall ? 6 : 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 30.0),
                          child: Column(
                            children: [
                              IntlPhoneField(
                                disableLengthCheck: true,
                                showDropdownIcon: false,
                                initialValue:
                                    controller.formatPhoneResult != null
                                        ? controller
                                            .formatPhoneResult!.formattedNumber
                                        : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                flagsButtonPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(18)
                                ],
                                initialCountryCode: controller.countryCode,
                                onChanged: (phone) {
                                  // log('phone $phone');
                                  controller.enablePhoneButton();
                                  controller.phoneNumber = phone.completeNumber;
                                  controller.countryCode = phone.countryISOCode;
                                  controller.numberWithoutCode = phone.number;
                                },
                                onCountryChanged: (Country country) {
                                  controller.countryCode = country.code;
                                },
                                onSubmitted: (val) => controller.checkNumber(),
                              ),
                              const SizedBox(height: 40),
                              authButtons('Continue',
                                  onTap: controller.checkNumber,
                                  isButtonEnabled:
                                      controller.isPhoneButtonEnable.value,
                                  loadAnimation:
                                      controller.loadWithAnimation.value),
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
    );
  }
}
