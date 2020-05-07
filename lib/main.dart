import 'package:flutter/material.dart';
import 'package:public_unity_app/Screens/ActivityCurrentIncidents.dart';
import 'package:public_unity_app/Screens/ReportIncident.dart';
import 'package:public_unity_app/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_unity_app/Screens/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:public_unity_app/utils/LocationDialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'ActivityCurrentIncidents': (context) => ActivityCurrentIncidents(),
        'ReportIncident': (context) => ReportIncident(),
        /*Here's where you receive your routes, and it is also the main widget*/
      },
    );
  }
}



class MainScreen extends StatelessWidget {
  static bool isUserAuthenticatedSuccessfully = false;


  Future AuthenticateUser(BuildContext context) async {

    final CollectionReference _firebaseCollectionValue = Firestore.instance.collection("UserProfileCollection");
    final FirebaseAuth _authValidate = FirebaseAuth.instance;
    final FirebaseUser user = await _authValidate.currentUser();

    var blnIsFirstResponder = await _firebaseCollectionValue.document(user.uid).get().then((document) =>document.data['IsFirstResponder'].toString().toLowerCase());
    var blnIsFirstResponderValidated = await _firebaseCollectionValue.document(user.uid).get().then((document) =>document.data['IsFirstResponderValidated'].toString().toLowerCase());


    print('blnIsFirstResponder -' + blnIsFirstResponder);
    print('blnIsFirstResponderValidated -' + blnIsFirstResponderValidated);
    if (blnIsFirstResponder == 'true') {
      if (blnIsFirstResponderValidated == 'false') {

        await _authValidate.signOut();
        print('Submitted Id proof is pending to validate. Please try again later.');
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Id Proof validation'),
              content: Text('Submitted Id proof is pending to validate. Please try again later.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    print('Ok called');
                    isUserAuthenticatedSuccessfully = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  new Login()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
      else
      {
        print('ActivityCurrentIncidents');
        isUserAuthenticatedSuccessfully = true;
/*        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  new ActivityCurrentIncidents()),
        );*/

         Navigator.pushReplacementNamed(context, 'ActivityCurrentIncidents');
        //Navigator.of(context).pushNamedAndRemoveUntil('/Screens/ActivityCurrentIncidents', (Route<dynamic> route) => false);

      }
    }
    else {
      isUserAuthenticatedSuccessfully = true;

      Navigator.pushReplacementNamed(context, 'ReportIncident');

  /*    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new LocationDialog()),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {

/*      AuthProvider().isLoggedIn().then((value) {
        print('User Logged In? ==> ' + value.toString());

        if(value.toString() =='true')
          isUserAuthenticatedSuccessfully = true;
        else
          isUserAuthenticatedSuccessfully = false;
      });*/

        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        else if(!snapshot.hasData || snapshot.data == null) {
          isUserAuthenticatedSuccessfully = false;
          return Login();
        }
        else if (!isUserAuthenticatedSuccessfully && snapshot.hasData) {
          print('AuthenticateUser called');
          AuthenticateUser(context);
          return SplashPage();
        }
        else
          return Login();
      },
    );
  }
}