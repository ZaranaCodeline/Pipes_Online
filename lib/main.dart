import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_chat_screen.dart';
import 'package:pipes_online/buyer/screens/selected_product_widget.dart';
import 'package:pipes_online/routes/app_pages.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'buyer/Splesh_Screen/splash.dart';
import 'buyer/helpers/binding.dart';
import 'buyer/routes/app_pages.dart';
import 'buyer/screens/b_authentication_screen/b_submit_profile_screen.dart';
import 'buyer/screens/categories_product_list_screen.dart';
import 'buyer/screens/b_chat_message_page.dart';
import 'buyer/screens/settings_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var status1;

  data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status1 = prefs.getBool('isLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    print(status1);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
           initialRoute: status1 == true ? SRoutes.SSubmitProfileScreen : AppPages.initial,
          getPages: AppPages.routes,
          initialBinding: Binding(),
          // home: BSettingsScreen(),
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