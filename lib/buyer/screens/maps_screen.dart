import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import '../../seller/common/s_text_style.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}


class _MapsScreenState extends State<MapsScreen> {

  Position? userLocation;
  GoogleMapController? googleMapController;
  String address = '';

  GeolocationController _controller = Get.find();

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  Future<Position?> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }
  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address = 'Address : ${place.locality},${place.country},${place.subThoroughfare},${place.postalCode}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAP',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:
                  LatLng(userLocation!.latitude, userLocation!.longitude),
                  zoom: 15),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
       
             googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
                 LatLng(userLocation!.latitude, userLocation!.longitude), 17));
             _controller.setLocation(userLocation!.latitude, userLocation!.longitude);
             Get.back();

          },
          label: Text('Send Location'),
          icon: Icon(Icons.near_me),
        ),
      ),
    );
  }
}
