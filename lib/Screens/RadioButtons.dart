import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:public_unity_app/Screens/Confirmation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:public_unity_app/Screens/Settings.dart';
import 'package:public_unity_app/Screens/DropDown.dart';
import 'ReportIncident.dart';

class radioButtonPage extends StatefulWidget{
  radioButtonPage() : super();

  @override
  _radioButtonPageState createState() => new _radioButtonPageState();
}

// For the original DropDown menu items, but I did not use it.
class MedicalEmergency {
  int id;
  String name;
 
  MedicalEmergency(this.id, this.name);
 
  static List<MedicalEmergency> getEmergencies() {
    return <MedicalEmergency>[
    
      MedicalEmergency(1, 'Traumatic Bleeding Wound'),
      MedicalEmergency(2, 'Breathing Difficuly/Chocking'),
      MedicalEmergency(3, 'Child/Infant/Elderly Injured'),
     
    ];
  }
   
 
}
class _radioButtonPageState extends State <radioButtonPage> {



final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String selectedMedical;
  String name;

// validate the textField
  final _text = TextEditingController();
  bool _validate = false;

// These variables are for the dropdown menu 
List<MedicalEmergency> _emergency = MedicalEmergency.getEmergencies();
List<DropdownMenuItem<MedicalEmergency>> _dropdownMenuItems;
MedicalEmergency  _selectedEmergency;




// delcare variables for radio buttons
int selectedRadio;
int selectedRadio1;
int selectedRadio2;


@override
// Validation for Textfield
 void dispose() {
    _text.dispose();
    super.dispose();
  }


@override
  void initState() {
    // gave variables 0 
    selectedRadio =0;
    selectedRadio1 = 0;
    selectedRadio2 =0;

    _dropdownMenuItems = buildDropdownMenuItems(_emergency );
    _selectedEmergency  = _dropdownMenuItems[0].value;


    super.initState();
  }

// created three different selectedRadio for each set of yes/no for three set of questions
  setSelectedRadio (int val){
    setState(() {
      selectedRadio = val;
    });
  }


setSelectedRadio1 (int val){
    setState(() {
      selectedRadio1 = val;
    });
  }

setSelectedRadio2 (int val){
  setState(() {
    selectedRadio2 = val;
  });

    
}

List<DropdownMenuItem<MedicalEmergency>> buildDropdownMenuItems(List emergencies) {
    List<DropdownMenuItem<MedicalEmergency>> items = List();
    for (MedicalEmergency emergency in emergencies) {
      items.add(
        DropdownMenuItem(
          value: emergency,
          child: Text(emergency.name),
        ),
      );
    }
    return items;
  }

   onChangeDropdownItem(MedicalEmergency selectedEmergency) {
    setState(() {
     _selectedEmergency = selectedEmergency;
    });
  }

// email using the Capstone gmail for contact us
  _launchEmail() async {
    // ios specification
    final String subject = "Subject:";
    final String stringText = "Same Message:";
    String uri = 'mailto:CSIT691@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }

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
        title: new Text("Public Safety"),
        
        backgroundColor: Color.fromRGBO(211, 11, 52, 1),
      ),
      
