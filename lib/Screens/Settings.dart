import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';

class settingsPage extends StatefulWidget{
  @override 
  _settingsPageState createState()=> new _settingsPageState();
}


// email function for the endDrawer widget, for the Contact Us Link
_launchEmail() async {
    // ios specification
    final String subject = "Subject:";
    final String stringText = "Same Message:";
    // 
    String uri = 'mailto:CSIT691@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }
class _settingsPageState extends State<settingsPage> {

  @override
 Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          leading: 
          new IconButton(
              //  the back button will send the user to the 'Home Screen' : Civilian Role
               icon: new Icon(Icons.arrow_back, color: Colors.white),
               
               onPressed: () => Navigator.of(context).pop(),
              ), 
          title: new Text("Settings"),
          backgroundColor: Color.fromRGBO(211, 11, 52, 1),
        ),
        endDrawer: MainDrawer(),

        body: Container(
         
          child:ListView(
            

              children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 50.0)),
       

                  Text("Preferences",textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromRGBO(211, 11, 52, 1), fontSize: 24, fontWeight: FontWeight.bold),
     
                 ),
                
            
                    new Padding(padding: EdgeInsets.only(top: 20.0)),  
                new CheckboxListTile(value: true,
                      title: Text("Theme", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("Dark Mode"),
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (value) {},
                      ),

              Divider(height:10,color:Colors.grey),

               new CheckboxListTile(value: true,
                      title: Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("Push Notification"),
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (value) {},
                      ),
              //  new CheckboxListTile(value: true,
                    
              //         title: Text("Show Current Locations",style: TextStyle(fontSize: 14,color: Colors.grey[600]),),
              //         activeColor: Color.fromRGBO(211, 11, 52, 1),
              //         onChanged: (value) {},
              //         ),
              //         new CheckboxListTile(value: true,
                    
              //         title: Text("Distrinct Outlines",style: TextStyle(fontSize: 14,color: Colors.grey[600]),),
              //         activeColor: Color.fromRGBO(211, 11, 52, 1),
              //         onChanged: (value) {},
              //         ),
              
              Divider(height:10,color:Colors.grey),

              new CheckboxListTile(value: true,
                    
                      title: Text("Show Location", style: TextStyle(fontWeight: FontWeight.bold),),
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (value) {},
                      
                      ),

              // Divider(height:10,color:Colors.grey),
              // new CheckboxListTile(value: true,
                    
              //         title: Text("Distances", style: TextStyle(fontWeight: FontWeight.bold),),
              //         subtitle: Text("In Feet"),
              //         activeColor: Color.fromRGBO(211, 11, 52, 1),
              //         onChanged: (value) {},
              //         ),
              // new CheckboxListTile(value: true,
                    
                      
              //         title: Text("In Meters",style: TextStyle(fontSize: 14,color: Colors.grey[600]),),
              //         activeColor: Color.fromRGBO(211, 11, 52, 1),
              //         onChanged: (value) {},
              //         ),
             Divider(height:10,color:Colors.grey),
             new Padding(padding: EdgeInsets.only(top: 20.0)),  
                Text("Account",textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromRGBO(211, 11, 52, 1), fontSize: 24, fontWeight: FontWeight.bold),
                ),
                 ListTile(
                dense: true,
                  title: Text('Edit Profile'),
                ),
                ListTile(
                  dense: true,
                  title: Text('Change Password'),
                ),
                ListTile(
                    dense: true,
                  title: Text('Delete Account'),
                ),
                Divider(height:10,color:Colors.grey),
                new Padding(padding: EdgeInsets.only(top: 20.0)),  
                Text("About",textAlign: TextAlign.center,
                            style: TextStyle(color: Color.fromRGBO(211, 11, 52, 1), fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                   
             
              ],
        
          ),
          
          ),

          ),
            
        
      );
   
  }
}
