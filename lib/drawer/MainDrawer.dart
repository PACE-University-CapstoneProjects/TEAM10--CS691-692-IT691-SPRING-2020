import 'package:flutter/material.dart';
import 'package:public_unity_app/Screens/Disclaimer.dart';
import 'package:public_unity_app/Screens/Settings.dart';
import 'package:public_unity_app/constants/Constants.dart';
import 'package:public_unity_app/main.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatefulWidget {


  @override
  _MainDrawerState createState() => _MainDrawerState();


}

class _MainDrawerState extends State<MainDrawer> {

  String strDisplayName = '';

  // email using the Capstone gmail for contact us
  _launchEmail() async {
    final String subject = "Subject:";
    final String stringText = "Same Message:";
    String uri = 'mailto:CSIT691@gmail.com?subject=${Uri.encodeComponent(
        subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }


  _getCurrentUser () async {
   var value = await AuthProvider().getCurrentUserDisplayName().then((value) {
     return value.toString();});

    setState(() {
      strDisplayName = value.toString();
    });

  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Constants.redColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person_pin,
                  size: 70.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(strDisplayName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 45.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.settings,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => settingsPage()),
                      );
                    },
                    child: new Text("Settings",
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.announcement,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => disclaimerPage()),
                      );
                    },
                    child: new Text("Disclaimer",
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.help,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                InkWell(
                    onTap: () {
                      _launchEmail();
                    },
                    child: new Text("Contact Us",
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.compare,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                InkWell(
                  onTap: () {
                    AuthProvider().logOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: new Text("Logout",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
