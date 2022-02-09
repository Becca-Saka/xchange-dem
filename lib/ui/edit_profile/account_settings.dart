import 'package:xchange/barrel.dart';

import 'package:xchange/ui/edit_profile/edit_profile_controller.dart';
class AccountSetting extends StatelessWidget {
  AccountSetting({Key? key}) : super(key: key);

  final controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {

    final isLarge = MySize.isLarge(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: controller.goBack,
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
          heightMin(size: 0.5),
            InkWell(
              onTap: controller.openPrivacyUrl,
              child: Container(
                height: MySize.yMargin(4),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: MySize.textSize(isLarge ? 3 : 4),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
            ),
            heightMin(size: 0.5),
            InkWell(
              onTap: controller.openTermsUrl,
              child: Container(
                height: MySize.yMargin(isLarge ? 3 : 4),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: MySize.textSize(isLarge ? 3 : 4),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            heightMin(size: 0.5),
            Divider(
              thickness: 1.2,
            ),
            heightMin(size: 0.5),
            InkWell(
              onTap: controller.showConfirmationDialog,
              child: Container(
                height: MySize.yMargin(4),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: MySize.textSize(isLarge ? 3 : 4),
                    fontFamily: 'Poppins',
                    color: appRed.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

// class AccountSetting extends StatelessWidget {
//   AccountSetting({Key? key}) : super(key: key);

//   final controller = Get.put(EditProfileController());
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0.5,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: controller.goBack,
//             icon: Icon(
//               Icons.arrow_back_ios_sharp,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(children: [
//             heightMini(size: 12.h),
//             InkWell(
//               onTap: controller.openPrivacyUrl,
//               child: Container(
//                 height: 35.h,
//                 width: double.infinity,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Privacy Policy',
//                   style: TextStyle(
//                     fontSize: 15.7.sp,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             Divider(
//               thickness: 1.2,
//             ),
//             heightMini(size: 8.h),
//             InkWell(
//               onTap: controller.openTermsUrl,
//               child: Container(
//                 height: 35.h,
//                 width: double.infinity,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Terms of Service',
//                   style: TextStyle(
//                     fontSize: 15.7.sp,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             heightMini(size: 8.h),
//             Divider(
//               thickness: 1.2,
//             ),
//             heightMini(size: 8.h),
//             InkWell(
//               onTap: controller.showConfirmationDialog,
//               child: Container(
//                 height: 35.h,
//                 width: double.infinity,
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Delete Account',
//                   style: TextStyle(
//                     fontSize: 15.7.sp,
//                     fontFamily: 'Poppins',
//                     color: appRed.withOpacity(0.8),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ));
//   }
// }

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Privacy Policy for The Deck',
          style: TextStyle(
            fontSize: MySize.textSize(4),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: RichText(
            text: TextSpan(text: 'Privacy Policy', children: [
          // TextSpan(
        ])),
      ),
    );
  }
}
