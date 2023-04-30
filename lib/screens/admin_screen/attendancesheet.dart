import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kta_official/screens/admin_screen/adminattendance.dart';


class Detailscreen extends StatefulWidget {
  final ListItem item;

  Detailscreen({required this.item});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<Detailscreen> {
  late String _studentName = '';


  @override
  void initState() {
    super.initState();
    _fetchStudentName();
  }

  void _fetchStudentName() async {
    final doc = await FirebaseFirestore.instance.collection('attendance').doc(widget.item.title).get();
    if (doc.exists) {
      setState(() {
        _studentName = doc['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: Center(
        child: _studentName != null ? Text('Student Name: $_studentName') : CircularProgressIndicator(),
      ),
    );
  }
}
