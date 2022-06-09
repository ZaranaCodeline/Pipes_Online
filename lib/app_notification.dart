import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'shared_prefarence/shared_prefarance.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken();
      log("=========fcm-token===$token");
      await PreferenceManager.setFcmToken(token!);
      print('FCM-TOKEN---${PreferenceManager.getFcmToken()}');
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      print(
          'NOtification Call :${notification?.apple}${notification!.body}${notification.title}${notification.bodyLocKey}${notification.bodyLocKey}');
      // FlutterRingtonePlayer.stop();

      if (message != null) {
        print(
            "action==onMessage.listen====1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        showMsg(notification);
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('------RemoteMessage message------$message');
      if (message != null) {
        //  FlutterRingtonePlayer.stop();

        print("action======1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              //'This channel is used for important notifications.',
              // description
              importance: Importance.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: IOSNotificationDetails()));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification? notification = message.notification;
    print(
        '--------split body ${notification!.body.toString().split(' ').first}');
    if (notification.body.toString().split(' ').first == 'calling') {
      print('----in this app');
      // FlutterRingtonePlayer.playRingtone(
      //     looping: false, volume: 50, asAlarm: false);
    }

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
      // FlutterRingtonePlayer.stop();

      if (message != null) {
        // print("action======1=== ${message?.data['action_click']}");
        print("action======2=== ${message.data['action_click']}");
        //  FlutterRingtonePlayer.stop();

        // _barViewModel.selectedRoute('DashBoardScreen');
        // _barViewModel.selectedBottomIndex(0);

        // Get.offAll(SplashPage());
      }
    });
  }

  /// send notification device to device
  static Future<bool?> sendMessage({
    String? receiverFcmToken,
    String? msg,
  }) async {
    var serverKey =
        'AAAAUabu80w:APA91bFnpf1msJdRGivKhuuUNTKX_4DHleVmJ5CLqC_UrJNINcKTNVfxvRHYDgGAYd5wbGC6ySzwZR2RPmgNLa56Fr9dlz6FMvt_5cgsvR-TZ2G8Hovzh-yPlv4suc3iO_fNUlrNWFRp';
    try {
      // for (String token in receiverFcmToken) {
      log("RESPONSE TOKEN  $receiverFcmToken");

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg ?? 'msg',
              'title': PreferenceManager.getName().isEmpty
                  ? 'Pipes Deals'
                  : PreferenceManager.getName(),
              'bodyLocKey': 'true'
            },
            'priority': 'high',
            'to': receiverFcmToken,
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");

      log("RESPONSE BODY ${response.body}");
      // return true}
    } catch (e) {
      print("error push notification");
      // return false;

    }
  }
}
