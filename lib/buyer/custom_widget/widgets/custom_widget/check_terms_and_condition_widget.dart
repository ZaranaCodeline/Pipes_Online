// import 'package:flutter/material.dart';
//
// import '../../../app_constant/app_colors.dart';
//
// class CheckTermsAndConditionWidget extends StatefulWidget {
//   const CheckTermsAndConditionWidget({Key? key}) : super(key: key);
//
//   @override
//   _CheckTermsAndConditionWidgetState createState() => _CheckTermsAndConditionWidgetState();
// }
//
// class _CheckTermsAndConditionWidgetState extends State<CheckTermsAndConditionWidget> {
//   bool valuesecond = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: <Widget>[
//               SizedBox(width: 10,),
//               Checkbox(
//                 value: this.valuesecond,
//                 activeColor: AppColors.primaryColor,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     this.valuesecond = value!;
//                   });
//                 },
//               ),
//               const Expanded(
//                 child: Text(
//                   'Accept Terms & Conditions',
//                   style: TextStyle(fontSize: 17.0,fontFamily: 'ubuntu-Bold'),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
