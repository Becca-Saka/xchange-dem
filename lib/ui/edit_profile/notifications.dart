import 'package:xchange/barrel.dart';
import 'package:xchange/ui/edit_profile/edit_profile_controller.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NotificationSetting extends StatelessWidget {
  NotificationSetting({Key? key}) : super(key: key);

  final controller = Get.find<EditProfileController>();
  bool isLarge = false, isMedium = false, isSmall = false;
  @override
  Widget build(BuildContext context) {
    isSmall = MySize.isSmall(context);
    isMedium = MySize.isMedium(context);
    isLarge = MySize.isLarge(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: controller.goBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightMin(size: 1),
                Text(
                  'Receive Notifications When You:',
                  style: TextStyle(
                    fontSize: MySize.textSize(isLarge ? 3.2 : 4.2),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightMin(size: 2),
                swicthItem(
                    onChanged: (val) {
                      controller.updateMatchNotificationSetting(val);
                    },
                    status: controller.recieveMatchAlert.value,
                    text: 'Receive a New Match'),
                heightMin(size: 1),
                Divider(
                  thickness: 1.2,
                ),
                heightMin(size: 1),
                swicthItem(
                    onChanged: (val) {
                      controller.updateMessageNotificationSetting(val);
                    },
                    status: controller.recieveMessageAlert.value,
                    text: 'Receive a Message'),
              ],
            )),
      ),
    );
  }

  Widget swicthItem(
      {required String text,
      required bool status,
      required Function(bool) onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: MySize.textSize(isLarge ? 3.5 : 4.5),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        FlutterSwitch(
          width: MySize.xMargin(isMedium
              ? 15
              : isSmall
                  ? 11
                  : 13),
          activeColor: appRed,
          height: MySize.yMargin(isMedium ? 3.2 : 3.5),
          value: status,
          toggleSize: MySize.xMargin(isMedium ? 6 : 5),
          borderRadius: 30.0,
          padding: 0.8,
          onToggle: onChanged,
        ),
      ],
    );
  }
}

// class NotificationSetting extends StatelessWidget {
//   NotificationSetting({Key? key}) : super(key: key);

//   final controller = Get.find<EditProfileController>();
//   bool isLarge = false, isMedium = false, isSmall = false;
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: controller.goBack,
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
//         child: Obx(() => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 heightMin(size: 1),
//                 Text(
//                   'Receive Notifications When You:',
//                   style: TextStyle(
//                     fontSize: 16.5.sp,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 heightMini(size: 12.h),
//                 swicthItem(
//                     onChanged: (val) {
//                       controller.updateMatchNotificationSetting(val);
//                     },
//                     status: controller.recieveMatchAlert.value,
//                     text: 'Receive a New Match'),
//                 heightMini(size: 8.h),
//                 Divider(
//                   thickness: 1.2,
//                 ),
//                 heightMin(size: 1),
//                 swicthItem(
//                     onChanged: (val) {
//                       controller.updateMessageNotificationSetting(val);
//                     },
//                     status: controller.recieveMessageAlert.value,
//                     text: 'Receive a Message'),
//               ],
//             )),
//       ),
//     );
//   }

//   Widget swicthItem(
//       {required String text,
//       required bool status,
//       required Function(bool) onChanged}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 17.5.sp,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         FlutterSwitch(
//           width: 60.w,
//           activeColor: appRed,
//           height: 28.h,
//           value: status,
//           toggleSize: 28.w,
//           borderRadius: 30.0,
//           padding: 0.8,
//           onToggle: onChanged,
//         ),
//       ],
//     );
//   }
// }


// class NotificationSetting extends StatelessWidget {
//   NotificationSetting({Key? key}) : super(key: key);

//   final controller = Get.find<EditProfileController>();
//   bool isLarge = false, isMedium = false, isSmall = false;
//   @override
//   Widget build(BuildContext context) {
//     isSmall = MySize.isSmall(context);
//     isMedium = MySize.isMedium(context);
//     isLarge = MySize.isLarge(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: controller.goBack,
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
//         child: Obx(() => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 heightMin(size: 1),
//                 Text(
//                   'Receive Notifications When You:',
//                   style: TextStyle(
//                     fontSize: MySize.textSize(isLarge ? 3.2 : 4.2),
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 heightMin(size: 2),
//                 swicthItem(
//                     onChanged: (val) {
//                       controller.updateMatchNotificationSetting(val);
//                     },
//                     status: controller.recieveMatchAlert.value,
//                     text: 'Receive a New Match'),
//                 heightMin(size: 1),
//                 Divider(
//                   thickness: 1.2,
//                 ),
//                 heightMin(size: 1),
//                 swicthItem(
//                     onChanged: (val) {
//                       controller.updateMessageNotificationSetting(val);
//                     },
//                     status: controller.recieveMessageAlert.value,
//                     text: 'Receive a Message'),
//               ],
//             )),
//       ),
//     );
//   }

//   Widget swicthItem(
//       {required String text,
//       required bool status,
//       required Function(bool) onChanged}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: MySize.textSize(isLarge ? 3.5 : 4.5),
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         FlutterSwitch(
//           width: MySize.xMargin(isMedium
//               ? 15
//               : isSmall
//                   ? 11
//                   : 13),
//           activeColor: appRed,
//           height: MySize.yMargin(isMedium ? 3.2 : 3.5),
//           value: status,
//           toggleSize: MySize.xMargin(isMedium ? 6 : 5),
//           borderRadius: 30.0,
//           padding: 0.8,
//           onToggle: onChanged,
//         ),
//       ],
//     );
//   }
// }
