import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final imageUrl =
      "https://yt3.googleusercontent.com/5vg2BgFYZhHw4v7Ba8X_rJMezVf32guTDaW2w1NoxGBbVXNEiSNNjW5Dd8-jmZMLxZ0PeuV-pdI=s900-c-k-c0x00ffffff-no-rj";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: ,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
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
            ListTile(
              leading: Icon(
                CupertinoIcons.money_dollar,
                color: Colors.black,
              ),
              title: Text(
                "Fees",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.black,
              ),
              title: Text(
                "Registered Students",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.arrow_up_doc_fill,
                color: Colors.black,
              ),
              title: Text(
                "Form Responses",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.book,
                color: Colors.black,
              ),
              title: Text(
                "Attendence",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.collections_solid,
                color: Colors.black,
              ),
              title: Text(
                "Create Form",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
