import 'package:flutter/material.dart';
import 'package:public_unity_app/Screens/NewReportIncident.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'package:public_unity_app/utils/LocationDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_unity_app/Screens/Settings.dart';


class ReportIncident extends StatefulWidget {
  @override
  _ReportIncidentState createState() =>
      _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
// The below function contains the link to launch the app to allow users
// to call 911 when the user selects the button "Call 911"
_launchCaller() async {
  const url = "tel: 911";
  if ( await canLaunch(url)){
    await launch(url);
  }
  else{
    throw 'Could not launch $url';
  }
}

// The below is an email function, when the user selects the "Contact US"
// from the side menu, it will launch the app to display the email body.
// this one is for iOS device.


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


// This page is for the Report Incident Civilian Role


  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: 
          new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context ) => new settingsPage())
                             );
                        }
              ), 
        title: Text('Public Unity Safety'),
        backgroundColor: Color.fromRGBO(211, 11, 52, 1),
      
      ),

      // The endDrawer will display the hamburger icon on the right side of the app
      //it contains three links, settings, contacts, and logout page.
      endDrawer: MainDrawer(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
      // the first button is Report Incident, it will direct the user to the 
      // the DropDown Page which contains the questions.
          RaisedButton.icon(
           onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context ) => new LocationDialog())
             );
             },
          // Report Incident Button 
          label: Text('Report Incident', style: new TextStyle(color: Colors.white,fontSize: 35.0,),),                
          color: Color.fromRGBO(211, 11, 52, 1),
          icon: Icon(Icons.report_problem, color: Colors.white,)
          ),

        new Padding(padding: EdgeInsets.only(top:20.0)),

        // The second button will direct the users to a 911 dial phone screen
        RaisedButton.icon(
          
          // the _launchCaller is a function to allow Civilian User to 
          // to call 911 from the phone dial screen.
          onPressed: _launchCaller,   
          label: Text('Call 911', style: new TextStyle( color: Colors.white,fontSize: 35.0, ), ),                 
          color: Color.fromRGBO(211, 11, 52, 1),
          icon: Icon( Icons.phone,color: Colors.white,)

          ),    
          
           ],
          ),
        )
      )
    );
  }
}