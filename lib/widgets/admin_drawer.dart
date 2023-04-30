import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kta_official/screens/admin_screen/adminattendance.dart';
import 'package:kta_official/screens/adminfeessection/adminfeedashboard.dart';
import 'package:kta_official/screens/adminregistration/adminregistration.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final imageUrl =
      "https://yt3.googleusercontent.com/5vg2BgFYZhHw4v7Ba8X_rJMezVf32guTDaW2w1NoxGBbVXNEiSNNjW5Dd8-jmZMLxZ0PeuV-pdI=s900-c-k-c0x00ffffff-no-rj";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text("Raj padval"),
              accountEmail: Text("rajpadval45@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/kta_logo.jpg"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // navigate to Fees screen
              Navigator.pushNamed(context, AdminFees.routeName);
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.money_dollar,
                color: Colors.black,
              ),
              title: Text(
                "Fees",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // navigate to Registered Students screen
              Navigator.pushNamed(context, Registers.routeName);
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.black,
              ),
              title: Text(
                "Registered Students",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // navigate to Attendence screen

              Navigator.pushNamed(context, AdminAttendance.routeName);
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.book,
                color: Colors.black,
              ),
              title: Text(
                "Attendance",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
