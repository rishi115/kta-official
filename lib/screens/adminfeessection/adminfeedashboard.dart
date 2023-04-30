import 'package:flutter/material.dart';

import 'package:kta_official/screens/adminfeessection/adiminfeessheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItem {
  final String title;

  ListItem({required this.title});
}

class ListItemCard extends StatelessWidget {
  final ListItem item;

  ListItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the page you want to display when the card is tapped.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detailfees(item: item)),
        );
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(
              item.title,
              style:
              TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}

class AdminFees extends StatelessWidget {
  static const String routeName = '/admin-fees';
  final List<ListItem> items = [
    ListItem(
      title: 'Personal Class',
    ),
    ListItem(
      title: 'Fellowship School',
    ),

    ListItem(
      title: 'Sewri Koilwada',
    ),
    ListItem(
      title:   'B. P. K Sahakari School',
    ),
    ListItem(
      title: 'Vanita Vishram',
    ),
    ListItem(
      title:'Thane Studio ( Saturday and Sunday)',
    ),
    ListItem(
      title: 'Runwal Batch 01',
    ),
    ListItem(
      title:'Runwal Batch 02',
    ),
    ListItem(
      title: 'Makhija Royale, Khar',
    ),
    ListItem(
      title:'Bandup',
    ),
    ListItem(
      title:'Prabhadevi ( All rounder activity center)',
    ),
    ListItem(
      title: 'Fellowship ( Monday and Wednesday)',
    ),
    ListItem(
      title:'Goregaon ( Kids Paradise)',
    ),

    ListItem(
      title:'Thane Studio ( Tuesday and Thursday)',
    ),
    ListItem(
      title:'Airoli ( Body Vision Fitness)',
    ),
    ListItem(
      title:'Klay Prep School ( Kalina East)',
    ),
    ListItem(
      title:'Radiant Minds ( Chembur)',
    ),
    ListItem(
      title: 'Omkar Ved ( Parel)',
    ),
    ListItem(
      title: 'Cassi Mehta Malbar Hil ( Monday and Wednesday)',
    ),
    ListItem(
        title:  'Varsha gulmohar ( Juhu)'
    ),
    ListItem(
        title:   'Ajmera Bhakti Park ( Wednesday and Friday )'
    ),
    ListItem(
        title:  'Andheri Lokhandwala'
    ),
    ListItem(
        title:  'Kharghar'
    ),
    ListItem(
        title:  'Byculla'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Section'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              const url = 'https://docs.google.com/spreadsheets/u/4/d/1jEnZKIZlnMC9YRWc05h_xT9ihgfxJmNYlZdFMXfABX4/edit?ouid=106446411387831082951&usp=sheets_home&ths=true'; // Replace with your URL
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListItemCard(
            item: item,
          );
        },
      ),
    );
  }
}
