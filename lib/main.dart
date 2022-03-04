import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/routes/app_pages.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'buyer/helpers/binding.dart';
import 'buyer/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var status1 = prefs.getBool('isLoggedIn');
  //
runApp(const MyApp());
  // print(status1);
  // runApp(status1 == true ? SSubmitProfileScreen() : MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          defaultTransition: Transition.fadeIn,
          getPages: AppPages.routes,
          title: 'Flutter Demo',
          initialBinding: Binding(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
         // home: const Splash( ),
        );
      },
    );
  }
}
