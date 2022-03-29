import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/routes/app_pages.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'buyer/Splesh_Screen/splash.dart';
import 'buyer/helpers/binding.dart';
import 'buyer/routes/app_pages.dart';
import 'buyer/screens/b_authentication_screen/b_submit_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var status1 = prefs.getBool('isLoggedIn');
  //
runApp(MyApp());
  // print(status1);
  // runApp(status1 == true ? SSubmitProfileScreen() : MyApp());
}


class MyApp extends StatelessWidget {
    MyApp({Key? key}) : super(key: key);
  var status1;
  data()async{
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
          // _bottomController.selectedScreen('SCatelogeHomeScreen');
          // _bottomController.bottomIndex.value=0;
          initialRoute: status1 == true ? SRoutes.SSubmitProfileScreen : AppPages.initial,
          defaultTransition: Transition.fadeIn,
          getPages: AppPages.routes,
          title: 'Flutter Demo',
          home: BSubmitProfileScreen(),
          initialBinding: Binding(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const Splash( ),
          //    status1 == false ? AppPages.bottom :
        );
      },
    );
  }
}