      endDrawer: Theme(
           data: Theme.of(context).copyWith(
                 canvasColor:Color.fromRGBO(211, 11, 52, 1), //This will change the drawer background to blue.
                 //other styles
              ),
              child: Drawer(
                 child: ListView(
                    children: <Widget>[
                          
                          new UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                          color: Color.fromRGBO(211, 11, 52, 1),
                          ),
                          accountName: new Text('Robert Marx'), 
                          accountEmail: null,
                          currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          ),
                      ),
                      
                      // First ListTile : Settings Link
                      new ListTile(
                        leading: new Icon(Icons.settings,color: Colors.white,),
                        title: new Text('Settings', 
                          style: new TextStyle(
                            color: Colors.white,  
                          )),
                           onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context ) => new settingsPage())
                          );
                        }
                      ),
                      // Second ListTile: Contact Us/Report a Problem
                      new ListTile(
                        leading: new Icon(Icons.help, color: Colors.white),
                        title: new Text('Contact Us / Report a Problem',
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        ),
                        onTap: () {
                          // This is suppose to call the mailto function, check on top of the page for the function.
                          _launchEmail();
                        },
                        
                      ),
                      // Third ListTile contains the Logout link
                       new ListTile(
                        leading: new Icon(Icons.exit_to_app, color: Colors.white),
                        title: new Text('Logout',
                        style: new TextStyle(
                          color: Colors.white,
                        ),),
                      // Add on top function: user taps the link : logouts out the application.
                      )
                       //drawer stuffs
                    ],
                 ),
             ),
        ),


        body: Container(
       
          child: Center (
            child: SingleChildScrollView(   
            child: Column(
               
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              
              children: <Widget>[
                   
                new Text ('Report Incident', 
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,color:  Color.fromRGBO(211, 11, 52, 1),),
                ),
                Divider(height: 20,color: Colors.grey,indent: 25.0, endIndent: 25.0,),
                new Padding(padding: EdgeInsets.only(top: 10.0)), 
                  Text("Please answer the following questions:", style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        
                      )
                      ),
              new Padding(padding: EdgeInsets.only(top: 25.0)),  
                new Text(
                      'Is patient consious?',
                      style: new TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )
                ),
                // Create a new row for the first set of Yes/No Radio Buttons
                 
                new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                  Radio(
                    
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 1 $val");
                            setSelectedRadio(val);
                          },
                   ),
                  Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                  ),
                     
                  Radio(
                         value: 2,
                          groupValue: selectedRadio,
                          activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 1 $val");
                            setSelectedRadio(val);
                          },
                       
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        
                         ],
                    ),

                      new Padding(padding: EdgeInsets.only(top: 10.0)),  
                      Text(
                      'Is patient breathing?',
                      style: new TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    // new Padding(
                    //   padding: new EdgeInsets.all(5.0),
                    // ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         Radio(
                          value: 3,
                          groupValue: selectedRadio1,
                          activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 2 $val");
                            setSelectedRadio1(val);
                          },
                          
                        ),
                         Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 4,
                          groupValue: selectedRadio1,
                            activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 2 $val");
                            setSelectedRadio1(val);
                          },
                       
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                         ],
                    ),
                    new Padding(padding: EdgeInsets.only(top: 10.0)),  
                    Text(
                      'Is patient bleeding heavily?',
                      style: new TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                       new Padding(
                      padding: new EdgeInsets.all(5.0),
                    ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Radio(
                        value: 5,
                          groupValue: selectedRadio2,
                          activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 3 $val");
                            setSelectedRadio2(val);
                          },
                          
                        ),
                        Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 6,
                          groupValue: selectedRadio2,
                          activeColor: Color.fromRGBO(211, 11, 52, 1),
                          onChanged: (val){
                            print("Radio Set 3 $val");
                            setSelectedRadio2(val);
                          },
                       
                        ),
                      Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        
                         ],
                    ),   
       
          // Add a space between the buttons and the DropDown menu
           new Padding(padding: EdgeInsets.only(top: 20.0)),   
          
          // This is the beginning of the dropdown menu
          Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: Container(
              width: 300.0,
            child: Column(
              
              children: <Widget>[
               Text("Select Emergency Type", style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      )
                      ),
               
                DropdownButtonFormField(

                  value: selectedMedical,
                  hint: Text('Please Select'),
                  onChanged: (medical) => 
                  setState(() => selectedMedical = medical),
                  validator: (value) => value == null ? 'Please Select Emergency Type' :null,
                  items: ['Traumatic Bleeding Wound', 'Breathing Difficuly/Chocking', 'Child/Infant/Elderly Injured'].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                 )
              ],
            ),
            ),
          ),
            


               //had troubles validating the original dropdown menu
              // Text("Select Emergency Type", style: new TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 24.0,
              //         )
              //         ),
              //   SizedBox(
              //     height: 30.0,
              //   ),
              //   DropdownButton(
                  
              //     value: _selectedEmergency,
              //     items: _dropdownMenuItems,
              //     onChanged: onChangeDropdownItem,
              //   ),
              //   SizedBox(
              //     height: 30.0,
              //   ),
              //   new Padding(padding: EdgeInsets.only(top: 30.0)),
              //          new Text(
              //         'Describe the Emergency',
              //          style: new TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 24.0,),  
              //          ),

           new Padding(padding: EdgeInsets.only(top: 35.0)),

          //  This is the beginning of the textfield
           Text("Please Describe The Incident", style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        
                      )
                      ),
                // This begings the TextField 
                new Container(width: 300.0,
                  child: 
                  TextFormField(
                    
                    controller: _text,
                    style: TextStyle(height: 1),
                    cursorColor:  Color.fromRGBO(211, 11, 52, 1), 
                    cursorWidth: 3.0,
                    maxLength:100,
                    maxLines: 3,
                    minLines: 1,
                    decoration: 
                    
                  InputDecoration(
                    
                     hintText: 'A man around 20s got hit by a car.',
                     hintStyle: new TextStyle(height: 4,),
                     labelText: "Enter Text", 
                     errorText: _validate ? 'Please Fill This Out' : null,
                     labelStyle: new TextStyle( height:6,fontSize:16, fontWeight: FontWeight.bold, color: Colors.black),  
                     focusedBorder: const OutlineInputBorder(
                     borderSide: const BorderSide(color: Colors.white),
                    ) ,
                  ),
                ),
              ),

                // The Submit button is below and will validate the textfield/drop down.
                
                    new Padding(padding: EdgeInsets.only(top: 40.0 )),
                      RaisedButton(
                      onPressed: () {
                      
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                       
                      }
                      setState(() {
                        _text.text.isEmpty ? _validate = true : _validate = false;
                        _autovalidate = true;
                        
                      });
                      
                    },
                    child: Text('Submit', style: new TextStyle(color: Colors.white),),              
                    color: Color.fromRGBO(211, 11, 52, 1),),




              ],
              
            ),
            
          ),
         ),
        ),
    );
  }
}

