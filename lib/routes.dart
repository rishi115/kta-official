import 'package:flutter/cupertino.dart';
import 'package:kta_official/screens/admin_screen/admin_dashboard.dart';
import 'package:kta_official/screens/admin_screen/admin_screen.dart';
import 'package:kta_official/screens/admin_screen/adminattendance.dart';
import 'package:kta_official/screens/adminfeessection/feesdetail.dart';
import 'package:kta_official/screens/adminregistration/adminregistration.dart';

import 'package:kta_official/screens/admition_screen/admission_screen.dart';
import 'package:kta_official/screens/home_screen/home_screen.dart';
import 'package:kta_official/screens/login_screen/login_screen.dart';
import 'package:kta_official/screens/splash_screen/splash_screen.dart';
import 'package:kta_official/screens/adminfeessection/adminfeedashboard.dart';

Map<String, WidgetBuilder> routes = {
  // all screens will be registered here
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AdmissionScreen.routeName: (context) => AdmissionScreen(),
  AdminScreen.routeName: (context) => AdminScreen(),
  AdminDashboard.routeName: (context) => AdminDashboard(),
  AdminAttendance.routeName: (context) => AdminAttendance(),
  AdminFees.routeName: (context) =>AdminFees(),
  Registers.routeName: (context) =>Registers(),
  AdminFeesstatus.routeName: (context) =>AdminFeesstatus(),


};
