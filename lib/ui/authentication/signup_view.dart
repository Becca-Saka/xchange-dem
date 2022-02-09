import 'dart:io';
import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';

class SignUpView extends GetView<AuthenticationController> {
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmall = MySize.isSmall(context);
    bool isLarge = MySize.isLarge(context);
    return Scaffold(
      body: SafeArea(
        child:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // heightMin(size: isSmall ? 2 : 3),
                      // Center(
                      //   child: InkWell(
                      //     onTap: controller.openImageLocationDialog,
                      //     child: Obx(() => AnimatedSwitcher(
                      //           duration: const Duration(milliseconds: 1000),
                      //           transitionBuilder: (Widget child,
                      //               Animation<double> animation) {
                      //             return ScaleTransition(
                      //                 child: child, scale: animation);
                      //           },
                      //           child: SizedBox(
                      //             height: isSmall
                      //                 ? 150
                      //                 : isLarge
                      //                     ? 280
                      //                     : 220,
                      //             width: isSmall
                      //                 ? 110
                      //                 : isLarge
                      //                     ? 220
                      //                     : 145,
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(20),
                      //               child: controller.path != ''.obs
                      //                   ? Image.file(
                      //                       File('${controller.path}'),
                      //                       fit: BoxFit.fitHeight,
                      //                     )
                      //                   : ColoredBox(
                      //                       color: appGrey,
                      //                       child: Icon(Icons.add,
                      //                           size: 80, color: Colors.white)),
                      //             ),
                      //           ),
                      //         )),
                      //   ),
                      // ),
                      // heightMin(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: appGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(isSmall ? 15 : 20.0),
                          child: Form(
                            key: controller.formKey,
                            onChanged: () {
                              controller.enableButton();
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ).copyWith(
                                      top: isSmall ? 22 : 16,
                                      bottom: 12,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customTextField(
                                            hintText: 'Name',
                                            controller: controller.nameController),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 8, right: 8, bottom: 4),
                                        //   child: Divider(),
                                        // ),
                                        // AgePicker(
                                        //   onPicked: controller.selectAge,
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 2, right: 2, bottom: 4),
                                        //   child: Divider(),
                                        // ),
                                        // GenderPicker(
                                        //   onPicked: (String val) =>
                                        //       controller.selectGender(val),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightMin(size: isSmall ? 2 : 3),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ).copyWith(
                                      top: isSmall ? 22 : 16,
                                      bottom: 12,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customTextField(
                                          hintText: 'Email',
                                          controller: controller.emailController,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          onChanged: (value) {
                                            controller.enableButton();
                                          },
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2, bottom: 4),
                                          child: Divider(),
                                        ),
                                        customTextField(
                                            hintText: 'Password',
                                            isLast: true,
                                            controller: controller.passwordController,
                                            onChanged: (value) {
                                              controller.enableButton();
                                            },
                                            textInputType:
                                                TextInputType.visiblePassword),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      heightMin(),
                      Obx(() => authButton(
                            'Create Account',
                            onTap: () {
                              controller.doSignUp();
                            },
                            isButtonEnabled: controller.isButtonEnable.value,
                          )),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
