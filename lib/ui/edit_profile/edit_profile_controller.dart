import 'package:flutter/foundation.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/shared/const_string.dart';
import 'package:xchange/ui/edit_profile/account_settings.dart';

import 'notifications.dart';
import 'terms_and_privacy.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
  }
}

class EditProfileController extends GetxController {
  AuthenticationService _authenticationService = AuthenticationService();
  Rx<UserDetails> currentUser = UserDetails().obs;
  late TextEditingController nameController;

  TextEditingController passwordController = TextEditingController();
  RxString age = '0'.obs;
  String gender = 'Female', dob = '0';
  RxString currentImage = ''.obs;
  String changedImage = '';
  bool imageUpdated = false, profileImageUpdated = false;
  RxBool isEditing = false.obs,
      recieveMatchAlert = true.obs,
      recieveMessageAlert = true.obs;
  bool changeMade = false, changeMadeOther = false;
  RxString prefferedGender = ''.obs;
  RxList<String> newProfileImages = <String>[].obs;
  RxMap<int, String> newProfileImagesMap = <int, String>{}.obs;
  // late AuthController _authController;
  final AuthController _authController = Get.find();

  // final getUserBox = GetStorage();
  @override
  void onInit() {
    setUserData();
    print('newProfileImagesMap  ${newProfileImagesMap.length}');
    super.onInit();
  }

  void setUserData() {
    // currentUser.value = _authController.currentUser.value;
    // prefferedGender.value = currentUser.value.prefferedGender!;
    // currentImage.value = currentUser.value.imageList
    //     .where((element) => element == currentUser.value.imageUrl)
    //     .first;
    // changedImage = currentImage.value;
    // nameController = TextEditingController(text: currentUser.value.name);
    // dob = currentUser.value.age!;
    // age.value = calculateAge(currentUser.value.age!);
    // gender = currentUser.value.gender!;
    // recieveMatchAlert.value = currentUser.value.recieveMatchNotification;
    // recieveMessageAlert.value = currentUser.value.recieveMessageNotification;
    // currentUser.value.imageList.forEach((element) {
    //   newProfileImagesMap
    //       .addAll({currentUser.value.imageList.indexOf(element): element});
    // });
    // _authController.currentUser.listen((user) {
    //   currentUser.value = user;
    //   if (!listEquals(user.imageList, newProfileImagesMap.values.toList())) {
    //     newProfileImagesMap.clear();
    //     user.imageList.forEach((element) {
    //       newProfileImagesMap
    //           .addAll({user.imageList.indexOf(element): element});
    //     });
    //   }
    // });
  }

  showStillEditingSnackBar() {
    // checkChangeMade();
    if (isEditing.value == true && changeMade == true) {
      Get.snackbar(
        'Still Editing',
        'Please save your changes before leaving',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appRed,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        borderColor: Colors.red,
        borderWidth: 1,
      );
    }
  }

  updatedEditing() {
    if (isEditing.value == true) {
      isEditing.value = false;
      Get.focusScope!.unfocus();
      updateUser();
    } else {
      isEditing.value = true;
    }
  }

  checkChangeMade() {
    final user = currentUser.value;
    // if (prefferedGender.value != user.prefferedGender ||
    //     dob != user.age! ||
    //     nameController.text != user.name ||
    //     gender != user.gender ||
    //     recieveMatchAlert.value != user.recieveMatchNotification ||
    //     recieveMessageAlert.value != user.recieveMessageNotification ||
    //     !listEquals(
    //         currentUser.value.imageList, newProfileImagesMap.values.toList()) ||
    //     imageUpdated == true ||
    //     profileImageUpdated == true) {
    //   changeMade = true;
    //   currentUser.value.prefferedGender = prefferedGender.value;
    //   currentUser.value.age = dob;
    //   currentUser.value.name = nameController.text;
    //   currentUser.value.gender = gender;
    //   currentUser.value.recieveMatchNotification = recieveMatchAlert.value;
    //   currentUser.value.recieveMessageNotification = recieveMessageAlert.value;
    // } else {
    //   changeMade = false;
    // }
  }

  updateGender(String value) {
    gender = value;
  }

  updateAge(String value) {
    dob = value;
    age.value = calculateAge(value);
  }

  updatedPrefferedGender() {
    // prefferedGender.value = prefferedGender.value == 'Male' ? 'Female' : 'Male';
    // if (prefferedGender.value == currentUser.value.prefferedGender) {
    //   changeMadeOther = false;
    // } else {
    //   changeMadeOther = true;
    // }
  }

