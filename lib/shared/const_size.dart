import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySize {
   static bool isMini(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 480;
  }

  static bool isSmall(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return  screenHeight < 600;
  }

  static bool isMedium(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight >= 600 && screenHeight < 900;
  }

  static bool isLarge(context) {
    double screenHeight = MediaQuery.of(context).size.width;
    return screenHeight >= 600;
  }

  // static bool isMini(context) {
  //   double screenHeight = MediaQuery.of(context).size.width;
  //   return screenHeight < 320;
  // }

  // static bool isSmall(context) {
  //   double screenHeight = MediaQuery.of(context).size.width;
  //   return screenHeight >= 320 && screenHeight < 360;
  // }

  // static bool isMedium(context) {
  //   double screenHeight = MediaQuery.of(context).size.width;
  //   return screenHeight >= 360 && screenHeight < 600;
  // }

  // static bool isLarge(context) {
  //   double screenHeight = MediaQuery.of(context).size.width;
  //   return screenHeight >= 600;
  // }

  static double scaledSize(bool isSmall, bool isMedium, double size) {
    return isSmall ? size : (isMedium ? size * 1.1 : size * 1.5);
  }

  static double yMargin(double height) {
    double screenHeight = MediaQuery.of(Get.context!).size.height / 100;
    return height * screenHeight;
  }

  static double xMargin(double width) {
    double screenWidth = MediaQuery.of(Get.context!).size.width / 100;
    return width * screenWidth;
  }

  static double textSize(double textSize) {
    double screenWidth = MediaQuery.of(Get.context!).size.width / 100;
    double screenHeight = MediaQuery.of(Get.context!).size.height / 100;
    if (screenWidth > screenHeight) return textSize * screenHeight;
    return textSize * screenWidth;
  }
}
