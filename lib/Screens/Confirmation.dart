import 'package:flutter/material.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'ReportIncident.dart';

class confirmationPage extends StatefulWidget{
  confirmationPage() : super();

  @override
  _confirmationPageState createState() => new _confirmationPageState();
}

class _confirmationPageState extends State <confirmationPage> {

  @override
  Widget build (BuildContext context) {

    return new Scaffold(
      
      resizeToAvoidBottomPadding: false,
      
      appBar: new AppBar(
         leading: 
          new IconButton(
              //  the back button will send the user to the 'Home Screen' : Civilian Role
               icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: () { Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context ) => new ReportIncident()));
               }
          ),
        title: new Text("Public Unity Safety"),
        
        backgroundColor: Color.fromRGBO(211, 11, 52, 1),
      ),

      endDrawer: MainDrawer(),
    );
    


  }
}