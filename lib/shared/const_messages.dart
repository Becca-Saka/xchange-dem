import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xchange/shared/const_color.dart';

 errorSnackbar({
  required String msg,
}) {
  return Get.snackbar('Error!', '$msg',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[700],
      colorText: Colors.white);
}

 successSnackbar({required String msg, required String title}) {
  return Get.snackbar('$title', '$msg',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white);
}

void showLoadingDialogWithText({required String msg}) {
  Get.dialog(
      SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(appColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$msg Please wait...',
              style: TextStyle(color: appColor),
            )
          ],
        ),
      ]),
      transitionCurve: Curves.easeIn);
}

void showLoadingDialog() {
  Get.dialog(
      SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(appColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ' Please wait...',
              style: TextStyle(color: appColor),
            )
          ],
        ),
      ]),
      transitionCurve: Curves.easeIn);
}
