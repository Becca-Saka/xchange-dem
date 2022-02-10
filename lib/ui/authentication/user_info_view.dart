import 'dart:io';

import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/authentication_controller.dart';

class UserInfoView extends GetView<AuthenticationController> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(() => Column(
                      children: [
                        const Text('Set up your profile',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.white)
                            : null)),
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[600],
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20)),
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
                isButtonEnabled: controller.isProfileButtonEnable.value,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
