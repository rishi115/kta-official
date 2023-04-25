import 'package:flutter/material.dart';
import 'package:kta_official/widgets/admin_drawer.dart';

class AdminDashboard extends StatefulWidget {
  static String routeName = "AdminDashboard";

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          "Admin Panel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(),
      drawer: AdminDrawer(),
    );
  }
}
