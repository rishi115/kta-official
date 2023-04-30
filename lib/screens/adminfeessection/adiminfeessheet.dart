import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kta_official/screens/adminfeessection/adminfeedashboard.dart';


class Detailfees extends StatefulWidget {
  final ListItem item;

  Detailfees({required this.item});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<Detailfees> {
  List<String> _studentNames = [];
  Map<String, bool> _attendanceStatus = {};
  late final List<String> _scopes;
  late final ServiceAccountCredentials _credentials;

  @override
  void initState() {
    super.initState();
    _fetchStudentNames();

    // Initialize Google Sheets API credentials and scopes
    _scopes = [SheetsApi.spreadsheetsScope];
    _credentials = ServiceAccountCredentials.fromJson({

        "type": "service_account",
        "project_id": "kta-app-385319",
        "private_key_id": "f2ce502f76da4272f07fc06656dc660fa5778484",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDzC793L5Ch89oR\nnmzJoW+bXcLlBRTLWO1ggBjMQgjchV7BmJRHydd9iD125ydZKiiTkDLOXE/kc9QH\n4NQ2JID3nJs/B7QsrpKOq+/AuVgUD5va2V5hofpuONHcmZ9SZ9XlVZehPrynKRZa\n4f5dAsxj5UXeQF1rK2EC8lxjCY0erjjLhzBIZ+XR2HTwkXRNJ4I8gAlqxAsNPPfY\n2YuV4y++0ZYgTLEcUg4DVXofwHYmKa4dbvpzk5dckGbaanZauDdDBv64Xq4OegyB\nYgI5pW8D754hSmLdU+NWdPJ7DJCU3OAa2KqyFabzllgMGVpIYWxsYg8pyvJMtjMK\nLHOCYaoHAgMBAAECggEAdfMklzXZLg+Gq/hDeVLENBU7qSNfJRRiFuvznOULIeID\ny1Y9190HnB9LHPIvMWF5UauwTF+WUhs4Mh6VPjVW9VPmL5+QfAK4k06zysboDMxK\nadoFqMIQI/+lMTbIkBheQK7aKGGm8kTJWY/FfuQFxxEUaDi6XXEu4lw2I8YV22Xl\ngsMlOBsAOt692XlTLd1bBTtkcAqTksqcjMufyLTtcPKEWyb3xyjAzBa6QAJFjelH\nk4BBixX+pkzzlYlNY6bdXDuNOmQukjgVFNGov7W5t1bxm80kkFWMG76bNQ3J+ifs\neSurgEFyyFor4602HePntaHND+eDWc6CZePwjBqRuQKBgQD7UYCmGQpeIiHOCwNl\ndTUezGSDX8qKhzNxBL7YmSWi1Ct7dNXpFE6ed3dqgJ6pmTv5e2uHh37laljVHOi0\nQmlzUC8WTAyLrLCg/47vF8Vp61psEe3xhzfSctOEEYblfbGBdquWI0w1p9wJijEe\nivQTb53HnMlxjccn5nZKRU74TQKBgQD3ksuUpZJo2fzA3HdUi/nBFXjOg1T5e1KL\nfmN5WGnSs+6G7qF1Pu2EvaN2EnBBseQfkPV5tGzmEcXF1GxliACVvPzn2iOFxsXg\nPkdrToLjlEqW3kvNaeSvWTSRfBEyxhWHDgk5dIgC8/gnU25fVw8lDwKCV+ryimxC\ny6LbH0hVowKBgEeGnrKnFchMtopJoCHUBdZKHaE2NhLO/9j+nMJQc+GvuOBeFDNN\n0EJRhe8NxBpIvkT211evPHJWngmpPKFw9UoYXA5gfoGSGIL5uNhbT5ghn456W9oN\nvdlrTL+drWLLLyXFfHgye5IZwAoHBovGyEhvz9vrx3lF/JRihvAEYcFRAoGAeJTW\n8x9xoAAMSyMWO+exTYnXvT3aNWkLW0XDzWZypF1e3/l6SlDL/ssewnNYmaa7JWTF\nKvHl2GjvmttLsGf9YPEbfRGSG6Yk2oN65Zjnx1CCw9ihsvrQl1crc3CqL8Cq24zK\nkWFgnY+WXhEUwPr2NWaKIlIP7PHeqOnl+DPUV2ECgYEAqX9pLcPrShzUy5PXfnom\ns8p2YE+h4imgPmltUzVu/bDISerhoce7NITcIrjUyhzqEg6JLtaXpmEyUZI2zHtj\n1sz0jSdTZTG9OHsrA3m/ilHfnp1GpYl3igJZoKXo0kv/8+XTSD6aPxxUf3Z6nNL5\n/QGkjUSBRha+Gkx5i2FD3eo=\n-----END PRIVATE KEY-----\n",
        "client_email": "kta-128@kta-app-385319.iam.gserviceaccount.com",
        "client_id": "105564213360303762145",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/kta-128%40kta-app-385319.iam.gserviceaccount.com"


    });
  }

  void _fetchStudentNames() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('title', isEqualTo: widget.item.title)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docs = snapshot.docs;
      List<String> names = [];
      for (var doc in docs) {
        names.add(doc['name']);
        _attendanceStatus[doc['name']] = false; // Initialize attendance status
      }
      setState(() {
        _studentNames = names;
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
          return Card(
            elevation: 2,
            color: _attendanceStatus[_studentNames[index]] == true
                ? Colors.green
                : Colors.white,
            child: Container(
              height: 80,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  _studentNames[index],
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(
                            context, _studentNames[index],widget.item);
                      },
                      child: Text(
                        'Paid',
                        style: TextStyle(color: Colors.white),
                      ),
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

  void _showConfirmationDialog(BuildContext context, String studentName, ListItem item) async {
    final sheetsApi = SheetsApi(await clientViaServiceAccount(_credentials, _scopes));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Attendance'),
          content: Text('Did $studentName pay the class fees?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _attendanceStatus[studentName] = true;
                });
                Navigator.pop(context);

                // Add attendance data to Google Sheet
                final spreadsheetId = '1jEnZKIZlnMC9YRWc05h_xT9ihgfxJmNYlZdFMXfABX4';
                final sheetName = item.title;
                final range = '$sheetName!A1:C1';

                final valueRange = ValueRange.fromJson({
                  'range': range,
                  'majorDimension': 'ROWS',
                  'values': [
                    [studentName, 'Paid', DateTime.now().toString()],
                  ],
                });

                try {
                  final response = await sheetsApi.spreadsheets.values.append(
                    valueRange,
                    spreadsheetId,
                    range,
                    valueInputOption: 'USER_ENTERED',
                  );

                  print('Attendance data added to Google Sheet: $response');
                } catch (e) {
                  print('Failed to add attendance data to Google Sheet: $e');
                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }


}
