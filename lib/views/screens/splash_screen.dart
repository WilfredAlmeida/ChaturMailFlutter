import 'package:flutter/material.dart';
import 'package:wilfredemail/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Center(
          child: Image.asset("assets/images/app_logo.png"),
        ),
      ),
    );
  }
}
