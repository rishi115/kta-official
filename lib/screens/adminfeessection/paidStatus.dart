import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



class FirebaseScreen extends StatelessWidget {
  final String item;

  FirebaseScreen({required this.item});

  final databaseReference = FirebaseDatabase.instance.reference().child('1UR4fyNtd-vvvRQPDDBIJzMYquNp7H4NcU11T6qwh1gc');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees detail'),
      ),
      body: Center(
        child: FutureBuilder<DataSnapshot>(
          future: databaseReference.once().then((event) => event.snapshot),
          builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data?.value != null) {
              final personalClassData = (snapshot.data!.value as Map)[item];


              List<String> personalClassList = [];
              for (var item in personalClassData) {
                personalClassList.add(item.toString());
              }

              return ListView(
                children: personalClassList.map((text) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(text),
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
