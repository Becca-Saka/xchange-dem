import 'dart:math' as math;
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xchange/app/barrel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_preview/device_preview.dart';

const bool USE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('userProfile');
  await Firebase.initializeApp();
  await AuthenticationService.to.checkLogin();
  
  if (USE_EMULATOR) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyAppLarge(), // Wrap your app
      ),
    );
  } else {
    runApp(MyApp());
  }
}
//TODO: Update facebook configuration in ios

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      title: 'Xchange',
      theme: ThemeData(
        primaryColor: appColor,
        colorScheme: ColorScheme.light(primary: appColor),
        fontFamily: 'Mulish',
      ),
      // useInheritedMediaQuery: true, // Set to true
      // locale: DevicePreview.locale(context), //

      // builder: DevicePreview.appBuilder,
      // builder: (context, child) {
      //   return ConnectionWidget(
      //       dismissOfflineBanner: false,
      //       builder: (BuildContext context, bool isOnline) {
      //         return child!;
      //       });h
      // },
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}

class MyAppLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      title: 'The Deck',
      theme: ThemeData(
        primaryColor: appColor,
        colorScheme: ColorScheme.light(primary: appColor),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        fontFamily: 'Poppins',
      ),
      useInheritedMediaQuery: true, // Set to true
      locale: DevicePreview.locale(context), //

      builder: DevicePreview.appBuilder,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
