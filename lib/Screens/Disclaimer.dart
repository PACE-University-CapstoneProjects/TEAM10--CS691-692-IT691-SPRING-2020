import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'package:public_unity_app/Screens/RadioButtons.dart';
class disclaimerPage extends StatefulWidget{
  @override 
  _disclaimerPageState createState()=> new _disclaimerPageState();
}

_launchEmail() async {
    // ios specification
    final String subject = "Subject:";
    final String stringText = "Same Message:";
    // put our capstone email 
    String uri = 'mailto:CSIT691@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }
class _disclaimerPageState extends State <disclaimerPage> {

  @override
  Widget build (BuildContext context) {
   return   new Scaffold(
        appBar: new AppBar(
          title: new Text("Public Unity Safety"),
          backgroundColor: Color.fromRGBO(211, 11, 52, 1),
        ),
        endDrawer: MainDrawer(),

body: Container(
  child: Center (
    child: Column(
      children: <Widget>[
       new Padding(padding: EdgeInsets.only(top: 100.0)),
       RichText(
      text: TextSpan(
      text: 'DISCLAIMER',  
      style: TextStyle(color: Color.fromRGBO(211, 11, 52, 1), fontSize: 30, fontWeight: FontWeight.bold),

  ),
),

new Padding(padding: EdgeInsets.only(top: 50.0)),

Container(
 
  width: 350,
  height: 350,
  alignment: Alignment.topCenter,
  

  decoration: BoxDecoration (
    
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(5),
   boxShadow: [
      BoxShadow(
        color: Colors.grey[300],
        blurRadius: 10.0, // has the effect of softening the shadow
        spreadRadius: 1.0, // has the effect of extending the shadow
        offset: Offset(
          10.0, // horizontal, move right 10
          10.0, // vertical, move down 10
        ),
      )
    ],
  ),
  padding: EdgeInsets.all(20.0),
  child: RichText(
    textAlign: TextAlign.center,                     
    text: 
    TextSpan(
      text: 'Only use this application when safe to do so during emergency situations.\n',
      style: TextStyle(color:Colors.black, fontSize:18,height: 2 ),
      children: <TextSpan> 
      [
       TextSpan( text: 'Dial 911 to report your emergency immediately.\n',
       style: TextStyle(color:Colors.black, fontSize:20, fontWeight:FontWeight.bold),
      ),
       TextSpan( text: 'Only use this application when safe to do so during emergency situations.',
       style: TextStyle(color:Colors.black, fontSize:18),
      ),
      ],
            )
  )

),

 new Padding(padding: EdgeInsets.only(top: 50.0)),

//  Agree and Continue Button
/*
 new  RaisedButton(
         onPressed: () {
         Navigator.push(context, new MaterialPageRoute(
         builder: (BuildContext context ) => new radioButtonPage()) );
                        },
          
         child: Text('AGREE & CONTINUE',  style: new TextStyle( color: Colors.white, fontSize: 20,),),
         color: Color.fromRGBO(211, 11, 52, 1),
        ),
*/

        ],
      )
     )
    ),
  );
 }
}


