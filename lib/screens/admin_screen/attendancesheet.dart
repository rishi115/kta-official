import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kta_official/screens/admin_screen/adminattendance.dart';

class DetailPage extends StatefulWidget {
  final ListItem item;

  DetailPage({required this.item});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String _studentName = '';
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _fetchStudentName();
  }

  void _fetchStudentName() async {
    final doc =
    await FirebaseFirestore.instance.collection('attendance').doc(widget.item.title).get();
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
      body: Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: _isConfirmed ? Colors.green : Colors.white, // set card color based on confirmation state
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Text(
                  'Rishikesh Devare',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Positioned(
              right: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Are you sure you want to perform this action?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmed = true; // set confirmation state to true
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Paid'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
