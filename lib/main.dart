import 'dart:math' as math;
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:xchange/barrel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_preview/device_preview.dart';
import 'package:xchange/ui/authentication/phone_signup_view.dart';
const bool USE_EMULATOR = false;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(" message Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init('userProfile');
  
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
    return  GetMaterialApp(
              title: 'The Deck',
              theme: ThemeData(
                primaryColor: Color(0xffFF5757),
                colorScheme: ColorScheme.light(primary: appRed),
                fontFamily: 'Poppins',
              ),
              // useInheritedMediaQuery: true, // Set to true
              // locale: DevicePreview.locale(context), //

              // builder: DevicePreview.appBuilder,
              // builder: (context, child) {
              //   return ConnectionWidget(
              //       dismissOfflineBanner: false,
              //       builder: (BuildContext context, bool isOnline) {
              //         return child!;
              //       });
              // },
              home: PhoneSignUp(),
              // initialRoute: AppPages.INITIAL,
              // getPages: AppPages.routes,
            );
  }
}

class MyAppLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return  GetMaterialApp(
              title: 'The Deck',
              theme: ThemeData(
                primaryColor: Color(0xffFF5757),
                colorScheme: ColorScheme.light(primary: appRed),
                fontFamily: 'Poppins',
              ),
              useInheritedMediaQuery: true, // Set to true
              locale: DevicePreview.locale(context), //

              builder: DevicePreview.appBuilder,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            );
  }
}

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('data'),
          onPressed: () async {
            // await login();
            // loadCSV();
            // deleteCSV();
            // loadCSVTwo();
          },
        ),
      ),
    );
  }

  String readTimeStampDaysOnly(DateTime timeStamp) {
    var now = DateTime.now();
    var diff = now.difference(timeStamp);
    var time = '';
    if (diff.inDays <= 1) {
      time = 'Today';
    } else if (diff.inDays > 1 && diff.inDays < 2) {
      time = 'Yesterday';
    } else {
      time = '${DateFormat.yMMMd().format(timeStamp)}';
    }
    return time;
  }

  login() async {
    await AuthenticationService().loginSamp();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // This function is triggered when the floating button is pressed
  // void deleteCSV() async {
  //   final doc = await firestore.collection("Users").get();
  //   List<UserDetails> result = doc.docs
  //       .map<UserDetails>((e) => UserDetails.fromJson(e.data()))
  //       .toList();
  //   result.removeWhere(
  //       (element) => element.uid == FirebaseAuth.instance.currentUser?.uid);
  //   result.removeWhere(
  //       (element) => element.uid == 'p2IhXOhlUGRCCsQwI0bTSLq3ain2');
  //   result.forEach((element) async {
  //     await firestore.collection("Users").doc(element.uid).delete();
  //   });
  // }

  List<UserDetails> added = [];
  bool getDistanceDiffy(
      double userlat, double userlong, double lat, double long, diff) {
    // log('message p');
    final getDistanceDiff =
        Geolocator.distanceBetween(userlat, userlong, lat, long);
    final distanceInKM = getDistanceDiff / 50000;
    // final distanceInKM = getDistanceDiff / 1000;
    // if (distanceInKM <= 500) {
    //   log('message $distanceInKM');
    // }
    return distanceInKM <= diff;
  }

//   void loadCSVTwo() async {
//     try {
//       final user = (await FirebaseFirestore.instance.collection('Users').get())
//           .docs
//           .map((e) => UserDetails.fromJson(e.data()))
//           .toList();
//       await doMatch(user.first, user.last);
//  } catch (e) {
//       log('Error $e');
//     }
//   }

  // doMatch(UserDetails first, UserDetails second) async {
  //   final deckRef = firestore.collection("Decks").doc();
  //   final userCollection = firestore.collection("Users");
  //   var firstid = first.uid;
  //   var secondid = second.uid;
  //   final now = Timestamp.now();
  //   var newStatus = {};
  //   newStatus[firstid] = true;
  //   newStatus[secondid] = true;
  //   await deckRef.set({
  //     "timeMatched": now,
  //     "isNew": newStatus,
  //     "uid": deckRef.id,
  //     "users": [secondid, firstid],
  //   });
  //   first.lastMatchedTime = now;
  //   first.currentMatches!.add(secondid!);
  //   first.currentDeck!.add(deckRef.id);
  //   first.noOfCurrentMatches = first.currentMatches!.length;
  //   if (!first.previousMatches.contains(firstid)) {
  //     first.previousMatches.add(secondid);
  //   }
  //   second.lastMatchedTime = now;
  //   second.currentMatches!.add(firstid!);
  //   second.currentDeck!.add(deckRef.id);
  //   second.noOfCurrentMatches = second.currentMatches!.length;
  //   if (!second.previousMatches.contains(firstid)) {
  //     second.previousMatches.add(firstid);
  //   }

  //   await userCollection.doc(firstid).update(first.toJson());

  //   await userCollection.doc(secondid).update(second.toJson());
  //   const messageData = {};
  //   messageData["title"] = "The Deck";
  //   messageData["body"] = "You have a new match";
  // }

  // void loadCSV() async {
  //   try {
  //     // await login();
  //     List<UserDetails> valid = [];
  //     print('object');
  //     final _rawData = await rootBundle.loadString("assets/json/THe deck.json");
  //     final List data = await json.decode(_rawData);

  //     List<UserDetails> res =
  //         data.map((item) => new UserDetails.fromJson(item)).toList();
  //     res.shuffle();

  //     res.forEach((element) {
  //       final ty = DateTime.now().subtract(Duration(hours: 8));
  //       final tx = Timestamp.fromDate(ty);
  //       element.lastMatchedTime = tx;
  //       element.openToMatch = true;
  //     });
  //     res = res
  //         .where((element) => formatDate(element.lastMatchedTime) >= 8)
  //         .toList();

  //     log('here' + res.length.toString());

  //     final tempCurrentUsery = res[math.Random().nextInt(res.length)];

  //     print('object t');
  //     res.forEach((user) {
  //       if (getDistanceDiffy(tempCurrentUsery.lat!, tempCurrentUsery.long!,
  //           user.lat!, user.long!, 500)) {
  //         valid.add(user);
  //       }
  //     });

  //     log('${valid.length}');

  //     valid.shuffle();
  //     // final tempindex =
  //     //     tt.indexWhere((element) => element.uid == tempCurrentUsery.uid);
  //     final tempCurrentUser = tempCurrentUsery;
  //     valid.removeWhere((element) =>
  //         element.uid == tempCurrentUser.uid &&
  //         element.name == tempCurrentUser.name);

  //     final finalList = valid.take(19).toList();

  //     // final tempCurrentUspgone =
  //     //     finalList[math.Random().nextInt(finalList.length)];
  //     // finalList.removeWhere((element) =>
  //     //     element.uid == tempCurrentUspgone.uid &&
  //     //     element.name == tempCurrentUspgone.name);
  //     // final finalList = tt;
  //     // log('$finalList');

  //     // log('got here');
  //     // tempCurrentUser.uid = FirebaseAuth.instance.currentUser!.uid;
  //     // tempCurrentUser.email = FirebaseAuth.instance.currentUser!.email;
  //     // tempCurrentUser.fcmToken = await FirebaseMessaging.instance.getToken();

  //     // tempCurrentUspgone.uid = 'xQ0PvlW6g9efSJx9lxQoVYXOQCv1';
  //     // tempCurrentUspgone.email = 'tester@example.com';
  //     // tempCurrentUspgone.fcmToken =
  //     //     'fgyydU0MR7ScfV_T-sZ7T4:APA91bH7B5muh5mRQwJmznd05NIJYf5tXMSszEoj0BLB-VlFqEjgPIvBYEXRbzP0U4P6Y8kdmwj4lUoSskki3HPFNk4VbNPi4Sd_dJ3cqaJ3TbaZUqZsC1oQZwVwKWZTX0AGzVdBmt96';
  //     added = finalList;
  //     added.add(tempCurrentUser);

  //     print('object tjddnn');
  //     finalList.forEach((userDetails) async {
  //       await firestore
  //           .collection("Users")
  //           .doc(userDetails.uid)
  //           .set(userDetails.toJson())
  //           .whenComplete(() async => await firestore
  //               .collection("Users")
  //               .doc(tempCurrentUser.uid)
  //               .set(tempCurrentUser.toJson()))
  //           .whenComplete(() => log('done'));
  //     }

  //         // .whenComplete(() async => await firestore
  //         //     .collection("Users")
  //         //     .doc(tempCurrentUspgone.uid)
  //         //     .set(tempCurrentUspgone.toJson()))
  //         );
  //   } catch (e) {
  //     log('Error $e');
  //   }
  // }

  int formatDate(Timestamp timeStamp) {
    final old =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.millisecondsSinceEpoch);
    var now = DateTime.now();
    var diff = now.difference(old);
    return diff.inHours;
  }
}
