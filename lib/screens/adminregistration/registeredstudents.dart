import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'adminregistration.dart';




class Studentdetails extends StatefulWidget {



  final ListItem item;

  Studentdetails({required this.item,});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<Studentdetails> {
  List<String> _studentNames = [];
  List<String> _selectedBranches = [];
  List<String> _phoneNumbers = [];
  List<String> _emails = [];
  List<String> _ages = [];

  late final List<String> _scopes;
  late final ServiceAccountCredentials _credentials;

  @override
  void initState() {
    super.initState();
    _fetchStudentNames();

    // Initialize Google Sheets API credentials and scopes
    
  void _fetchStudentNames() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('title', isEqualTo: widget.item.title)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docs = snapshot.docs;
      List<String> names = [];
      List<String> branches = [];
      List<String> phones = [];
      List<String> emails = [];
      List<String> ages = [];

      for (var doc in docs) {
        names.add(doc['name']);
        branches.add(doc['branch']);
        phones.add(doc['phone']);
        emails.add(doc['email']);
        ages.add(doc['age']);
      }

      setState(() {
        _studentNames = names;
        _selectedBranches = branches;
        _phoneNumbers = phones;
        _emails = emails;
        _ages = ages;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: ListView.builder(
        itemCount: _studentNames.length,

        itemBuilder: (BuildContext context, int index) {
          final studentName = _studentNames[index];


          return Card(
            elevation: 2,
            color: Colors.white,
            child: Container(
              height: 150,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  _studentNames[index],
                  style: TextStyle(fontSize: 22),
                ),

                subtitle: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      'Branch: ${_selectedBranches[index]}',
                      style: TextStyle(fontSize: 16),
                    ),

                    Text(
                      'Phone: ${_phoneNumbers[index]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email: ${_emails[index]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Age: ${_ages[index]}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );


        },
      ),
    );
  }

}

// ...

