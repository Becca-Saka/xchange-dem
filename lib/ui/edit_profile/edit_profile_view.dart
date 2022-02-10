import 'dart:io';
import 'package:xchange/barrel.dart';
import 'package:xchange/ui/edit_profile/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);
  bool isSmall = false, isLarge = false, isMedium = false;
  @override
  Widget build(BuildContext context) {
    isSmall = MySize.isSmall(context);
    isMedium = MySize.isMedium(context);
    isLarge = MySize.isLarge(context);
    return WillPopScope(
      onWillPop: () async {
        controller.updateUserOther();
        controller.checkChangeMade();
        controller.showStillEditingSnackBar();
        return controller.isEditing.value == true && controller.changeMade
            ? false
            : true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(
              () => Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                      
                        // Padding(
                        //     padding: const EdgeInsets.only(
                        //       left: 15,
                        //       right: 15,
                        //       top: 35,
                        //     ),
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       width: double.infinity,
                        //       decoration: BoxDecoration(
                        //           color: appGrey.withOpacity(0.3),
                        //           borderRadius: BorderRadius.circular(50)),
                        //       child: Stack(
                        //         clipBehavior: Clip.none,
                        //         alignment: Alignment.topRight,
                        //         children: [
                        //           IgnorePointer(
                        //             ignoring: !controller.isEditing.value,
                        //             child: Padding(
                        //                 padding: EdgeInsets.only(
                        //                     top: isLarge ? 25 : 16,
                        //                     right: isLarge ? 34 : 25,
                        //                     left: isLarge ? 34 : 25,
                        //                     bottom: isLarge ? 27 : 18),
                        //                 child: Column(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         SizedBox(
                        //                           height: isSmall
                        //                               ? 140
                        //                               : MySize.yMargin(
                        //                                   isLarge ? 16 : 20),
                        //                           width: isSmall
                        //                               ? 90
                        //                               : MySize.xMargin(
                        //                                   isLarge ? 25 : 30),
                        //                           child: Card(
                        //                             elevation: 5,
                        //                             shape:
                        //                                 RoundedRectangleBorder(
                        //                                     borderRadius:
                        //                                         BorderRadius
                        //                                             .circular(
                        //                                                 20)),
                        //                             child: ClipRRect(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       20),
                        //                               child: AspectRatio(
                        //                                 aspectRatio: 4 / 3,
                        //                                 child: Hero(
                        //                                   tag: 'profile',
                        //                                   child: !controller
                        //                                           .currentUser
                        //                                           .value
                        //                                           .imageList
                        //                                           .contains(
                        //                                               controller
                        //                                                   .currentImage
                        //                                                   .value)
                        //                                       ? Image.file(
                        //                                           File(controller
                        //                                               .currentImage
                        //                                               .value),
                        //                                           fit: BoxFit
                        //                                               .contain,
                        //                                         )
                        //                                       : profilePicture(
                        //                                           controller
                        //                                               .currentImage
                        //                                               .value),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         widthMin(size: 2),
                        //                         Expanded(
                        //                           child: Container(
                        //                             height:
                        //                                 MySize.yMargin(isSmall
                        //                                     ? 25
                        //                                     : isLarge
                        //                                         ? 15
                        //                                         : 20),
                        //                             // height: isSmall
                        //                             //     ? 140
                        //                             //     : MySize.yMargin(
                        //                             //         isLarge ? 15 : 20),
                        //                             decoration: BoxDecoration(
                        //                                 color: Colors.white,
                        //                                 borderRadius:
                        //                                     BorderRadius
                        //                                         .circular(20)),
                        //                             child: Padding(
                        //                               padding: const EdgeInsets
                        //                                   .symmetric(
                        //                                 horizontal: 14,
                        //                               ).copyWith(
                        //                                   bottom:
                        //                                       isSmall ? 10 : 20,
                        //                                   top: 20),
                        //                               child: Column(
                        //                                 crossAxisAlignment:
                        //                                     CrossAxisAlignment
                        //                                         .start,
                        //                                 mainAxisAlignment:
                        //                                     MainAxisAlignment
                        //                                         .spaceBetween,
                        //                                 children: [
                        //                                   customTextField(
                        //                                       hintText: 'Name',
                        //                                       controller: controller
                        //                                           .nameController),
                        //                                   Padding(
                        //                                     padding:
                        //                                         const EdgeInsets
                        //                                                 .only(
                        //                                             left: 2,
                        //                                             right: 2,
                        //                                             bottom: 8),
                        //                                     child: Divider(),
                        //                                   ),
                        //                                   AgePicker(
                        //                                     initalAge:
                        //                                         controller
                        //                                             .age.value,
                        //                                     onPicked:
                        //                                         (String c) {
                        //                                       controller
                        //                                           .updateAge(c);
                        //                                     },
                        //                                   ),
                        //                                   Padding(
                        //                                     padding:
                        //                                         const EdgeInsets
                        //                                                 .only(
                        //                                             top: 4,
                        //                                             left: 2,
                        //                                             right: 2,
                        //                                             bottom: 4),
                        //                                     child: Divider(),
                        //                                   ),
                        //                                   GenderPicker(
                        //                                     initalGender:
                        //                                         controller
                        //                                             .gender,
                        //                                     onPicked: controller
                        //                                         .updateGender,
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     heightMin(size: 1),
                        //                     SizedBox(
                        //                         height: MySize.yMargin(21),
                        //                         child: Obx(
                        //                           () => Row(children: [
                        //                             ...controller
                        //                                 .newProfileImagesMap
                        //                                 .entries
                        //                                 .map((image) => cardWithStar(
                        //                                     image.value,
                        //                                     isNetwork: false,
                        //                                     index: controller
                        //                                         .newProfileImagesMap
                        //                                         .keys
                        //                                         .firstWhere(
                        //                                       (k) =>
                        //                                           controller
                        //                                                   .newProfileImagesMap[
                        //                                               k] ==
                        //                                           image.value,
                        //                                     ))),
                        //                             ...List.generate(
                        //                                 4 -
                        //                                     controller
                        //                                         .newProfileImagesMap
                        //                                         .length,
                        //                                 (index) => Visibility(
                        //                                     visible: (controller
                        //                                             .newProfileImagesMap
                        //                                             .length) !=
                        //                                         4,
                        //                                     child: cardWithStar(
                        //                                         '',
                        //                                         isPicking:
                        //                                             true))),
                        //                           ]),

                        //                           // () => ListView(
                        //                           //     physics:
                        //                           //         NeverScrollableScrollPhysics(),
                        //                           //     scrollDirection:
                        //                           //         Axis.horizontal,
                        //                           //     children: [
                        //                           //       ...controller
                        //                           //           .newProfileImagesMap
                        //                           //           .entries
                        //                           //           .map((image) => cardWithStar(
                        //                           //               image.value,
                        //                           //               isNetwork:
                        //                           //                   false,
                        //                           //               index: controller
                        //                           //                   .newProfileImagesMap
                        //                           //                   .keys
                        //                           //                   .firstWhere(
                        //                           //                 (k) =>
                        //                           //                     controller
                        //                           //                             .newProfileImagesMap[
                        //                           //                         k] ==
                        //                           //                     image
                        //                           //                         .value,
                        //                           //               ))),
                        //                           //       ...List.generate(
                        //                           //           4 -
                        //                           //               controller
                        //                           //                   .newProfileImagesMap
                        //                           //                   .length,
                        //                           //           (index) => Visibility(
                        //                           //               visible: (controller
                        //                           //                       .newProfileImagesMap
                        //                           //                       .length) !=
                        //                           //                   4,
                        //                           //               child: cardWithStar(
                        //                           //                   '',
                        //                           //                   isPicking:
                        //                           //                       true))),
                        //                           //     ]),
                        //                         ))
                        //                   ],
                        //                 )),
                        //           ),
                        //           Positioned(
                        //             right: -5,
                        //             top: isSmall ? -4 : -6,
                        //             child: InkWell(
                        //               onTap: controller.updatedEditing,
                        //               child: SizedBox(
                        //                 height:
                        //                     MySize.xMargin(isLarge ? 6 : 10),
                        //                 width: MySize.xMargin(isLarge ? 6 : 10),
                        //                 child: AnimatedSwitcher(
                        //                     duration: const Duration(
                        //                         milliseconds: 500),
                        //                     transitionBuilder: (Widget child,
                        //                         Animation<double> animation) {
                        //                       return ScaleTransition(
                        //                           child: child,
                        //                           scale: animation);
                        //                     },
                        //                     child: Image.asset(controller
                        //                             .isEditing.value
                        //                         ? 'assets/images/Complete.png'
                        //                         : 'assets/images/Edit.png')),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                       
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: controller.updatedPrefferedGender,
                                title: Text(
                                  'Gender to be matched with?',
                                  style: TextStyle(
                                    fontSize: MySize.textSize(isLarge ? 3 : 4),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  'Tap to change',
                                  style: TextStyle(
                                    fontSize: MySize.textSize(isLarge ? 3 : 4),
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: SizedBox(
                                  height: MySize.xMargin(10),
                                  width: MySize.xMargin(10),
                                  child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                            child: child, scale: animation);
                                      },
                                      child: Image.asset(controller
                                                  .prefferedGender.value ==
                                              'Male'
                                          ? 'assets/images/Gender Male.png'
                                          : 'assets/images/Gender Female.png')),
                                ),
                              ),
                              heightMin(size: 2),
                              Divider(
                                thickness: 1.2,
                              ),
                              InkWell(
                                onTap: controller.goToNotification,
                                child: Container(
                                  height: MySize.yMargin(4),
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Notifications',
                                    style: TextStyle(
                                      fontSize:
                                          MySize.textSize(isLarge ? 3 : 4),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.2,
                              ),
                              InkWell(
                                onTap: controller.goToAccountSettings,
                                child: Container(
                                  height: MySize.yMargin(4),
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Account Settings',
                                    style: TextStyle(
                                      fontSize:
                                          MySize.textSize(isLarge ? 3 : 4),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.2,
                              ),
                              InkWell(
                                onTap: controller.logout,
                                child: Container(
                                  height: MySize.yMargin(4),
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Signout',
                                    style: TextStyle(
                                      fontSize:
                                          MySize.textSize(isLarge ? 3 : 4),
                                      fontFamily: 'Poppins',
                                      color: appColor.withOpacity(0.8),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightMin(size: isSmall ? 10 : 0),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Container(
                          height: MySize.xMargin(15),
                          width: double.infinity,
                          color: Colors.white,
                          child: InkWell(
                              onTap: () {
                                controller.checkChangeMade();
                                if (controller.isEditing.value == true &&
                                    controller.changeMade == true) {
                                  controller.showStillEditingSnackBar();
                                } else {
                                  controller.goBack();
                                }
                                // return controller.closePage();
                              },
                              child:
                                  Image.asset('assets/images/Close Icon.png')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Expanded cardWithStar(String image,
      {bool isNetwork = true, bool isPicking = false, int? index}) {
    bool isMain = image == controller.currentImage.value;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              controller.pickImage(
                  index: isPicking ? null : index, isMain: isMain);
            },
            child: SizedBox(
              height: MySize.yMargin(15),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.add)
                    // : ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: controller.currentUser.value.imageList
                    //             .contains(image)
                    //         ? profilePicture(image)
                    //         : Image.file(
                    //             File(image),
                    //             fit: BoxFit.cover,
                    //           )),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (isPicking == false) {
                controller.changeImage(image);
              }
            },
            child: Icon(
              Icons.star,
              size: MySize.xMargin(8),
              color: isMain ? appOrange : appGrey,
            ),
          )
        ],
      ),
    );
  }
}

// class EditProfileView extends GetView<EditProfileController> {
//   EditProfileView({Key? key}) : super(key: key);
//   bool isSmall = false, isLarge = false, isMedium = false;

//   Size size = Size(0, 0);
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         controller.updateUserOther();
//         controller.checkChangeMade();
//         controller.showStillEditingSnackBar();
//         return controller.isEditing.value == true && controller.changeMade
//             ? false
//             : true;
//       },
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: Obx(
//               () => Stack(
//                 fit: StackFit.expand,
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.only(
//                               left: 15,
//                               right: 15,
//                               top: 35,
//                             ),
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   color: appGrey.withOpacity(0.3),
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: Stack(
//                                 clipBehavior: Clip.none,
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   IgnorePointer(
//                                     ignoring: !controller.isEditing.value,
//                                     child: Padding(
//                                         padding: EdgeInsets.only(
//                                             top: 16,
//                                             right: 25,
//                                             left: 25,
//                                             bottom: 18),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height:
//                                                       size.height / 100 * 20.h,
//                                                   width:
//                                                       size.width / 100 * 30.w,
//                                                   child: Card(
//                                                     elevation: 5,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20)),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20),
//                                                       child: AspectRatio(
//                                                         aspectRatio: 4 / 3,
//                                                         child: Hero(
//                                                           tag: 'profile',
//                                                           child: !controller
//                                                                   .currentUser
//                                                                   .value
//                                                                   .imageList
//                                                                   .contains(
//                                                                       controller
//                                                                           .currentImage
//                                                                           .value)
//                                                               ? Image.file(
//                                                                   File(controller
//                                                                       .currentImage
//                                                                       .value),
//                                                                   fit: BoxFit
//                                                                       .contain,
//                                                                 )
//                                                               : profilePicture(
//                                                                   controller
//                                                                       .currentImage
//                                                                       .value),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 widthMini(size: 12.w),
//                                                 Expanded(
//                                                   child: Container(
//                                                     height: size.height /
//                                                         100 *
//                                                         20.h,
//                                                     decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20)),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                         vertical: 20,
//                                                         horizontal: 14,
//                                                       ),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           customTextField(
//                                                               hintText: 'Name',
//                                                               controller: controller
//                                                                   .nameController),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     left: 2,
//                                                                     right: 2,
//                                                                     bottom: 8),
//                                                             child: Divider(),
//                                                           ),
//                                                           AgePicker(
//                                                             initalAge:
//                                                                 controller
//                                                                     .age.value,
//                                                             onPicked:
//                                                                 (String c) {
//                                                               controller
//                                                                   .updateAge(c);
//                                                             },
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     top: 4,
//                                                                     left: 2,
//                                                                     right: 2,
//                                                                     bottom: 4),
//                                                             child: Divider(),
//                                                           ),
//                                                           GenderPicker(
//                                                             initalGender:
//                                                                 controller
//                                                                     .gender,
//                                                             onPicked: controller
//                                                                 .updateGender,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             heightMini(size: 8),
//                                             SizedBox(
//                                                 height:
//                                                     size.height / 100 * 21.h,
//                                                 child: Obx(
//                                                   () => ListView(
//                                                       physics:
//                                                           NeverScrollableScrollPhysics(),
//                                                       scrollDirection:
//                                                           Axis.horizontal,
//                                                       children: [
//                                                         ...controller
//                                                             .newProfileImagesMap
//                                                             .entries
//                                                             .map((image) => cardWithStar(
//                                                                 image.value,
//                                                                 isNetwork:
//                                                                     false,
//                                                                 index: controller
//                                                                     .newProfileImagesMap
//                                                                     .keys
//                                                                     .firstWhere(
//                                                                   (k) =>
//                                                                       controller
//                                                                               .newProfileImagesMap[
//                                                                           k] ==
//                                                                       image
//                                                                           .value,
//                                                                 ))),
//                                                         ...List.generate(
//                                                             4 -
//                                                                 controller
//                                                                     .newProfileImagesMap
//                                                                     .length,
//                                                             (index) => Visibility(
//                                                                 visible: (controller
//                                                                         .newProfileImagesMap
//                                                                         .length) !=
//                                                                     4,
//                                                                 child: cardWithStar(
//                                                                     '',
//                                                                     isPicking:
//                                                                         true))),
//                                                       ]),
//                                                 ))
//                                           ],
//                                         )),
//                                   ),
//                                   Positioned(
//                                     right: -5,
//                                     top: -6,
//                                     child: InkWell(
//                                       onTap: controller.updatedEditing,
//                                       child: SizedBox(
//                                         height: size.width / 100 * 10.w,
//                                         width: size.width / 100 * 10.w,
//                                         child: AnimatedSwitcher(
//                                             duration: const Duration(
//                                                 milliseconds: 500),
//                                             transitionBuilder: (Widget child,
//                                                 Animation<double> animation) {
//                                               return ScaleTransition(
//                                                   child: child,
//                                                   scale: animation);
//                                             },
//                                             child: Image.asset(controller
//                                                     .isEditing.value
//                                                 ? 'assets/images/Complete.png'
//                                                 : 'assets/images/Edit.png')),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 40.0, vertical: 25),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 onTap: controller.updatedPrefferedGender,
//                                 title: Text(
//                                   'Gender to be matched with?',
//                                   style: TextStyle(
//                                     fontSize: 15.7.sp,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   'Tap to change',
//                                   style: TextStyle(
//                                     fontSize: 15.7.sp,
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 trailing: SizedBox(
//                                   height: size.width / 100 * 10.w,
//                                   width: size.width / 100 * 10.w,
//                                   child: AnimatedSwitcher(
//                                       duration:
//                                           const Duration(milliseconds: 500),
//                                       transitionBuilder: (Widget child,
//                                           Animation<double> animation) {
//                                         return ScaleTransition(
//                                             child: child, scale: animation);
//                                       },
//                                       child: Image.asset(controller
//                                                   .prefferedGender.value ==
//                                               'Male'
//                                           ? 'assets/images/Gender Male.png'
//                                           : 'assets/images/Gender Female.png')),
//                                 ),
//                               ),
//                               heightMini(size: 18.h),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.goToNotification,
//                                 child: Container(
//                                   height: 35.h,
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Notifications',
//                                     style: TextStyle(
//                                       fontSize: 15.7.sp,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.goToAccountSettings,
//                                 child: Container(
//                                   height: 35.h,
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Account Settings',
//                                     style: TextStyle(
//                                       fontSize: 15.7.sp,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.logout,
//                                 child: Container(
//                                   height: 35.h,
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Signout',
//                                     style: TextStyle(
//                                       fontSize: 15.7.sp,
//                                       fontFamily: 'Poppins',
//                                       color: appRed.withOpacity(0.8),
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         heightMini(size: 5.h),
//                       ],
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 1.0),
//                         child: Container(
//                           height: size.width / 100 * 15.w,
//                           width: double.infinity,
//                           color: Colors.white,
//                           child: InkWell(
//                               onTap: () {
//                                 controller.checkChangeMade();
//                                 if (controller.isEditing.value == true &&
//                                     controller.changeMade == true) {
//                                   controller.showStillEditingSnackBar();
//                                 } else {
//                                   controller.goBack();
//                                 }
//                               },
//                               child:
//                                   Image.asset('assets/images/Close Icon.png')),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

//   Column cardWithStar(String image,
//       {bool isNetwork = true, bool isPicking = false, int? index}) {
//     bool isMain = image == controller.currentImage.value;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           onTap: () {
//             controller.pickImage(
//                 index: isPicking ? null : index, isMain: isMain);
//           },
//           child: SizedBox(
//             width: size.width / 100 * 19.5.w,
//             height: size.height / 100 * 15.h,
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               child: isPicking
//                   ? Icon(Icons.add)
//                   : ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child:
//                           controller.currentUser.value.imageList.contains(image)
//                               ? profilePicture(image)
//                               : Image.file(
//                                   File(image),
//                                   fit: BoxFit.cover,
//                                 )),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (isPicking == false) {
//               controller.changeImage(image);
//             }
//           },
//           child: Icon(
//             Icons.star,
//             size: size.width / 100 * 8.w,
//             color: isMain ? appOrange : appGrey,
//           ),
//         )
//       ],
//     );
//   }
// }



// class EditProfileView extends GetView<EditProfileController> {
//   EditProfileView({Key? key}) : super(key: key);
//   bool isSmall = false, isLarge = false, isMedium = false;
//   @override
//   Widget build(BuildContext context) {
//     isSmall = MySize.isSmall(context);
//     isMedium = MySize.isMedium(context);
//     isLarge = MySize.isLarge(context);
//     return WillPopScope(
//       onWillPop: () async {
//         controller.updateUserOther();
//         controller.checkChangeMade();
//         controller.showStillEditingSnackBar();
//         return controller.isEditing.value == true && controller.changeMade
//             ? false
//             : true;
//       },
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: Obx(
//               () => Stack(
//                 fit: StackFit.expand,
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.only(
//                               left: 15,
//                               right: 15,
//                               top: 35,
//                             ),
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   color: appGrey.withOpacity(0.3),
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: Stack(
//                                 clipBehavior: Clip.none,
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   IgnorePointer(
//                                     ignoring: !controller.isEditing.value,
//                                     child: Padding(
//                                         padding: EdgeInsets.only(
//                                             top: isLarge ? 25 : 16,
//                                             right: isLarge ? 34 : 25,
//                                             left: isLarge ? 34 : 25,
//                                             bottom: isLarge ? 27 : 18),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: isSmall
//                                                       ? 140
//                                                       : MySize.yMargin(
//                                                           isLarge ? 16 : 20),
//                                                   width: isSmall
//                                                       ? 90
//                                                       : MySize.xMargin(
//                                                           isLarge ? 25 : 30),
//                                                   child: Card(
//                                                     elevation: 5,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20)),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20),
//                                                       child: AspectRatio(
//                                                         aspectRatio: 4 / 3,
//                                                         child: Hero(
//                                                           tag: 'profile',
//                                                           child: !controller
//                                                                   .currentUser
//                                                                   .value
//                                                                   .imageList
//                                                                   .contains(
//                                                                       controller
//                                                                           .currentImage
//                                                                           .value)
//                                                               ? Image.file(
//                                                                   File(controller
//                                                                       .currentImage
//                                                                       .value),
//                                                                   fit: BoxFit
//                                                                       .contain,
//                                                                 )
//                                                               : profilePicture(
//                                                                   controller
//                                                                       .currentImage
//                                                                       .value),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 widthMin(size: 2),
//                                                 Expanded(
//                                                   child: Container(
//                                                     height: isSmall
//                                                         ? 140
//                                                         : MySize.yMargin(
//                                                             isLarge ? 15 : 20),
//                                                     decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20)),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                         vertical: 20,
//                                                         horizontal: 14,
//                                                       ),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           customTextField(
//                                                               hintText: 'Name',
//                                                               controller: controller
//                                                                   .nameController),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     left: 2,
//                                                                     right: 2,
//                                                                     bottom: 8),
//                                                             child: Divider(),
//                                                           ),
//                                                           AgePicker(
//                                                             initalAge:
//                                                                 controller
//                                                                     .age.value,
//                                                             onPicked:
//                                                                 (String c) {
//                                                               controller
//                                                                   .updateAge(c);
//                                                             },
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     top: 4,
//                                                                     left: 2,
//                                                                     right: 2,
//                                                                     bottom: 4),
//                                                             child: Divider(),
//                                                           ),
//                                                           GenderPicker(
//                                                             initalGender:
//                                                                 controller
//                                                                     .gender,
//                                                             onPicked: controller
//                                                                 .updateGender,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             heightMin(size: 1),
//                                             SizedBox(
//                                                 height: MySize.yMargin(21),
//                                                 child: Obx(
//                                                   () => ListView(
//                                                       physics:
//                                                           NeverScrollableScrollPhysics(),
//                                                       scrollDirection:
//                                                           Axis.horizontal,
//                                                       children: [
//                                                         ...controller
//                                                             .newProfileImagesMap
//                                                             .entries
//                                                             .map((image) => cardWithStar(
//                                                                 image.value,
//                                                                 isNetwork:
//                                                                     false,
//                                                                 index: controller
//                                                                     .newProfileImagesMap
//                                                                     .keys
//                                                                     .firstWhere(
//                                                                   (k) =>
//                                                                       controller
//                                                                               .newProfileImagesMap[
//                                                                           k] ==
//                                                                       image
//                                                                           .value,
//                                                                 ))),
//                                                         ...List.generate(
//                                                             4 -
//                                                                 controller
//                                                                     .newProfileImagesMap
//                                                                     .length,
//                                                             (index) => Visibility(
//                                                                 visible: (controller
//                                                                         .newProfileImagesMap
//                                                                         .length) !=
//                                                                     4,
//                                                                 child: cardWithStar(
//                                                                     '',
//                                                                     isPicking:
//                                                                         true))),
//                                                       ]),
//                                                 ))
//                                           ],
//                                         )),
//                                   ),
//                                   Positioned(
//                                     right: -5,
//                                     top: isSmall ? -4 : -6,
//                                     child: InkWell(
//                                       onTap: controller.updatedEditing,
//                                       child: SizedBox(
//                                         height:
//                                             MySize.xMargin(isLarge ? 6 : 10),
//                                         width: MySize.xMargin(isLarge ? 6 : 10),
//                                         child: AnimatedSwitcher(
//                                             duration: const Duration(
//                                                 milliseconds: 500),
//                                             transitionBuilder: (Widget child,
//                                                 Animation<double> animation) {
//                                               return ScaleTransition(
//                                                   child: child,
//                                                   scale: animation);
//                                             },
//                                             child: Image.asset(controller
//                                                     .isEditing.value
//                                                 ? 'assets/images/Complete.png'
//                                                 : 'assets/images/Edit.png')),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 40.0, vertical: 25),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 onTap: controller.updatedPrefferedGender,
//                                 title: Text(
//                                   'Gender to be matched with?',
//                                   style: TextStyle(
//                                     fontSize: MySize.textSize(isLarge ? 3 : 4),
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   'Tap to change',
//                                   style: TextStyle(
//                                     fontSize: MySize.textSize(isLarge ? 3 : 4),
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 trailing: SizedBox(
//                                   height: MySize.xMargin(10),
//                                   width: MySize.xMargin(10),
//                                   child: AnimatedSwitcher(
//                                       duration:
//                                           const Duration(milliseconds: 500),
//                                       transitionBuilder: (Widget child,
//                                           Animation<double> animation) {
//                                         return ScaleTransition(
//                                             child: child, scale: animation);
//                                       },
//                                       child: Image.asset(controller
//                                                   .prefferedGender.value ==
//                                               'Male'
//                                           ? 'assets/images/Gender Male.png'
//                                           : 'assets/images/Gender Female.png')),
//                                 ),
//                               ),
//                               heightMin(size: 2),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.goToNotification,
//                                 child: Container(
//                                   height: MySize.yMargin(4),
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Notifications',
//                                     style: TextStyle(
//                                       fontSize:
//                                           MySize.textSize(isLarge ? 3 : 4),
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.goToAccountSettings,
//                                 child: Container(
//                                   height: MySize.yMargin(4),
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Account Settings',
//                                     style: TextStyle(
//                                       fontSize:
//                                           MySize.textSize(isLarge ? 3 : 4),
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1.2,
//                               ),
//                               InkWell(
//                                 onTap: controller.logout,
//                                 child: Container(
//                                   height: MySize.yMargin(4),
//                                   width: double.infinity,
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Signout',
//                                     style: TextStyle(
//                                       fontSize:
//                                           MySize.textSize(isLarge ? 3 : 4),
//                                       fontFamily: 'Poppins',
//                                       color: appRed.withOpacity(0.8),
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         heightMin(size: isSmall ? 10 : 0),
//                       ],
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 1.0),
//                         child: Container(
//                           height: MySize.xMargin(15),
//                           width: double.infinity,
//                           color: Colors.white,
//                           child: InkWell(
//                               onTap: () {
//                                 controller.checkChangeMade();
//                                 if (controller.isEditing.value == true &&
//                                     controller.changeMade == true) {
//                                   controller.showStillEditingSnackBar();
//                                 } else {
//                                   controller.goBack();
//                                 }
//                                 // return controller.closePage();
//                               },
//                               child:
//                                   Image.asset('assets/images/Close Icon.png')),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

//   Column cardWithStar(String image,
//       {bool isNetwork = true, bool isPicking = false, int? index}) {
//     bool isMain = image == controller.currentImage.value;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           onTap: () {
//             controller.pickImage(
//                 index: isPicking ? null : index, isMain: isMain);
//           },
//           child: SizedBox(
//             width: MySize.xMargin(isLarge
//                 ? 22
//                 : isSmall
//                     ? 19
//                     : 19.5),
//             height: MySize.yMargin(15),
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               child: isPicking
//                   ? Icon(Icons.add)
//                   : ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child:
//                           controller.currentUser.value.imageList.contains(image)
//                               ? profilePicture(image)
//                               : Image.file(
//                                   File(image),
//                                   fit: BoxFit.cover,
//                                 )),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (isPicking == false) {
//               controller.changeImage(image);
//             }
//           },
//           child: Icon(
//             Icons.star,
//             size: MySize.xMargin(8),
//             color: isMain ? appOrange : appGrey,
//           ),
//         )
//       ],
//     );
//   }
// }
