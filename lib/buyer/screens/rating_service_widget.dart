// import 'package:flutter/material.dart';
// import 'package:rate_my_app/rate_my_app.dart';
//
// class RateAppInWidget extends StatefulWidget {
//   const RateAppInWidget({Key? key, required this.builder,}) : super(key: key);
//
//   final Widget Function(RateMyApp) builder;
//
//   @override
//   State<RateAppInWidget> createState() => _RateAppInWidgetState();
// }
//
// class _RateAppInWidgetState extends State<RateAppInWidget> {
//
//   RateMyApp? rateMyApp;
//
//   static const playStoreId = 'com.android.chrome';
//   static const appstoreId = 'com.apple.mobilesafari';
//
//
//   @override
//   Widget build(BuildContext context) => RateMyAppBuilder(
//     rateMyApp: RateMyApp(
//       googlePlayIdentifier: playStoreId,
//       appStoreIdentifier: appstoreId,
//       minDays: 0,
//       minLaunches: 2,
//       // remindDays: 1,
//       // remindLaunches: 1,
//     ),
//     onInitialized: (context, rateMyApp) {
//       setState(() => this.rateMyApp = rateMyApp);
//
//       if (rateMyApp.shouldOpenDialog) {
//         rateMyApp.showRateDialog(context);
//       }
//     },
//     builder: (context) => rateMyApp == null
//         ? Center(child: CircularProgressIndicator())
//         : widget.builder(rateMyApp!),
//   );
// }