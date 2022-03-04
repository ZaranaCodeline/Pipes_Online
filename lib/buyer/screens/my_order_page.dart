import 'package:flutter/material.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Text('My Order Page'),
        ),
      ),
    );
  }
}
