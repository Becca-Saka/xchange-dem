// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:thedeck/barrel.dart';

class NotificationService {
  // /// Create a [AndroidNotificationChannel] for heads up notifications
  // late AndroidNotificationChannel channel;

  // /// Initialize the [FlutterLocalNotificationsPlugin] package.
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // Future<void> onInit() async {
  //   FirebaseMessaging _fcm = FirebaseMessaging.instance;

  //   if (Platform.isIOS) {
  //     _fcm.requestPermission();
  //     await _fcm.requestPermission(
  //       announcement: true,
  //       carPlay: true,
  //       criticalAlert: true,
  //       sound: true,
  //     );
  //   }
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description:
  //         'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );

  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   /// Create an Android Notification Channel.
  //   ///
  //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   /// default FCM channel to enable heads up notifications.
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);

  //   /// Update the iOS foreground notification presentation options to allow
  //   /// heads up notifications.
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   final token = await _fcm.getToken();
  //   log('initialed $token');
  // }

  // startListening() {
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage? message) {
  //     if (message != null) {
  //       log('Gotten Message');
  //       // Get.toNamed(Routes.HOME);
  //       // Navigator.pushNamed(context, '/message',
  //       //     arguments: MessageArguments(message, true));
  //     }
  //   });

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       log('${message.messageId}');
  //       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               'high_importance_channel', // id
  //               'High Importance Notifications', // title
  //               channelDescription:
  //                   'This channel is used for important notifications.',
  //               //      one that already exists in example app.
  //               icon: 'launch_background',
  //             ),
  //           ));
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');

  //     log('Gotten Message');

  //     // Get.toNamed(Routes.HOME);
  //   });
  // }

}
//TODO: remove notification service