import 'dart:io';
import 'package:coolicons/coolicons.dart';
import 'package:xchange/barrel.dart';

class UserInfoView extends GetView<AuthenticationController> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('Set up your profile',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Obx(
                    () => Column(
                      children: [
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: controller.pickImage,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Obx(() => CircleAvatar(
                                  backgroundColor: appColor,
                                  radius: 60,
                                  backgroundImage: controller.path.value != ''
                                      ? FileImage(
                                          File(controller.path.value),
                                        )
                                      : null,
                                  child: controller.path.value == ''
                                      ? const Icon(Coolicons.user,
                                          size: 60, color: Colors.white)
                                      : null)),
                              CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey[100],
                                  child: Icon(Coolicons.plus,
                                      color: appColor, size: 30)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                          ),
                          onChanged: (value) {
                            controller.enableProfileButton();
                          },
                        ),
                        const Spacer(),
                        authButtons(
                          'Continue',
                          onTap: controller.signUpUser,
                          isButtonEnabled:
                              controller.isProfileButtonEnable.value,
                          loadAnimation: controller.loadWithAnimation.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
