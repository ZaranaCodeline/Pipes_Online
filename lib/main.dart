import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_email_screen.dart';
import 'package:pipes_online/routes/app_pages.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:sizer/sizer.dart';
import 'buyer/helpers/binding.dart';

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
  await GetStorage.init();
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

  /* data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status1 = prefs.getBool('isLoggedIn');
  }*/

  @override
  Widget build(BuildContext context) {
    BottomController bottomController = Get.put(BottomController());
    print(status1);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute:AppPages.initial,
          /*initialRoute: status1 == true ? BRoutes. BSubmitProfileScreen : AppPages.initial,*/
          // getPages: AppPages.routes,
          initialBinding: Binding(),
          home: BSignUpEmailScreen(),
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
