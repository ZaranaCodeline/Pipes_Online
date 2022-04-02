import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pipes_online/main.dart';
import 'package:sizer/sizer.dart';


import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_text.dart';

class BSettingsScreen extends StatefulWidget {
  const BSettingsScreen({Key? key}) : super(key: key);

  @override
  State<BSettingsScreen> createState() => _BSettingsScreenState();
}

class _BSettingsScreenState extends State<BSettingsScreen> {
  bool switchNotification = false;
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    showNotification;
    // var initialzationSettingsAndroid =
    // AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettings =
    // InitializationSettings(android: initialzationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                playSound: true,

              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    getToken();
  }
  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }
  void showNotification() {
    setState(() {
      _counter++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name,
                importance: Importance.high,
                color: AppColors.primaryColor,
                playSound: true,
                icon: '@mipmap/app_icon')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: STextStyle.bold700White14,
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.arrow_back),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Account',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: AppColors.lightBlackColor),
                    ),
                    // alignment: Alignment.centerLeft,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 15.sp, backgroundColor: AppColors.hintTextColor,),
                        SizedBox(width: 15.sp),
                        Flexible(
                          child: Container(
                            // padding: EdgeInsets.only(top: 20),
                            // height: Get.height * 0.07,
                            // color: Colors.red,
                            child: TextField(
                              style: TextStyle(
                                color: AppColors.secondaryBlackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              // controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Jan Doe',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Column(
                children: [
                  CustomText(
                    text: 'Notifications',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: AppColors.lightBlackColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'App',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.hintTextColor),
                        Switch(
                          onChanged: (value) {
                            setState(() {
                              // showNotification;
                              switchNotification = value;
                            });
                            print('switchNotification:-$switchNotification');
                          },
                          focusColor: AppColors.primaryColor,
                          activeColor: AppColors.commonWhiteTextColor,
                          value: switchNotification,

                          // activeThumbColor: AppColors.primaryColor,
                          activeTrackColor: AppColors.primaryColor,

                          // ...
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Column(
                children: [
                  CustomText(
                    text: 'Get Help',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: AppColors.lightBlackColor),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: AppColors.secondaryBlackColor,
                                size: 14.sp,
                              ),
                              SizedBox(width: 10.sp),
                              CustomText(
                                  text: 'Help Center',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryBlackColor),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.secondaryBlackColor,
                            size: 14.sp,
                          ),
                        ]),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05.sp,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: AppColors.commonWhiteTextColor,
        backgroundColor: AppColors.primaryColor,
        onPressed: showNotification,
        tooltip: 'Increment',
        child: FittedBox(child: Text('Show \n Notification',textAlign: TextAlign.center,)),
      ),
    );
  }
}

