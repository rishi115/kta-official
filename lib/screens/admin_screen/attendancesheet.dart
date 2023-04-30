import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:kta_official/screens/admin_screen/adminattendance.dart';

class Detailscreen extends StatefulWidget {
  final ListItem item;

  Detailscreen({required this.item});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<Detailscreen> {
  List<String> _studentNames = [];
  Map<String, bool> _attendanceStatus = {};
  late final List<String> _scopes;
  late final ServiceAccountCredentials _credentials;

  @override
  void initState() {
    super.initState();
    _fetchStudentNames();
    _scopes = [SheetsApi.spreadsheetsScope];
    _credentials = ServiceAccountCredentials.fromJson({


        "type": "service_account",
        "project_id": "kta-app-385319",
        "private_key_id": "a78261bdb23cdfd6cb608d821740471cda5719a1",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4159+duPUKlMF\nCaO5uGXPa+Pz8dmQnXqXNdb7s4thP8b6bMFs1A6Hdv3kNqO5ytoZ7EfMdIYnvlHP\nvUMT+wFDTuS4X2SL9I6xNpIRbbeWYYX6F9kN62kufEQgt0iXR9GzRz9WIwoBheQx\nMZ20quZnFXq/ZwC9THsL4bNspNEZn5QLnnkbrr3JjiZCRCbZxb+WLIy08JfWwpcV\nPDNaAdV16pJFIav5OxnlHam1NBda20uTqBMOelyNBNXIDODLiPaedxV/QJlnQEPs\nn4UKfD6+Y4a8uFD+X9k/Yu4E9YGbE9NBtHK603ukos8c/BZ82SEEzdVltFOionnm\nOzmW0RkPAgMBAAECggEACN9sZN9Yyeluo+B86c6OhXC8t++VShoqbjG8pRykPkHQ\nsz47qHlcFEt8gZpB17UuEIp+PnsB4ncsomYV7W8MvT9izNPGh7HF6fDnby72Fvcb\nr2VIjQRj+HrwIrQe7uwY29UA7FCUtkRyvZwBjFB/Xisrc5BmFsyT0ikwK813ysBy\nOA/72pNCiRyvc5CPYQCH4ihPK/Qv+LQq5NW2NcGsQIY0bmJv+ToPDNgyVjtdVHze\n1XCiJXdKWrtSFlFn9da2WbwrdrErTxhu6Wd2d7A7A2tpojGC6FQquSL5K30Ttm+I\nCIWwZTFDh9mdGF9Ji0Q4wGxzlS5qUYiKQHcYJViY4QKBgQD0l2EETv1YuEaMWbWz\nmTS/es2wFcxU7GOXKXf7Z+fIy2xNRGxq1mygQbdYt4TDxNE+3gM9Vyumyerqg3fy\nLYOE380oO/Uw5r2ecrEVLnS79CwtIKou+eEbjOzf5y6MLAMO+6wowxEWlQzjotTr\nnKHFPMgZX/ai12Lehaofxvs3kQKBgQDBdsqa9KOrXT1kc33WA9ux4ntoNJK2fMX7\nb6C1Mxg2mpQlLpZyczZlnlyEthSFiS8BHq4wySy1nZqyoeg2HiuDTb5q2v3GfzYS\nKae0WQU4cNAEJs7Cha/jTeexx7vLOKQnoR1hjvToGBv8nxyfXs1cN5KKqDQyXeru\nF0zZU4E2nwKBgAVx9Uv2QjeeapunR59G8uCsaDXaVmExngn4d15WcteKh8+0jUFX\norVyoRVNiJwfHpVqteHAtg0Rg7RS1vHCR6JGpTeXFh9Pk7saTIzvKtQgXHdoucEv\n+O33FjLp36RpOmwz+CI0LYY2LUJIFrtkEknkz4OZGlGHwAC6Mw5gDKmxAoGAWelV\ne/KaZjftIlQydVZRsjhp1iIo1Trj4FkevVfDtwzcMPOX5BT7gPq6UMs2emEpQUH6\n/p1gc/+NN9vbSdt3qYxmJM8mBix0+rf1QvHkZTi41FUc3na3KdK5DXygIHBwiiJs\nvzxrQbqCt0NTUBYFJwiEyIAn0gin+INHqfEPKk0CgYEAiyqS0/Vulv/gDf675bxv\nwo6lKYhTAB777lHY1O4n2tGL5gaC3HENXlwboW7cnqlxA4n8FfbUVZQSvEE0mBEZ\nmY0Ze23hzS+VEcwXtne1ipTR7mHJTSO6pdSUV6cmUs/INA2QyWmD/xC1cYZQpW/F\naG2J9KLdEIXmFtWPJJhD8DQ=\n-----END PRIVATE KEY-----\n",
        "client_email": "kta-attendence@kta-app-385319.iam.gserviceaccount.com",
        "client_id": "114500738623912600852",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/kta-attendence%40kta-app-385319.iam.gserviceaccount.com"



    });

    // Initialize Google Sheets API credentials and scopes

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
          final studentName = _studentNames[index];
          return Card(
            elevation: 2,
            color: Colors.white,

            child: Container(
              height: 80,

              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                title: Text(
                  _studentNames[index],
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    GestureDetector(
                      onTap: () async {

                        // Pass the index of the pressed icon to the function

                        await addAttendanceToGoogleSheet(_studentNames[index], DateTime.now(), true,widget.item);


                      },
                      child: Icon(Icons.check_circle_outline, color: Colors.green,size: 30,),
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      onTap: () async {

                        // Pass the index of the pressed icon to the function

                        await addAttendanceToGoogleSheet(_studentNames[index], DateTime.now(), false,widget.item);


                      },
                      child: Icon(Icons.cancel_outlined, color: Colors.red,size: 30,),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );

        },
      ),
    );
  }
  Future<void> addAttendanceToGoogleSheet(String studentName, DateTime currentDate,bool isPresent,ListItem item) async {
    // TODO: Replace with your own credentials file
    final sheetsApi = SheetsApi(await clientViaServiceAccount(_credentials, _scopes));



    // Authenticate with the Google Sheets API using the credentials
    final spreadsheetId = '1yRrdy7WTMSIlPOCpCb3ZWx2scE-TjrhYPtQJMi_QS30';
    final sheetName = item.title;
    final range = '$sheetName!A1:C1';
    var named = '';
    if(isPresent){
      named='Present';
    }
    if(!isPresent){
      named = 'Absent';
    }

    final valueRange = ValueRange.fromJson({
      'range': range,
      'majorDimension': 'ROWS',
      'values': [
        [studentName, named, DateTime.now().toString()],
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

    // Execute the request to add the new row to the sheet

  }
}





