import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xchange/app/barrel.dart';
import 'package:device_preview/device_preview.dart';
import 'package:xchange/data/services/sample_emulator.dart';

const USE_EMULATOR = true;

// Future _connectToFirebaseEmulator() async {
//   FirebaseFirestore.instance.settings = const Settings(
//     host: 'localhost:8080',
//     sslEnabled: false,
//     persistenceEnabled: false,
//   );

//   await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);

//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//   USE_EMULATOR = true;
// }
/// Connnect to the firebase emulator for Firestore and Authentication
Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_EMULATOR) {
    await _connectToFirebaseEmulator();
  }
  await GetStorage.init('userProfile');
  await GetStorage.init('userContactsBox');
  await AuthenticationService.to.checkLogin();

  if (USE_EMULATOR) {
    runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => 
        MyAppLarge(), // Wrap your app
      // ),
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
      useInheritedMediaQuery: true,
      home: LoadEmulatorDataView(),
    );
  }
}
