import 'package:flutter/material.dart';
import 'package:kta_official/screens/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  // route name for our screen
  static String routeName = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    // we use future to go form one screen to other via duration time
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    });

    // scaffold color set to primary color in main in our text theme
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/kta_logo.png',
        width: 150,
        height: 150,
      )),
    );
  }
}