  checkChangeMadeOther() {
    // final user = currentUser.value;
    // if (prefferedGender.value != user.prefferedGender ||
    //     recieveMatchAlert.value != user.recieveMatchNotification ||
    //     recieveMessageAlert.value != user.recieveMessageNotification) {
    //   changeMadeOther = true;
    //   currentUser.value.prefferedGender = prefferedGender.value;
    //   currentUser.value.recieveMatchNotification = recieveMatchAlert.value;
    //   currentUser.value.recieveMessageNotification = recieveMessageAlert.value;
    // } else {
    //   changeMadeOther = false;
    // }
  }

  updateUserOther() async {
    checkChangeMadeOther();
    if (changeMadeOther == true) {
      await _authenticationService.updateUserDataOther(currentUser.value);
    }
  }

  changeImage(String image) {
    currentImage.value = image;
    if (changedImage != currentImage.value) {
      profileImageUpdated = true;
    }
  }

  updateMatchNotificationSetting(val) {
    recieveMatchAlert.value = val;
  }

  updateMessageNotificationSetting(val) {
    recieveMessageAlert.value = val;
  }

  pickImage({int? index, bool isMain = false}) async {
    print('$index');
    final result = await Get.dialog(ImageService(
      isSignUp: true,
    ));
    if (result != null) {
      imageUpdated = true;
      newProfileImagesMap[index ?? (newProfileImagesMap.length + 1)] = result;
      if (isMain == true) {
        currentImage.value = result;
        profileImageUpdated = true;
      }
    }
  }

  updateUser() async {
    checkChangeMade();
    if (changeMade && useCheckInternet()) {
      await _authenticationService.updateUserData(currentUser.value,
          imageUpdated: imageUpdated,
          profileImageUpdated: profileImageUpdated,
          images: newProfileImagesMap,
          path: currentImage.value);
      imageUpdated = false;
      profileImageUpdated = false;
      successSnackbar(msg: 'Profile updated', title: 'Success');
    }
  }

  Future<void> logout() async => await _authenticationService.logout();

  goBack() {
    Get.back();
  }

  goToNotification() {
    Get.to(() => NotificationSetting(),
        fullscreenDialog: true, binding: EditProfileBinding());
  }

  goToAccountSettings() {
    Get.to(() => AccountSetting(),
        fullscreenDialog: true, binding: EditProfileBinding());
  }

  void openPrivacyUrl() async {
    final _url =
        'https://www.termsfeed.com/live/d09881da-f8c9-443a-b57f-59a72116b69b';

    Get.to(
      () => TermsAndPrivacy(
        content: _url,
      ),
      fullscreenDialog: true,
    );
  }

  void openTermsUrl() async {
    final _url = 'https://www.websitepolicies.com/policies/view/HkKXJu8M';
    Get.to(
      () => TermsAndPrivacy(
        content: _url,
      ),
      fullscreenDialog: true,
    );
  }

  Future<void> showConfirmationDialog() async {
    //TODO: Add a confirmation dialog
    
    // RxBool delete = false.obs;
    // final isFacebook = _authenticationService.providerIsFacebook();
    // Get.dialog(
    //   AlertDialog(
    //     title: Text(
    //       'Are you sure you want to delete your account?',
    //       style: TextStyle(
    //         fontSize: 15.5,
    //         fontFamily: 'Poppins',
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //     content: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(
    //           'Deleting your account will remove all your information from our database. This cannot be undone',
    //           style: TextStyle(
    //             fontSize: 15,
    //             fontFamily: 'Poppins',
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         heightMin(size: 1),
    //         Text(
    //           isFacebook
    //               ? "Type 'Delete' in the box to continue"
    //               : 'Enter your password to continue',
    //           style: TextStyle(
    //             fontSize: 14.5,
    //             fontFamily: 'Poppins',
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         heightMin(size: 1),
    //         SizedBox(
    //           height: 50,
    //           child: TextField(
    //             controller: passwordController,
    //             onChanged: (value) {
    //               if (value.length > 0 && !isFacebook ||
    //                   isFacebook && value.trim() == 'Delete') {
    //                 delete.value = true;
    //               } else {
    //                 delete.value = false;
    //               }
    //             },
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(
    //                 borderSide: BorderSide(
    //                   color: Colors.red,
    //                 ),
    //               ),
    //               hintText: 'Password',
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text('Cancel'),
    //         onPressed: () {
    //           passwordController.clear();
    //           Get.back();
    //         },
    //       ),
    //       Obx(() => IgnorePointer(
    //             ignoring: delete.value == false,
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 primary: delete.value ? Colors.red : Colors.grey[400],
    //               ),
    //               child: Text(
    //                 'Delete',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onPressed: () {
    //                 if (useCheckInternet()) {
    //                   Get.back();

    //                   deleteAccount(
    //                       password:
    //                           !isFacebook ? passwordController.text : null);
    //                 }
    //               },
    //             ),
    //           )),
    //     ],
    //   ),
    // );
  
  }

  void deleteAccount({String? password}) async {
    _authenticationService.deleteAccount(password: password);
  }
}
