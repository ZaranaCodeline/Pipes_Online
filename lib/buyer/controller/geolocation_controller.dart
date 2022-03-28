import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
 class GeolocationController extends GetxController{

   RxString latitude = 'Getting Latitude..'.obs;
   RxString longitude = 'Getting Longitude..'.obs;
   RxString address = 'Getting Address..'.obs;
   late StreamSubscription<Position> streamSubscription;
   TextEditingController? addressController;

   void setLocation(double lat ,double long){
     addressController =  longitude != null ?TextEditingController(text: longitude.toString()):TextEditingController();
     latitude = lat as RxString;
     update();
   }


   @override
   void onInit() async {
     super.onInit();
     getLocation();
   }

   @override
   void onReady() {
     super.onReady();
   }

   @override
   void onClose() {
     streamSubscription.cancel();
   }

   getLocation() async {
     bool serviceEnabled;
     LocationPermission permission;
     // Test if location services are enabled.
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if (!serviceEnabled) {
       // Location services are not enabled don't continue
       // accessing the position and request users of the
       // App to enable the location services.
       await Geolocator.openLocationSettings();
       return Future.error('Location services are disabled.');
     }
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         // Permissions are denied, next time you could try
         // requesting permissions again (this is also where
         // Android's shouldShowRequestPermissionRationale
         // returned true. According to Android guidelines
         // your App should show an explanatory UI now.
         return Future.error('Location permissions are denied');
       }
     }
     if (permission == LocationPermission.deniedForever) {
       // Permissions are denied forever, handle appropriately.
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }
     // When we reach here, permissions are granted and we can
     // continue accessing the position of the device.
     streamSubscription =
         Geolocator.getPositionStream().listen((Position position) {
           latitude.value = 'Latitude : ${position.latitude}';
           longitude.value = 'Longitude : ${position.longitude}';
           getAddressFromLatLang(position);
         });
   }

   Future<void> getAddressFromLatLang(Position position) async {
     List<Placemark> placemark =
     await placemarkFromCoordinates(position.latitude, position.longitude);
     Placemark place = placemark[0];
     address.value = 'Address : ${place.locality},${place.country}';
   }
 }


