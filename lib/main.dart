import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pipes_online/app_notification.dart';
import 'package:pipes_online/payment_service/payment_key.dart';
import 'package:pipes_online/routes/app_pages.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:sizer/sizer.dart';
import 'buyer/helpers/binding.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setStripeKey();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  AppNotificationHandler.getInitialMsg();
  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
  AppNotificationHandler.showMsgHandler();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var status1;

  @override
  void initState() {
    // TODO: implement initState
    AppNotificationHandler.getFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BottomController bottomController = Get.put(BottomController());
    print(status1);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          /*initialRoute: status1 == true ? BRoutes. BSubmitProfileScreen : AppPages.initial,*/
          getPages: AppPages.routes,
          initialBinding: Binding(),
          // home: BWelcomeScreen(),
          defaultTransition: Transition.fadeIn,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}
