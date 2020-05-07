import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'ReportIncident.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewReportIncident extends StatefulWidget{
  NewReportIncident() : super();

  @override
  _NewReportIncidentPageState createState() => new _NewReportIncidentPageState();
}
/*
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
}*/
class _NewReportIncidentPageState extends State <NewReportIncident> {
  final _formKeyIncidentDetailsForm = GlobalKey<FormState>(debugLabel: '_formKeyIncidentDetailsForm');

  final _formDescription = GlobalKey<FormFieldState<String>>(debugLabel: '_formDescription');
 // Key _formDescription = new GlobalKey();


  final _keyLoaderSubmissionIncident = new GlobalKey<FormState>(debugLabel: '_keyLoaderSubmissionIncident');

  final FocusNode _focusNode = new FocusNode();



  bool _autovalidate = false;
  String selectedMedical;
  String userAddress, latitude, longitude;

  //String name;

// validate the textField
  TextEditingController _txtDescriptionController;
  //bool _validate = false;

/*
// These variables are for the dropdown menu
  List<MedicalEmergency> _emergency = MedicalEmergency.getEmergencies();
  List<DropdownMenuItem<MedicalEmergency>> _dropdownMenuItems;
  MedicalEmergency  _selectedEmergency;*/




// delcare variables for radio buttons
  int selectedRadioConsious;
  int selectedRadioBreathing;
  int selectedRadioBleeding;





  _getUserLocation() async
  {
    //print('_getUserLocation');
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${position.latitude}');

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    //print("${first.featureName} : ${first.addressLine}");

    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      userAddress = first.addressLine;
    });
  }



  @override
// Validation for Textfield
  void dispose() {
     _focusNode.dispose();
    _txtDescriptionController.dispose();
    super.dispose();
  }


  /*void setFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }*/



  @override
  void initState() {
    super.initState();
    _txtDescriptionController = TextEditingController();
    //_focusNode = new FocusNode();
    //_focusNode.addListener(() => print('focusNode updated: hasFocus: ${_focusNode.hasFocus}'));


    // gave variables 0
    selectedRadioConsious =0;
    selectedRadioBreathing = 0;
    selectedRadioBleeding =0;

   /* _dropdownMenuItems = buildDropdownMenuItems(_emergency );
    _selectedEmergency  = _dropdownMenuItems[0].value;*/
    _getUserLocation();

    //_focusNode.addListener(_focusNodeListener);

  }

// created three different selectedRadio for each set of yes/no for three set of questions
  setSelectedRadioConsious (int val){
    setState(() {
      selectedRadioConsious = val;
    });
  }


  setSelectedRadioBreathing (int val){
    setState(() {
      selectedRadioBreathing = val;
    });
  }

  setSelectedRadioBleeding (int val){
    setState(() {
      selectedRadioBleeding = val;
    });


  }

/*

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
  }*/

/*
  onChangeDropdownItem(MedicalEmergency selectedEmergency) {
    setState(() {
      _selectedEmergency = selectedEmergency;
    });
  }
*/

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





  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }


  @override
  Widget build (BuildContext context) {

    return new Scaffold(

      resizeToAvoidBottomPadding: true,

      appBar: new AppBar(

        leading:
        new IconButton(
          //  the back button will send the user to the 'Home Screen' : Civilian Role
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () { Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context ) => new ReportIncident()));
            }
        ),
        title: new Text("Public Unity Safety1"),

        backgroundColor: Color.fromRGBO(211, 11, 52, 1),
      ),

      endDrawer: MainDrawer(),

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
                      groupValue: selectedRadioConsious,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 1 $val");
                        setSelectedRadioConsious(val);
                      },
                    ),
                    Text(
                      'Yes',
                      style: TextStyle(fontSize: 16.0),
                    ),

                    Radio(
                      value: 2,
                      groupValue: selectedRadioConsious,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 1 $val");
                        setSelectedRadioConsious(val);
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
                      value: 1,
                      groupValue: selectedRadioBreathing,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 2 $val");
                        setSelectedRadioBreathing(val);
                      },

                    ),
                    Text(
                      'Yes',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 2,
                      groupValue: selectedRadioBreathing,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 2 $val");
                        setSelectedRadioBreathing(val);
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
                      value: 1,
                      groupValue: selectedRadioBleeding,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 3 $val");
                        setSelectedRadioBleeding(val);
                      },

                    ),
                    Text(
                      'Yes',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 2,
                      groupValue: selectedRadioBleeding,
                      activeColor: Color.fromRGBO(211, 11, 52, 1),
                      onChanged: (val){
                        print("Radio Set 3 $val");
                        setSelectedRadioBleeding(val);
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
                  key: _formKeyIncidentDetailsForm,
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
                  new TextFormField(
                      key: _formDescription,
                      controller: _txtDescriptionController,
                      //autofocus: true,
                      //textInputAction: TextInputAction.done,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.multiline,

                    style: TextStyle(height: 1),
                    validator: (value) {
                      if (value.isEmpty || value == null ) {
                        return 'Please describe the incident.';
                      }
                      return null;
                    },
                    //cursorColor:  Color.fromRGBO(211, 11, 52, 1),
                    //cursorWidth: 3.0,
                    maxLength:100,
                    maxLines: 3,
                    minLines: 1
               /*     decoration:

                    InputDecoration(
                      hintText: 'A man around 20s got hit by a car.',
                      hintStyle: new TextStyle(height: 4,),
                      labelText: "Enter Text",
                      // errorText: _validate ? 'Please Fill This Out' : null,
                      labelStyle: new TextStyle( height:6,fontSize:16, fontWeight: FontWeight.bold, color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                      ) ,
                    ),*/
                  ),
                ),

                // The Submit button is below and will validate the textfield/drop down.
                new Padding(padding: EdgeInsets.only(top: 40.0 )),
                RaisedButton(
                  onPressed: () async {
                    print('called');

                    if(_formKeyIncidentDetailsForm.currentState.validate()
                        && _formDescription.currentState.validate()){
                      print(userAddress);
                      if(selectedRadioConsious == 0
                          || selectedRadioBreathing == 0
                          || selectedRadioBleeding == 0) {

                        String txtAlert ='';
                        if(selectedRadioConsious ==0)
                          txtAlert ='Please select patient consious option.';
                        else if(selectedRadioBreathing ==0)
                          txtAlert ='Please select patient breathing option.';
                        else if(selectedRadioBleeding ==0)
                          txtAlert ='Please select patient bleeding option.';

                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Incident Detail Missing'),
                              content:  Text(txtAlert),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else {
                        print(selectedMedical);
                        print(_txtDescriptionController.text.toString());

                        showLoadingDialog(context, _keyLoaderSubmissionIncident);//invoking login

                        String res = await AuthProvider().addNewIncident(
                            userAddress.trim(),
                            selectedRadioConsious,
                            selectedRadioBreathing,
                            selectedRadioBleeding,
                            _txtDescriptionController.text.trim(),
                            selectedMedical.toString(),
                        latitude,
                        longitude);

                        Navigator.of(_keyLoaderSubmissionIncident.currentContext,rootNavigator: true).pop();//close the dialogue

                        if(res =="1") {//Signup Success
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Incident Reported'),
                                content: const Text(
                                    'Reported incident is notified to Responders.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new ReportIncident()));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else {//exception
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error while reporting an incident'),
                                content: Text(res),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    }
/*                      setState(() {
                        _txtDescriptionControllerSC.text.isEmpty ? _validate = true : _validate = false;
                        _autovalidate = true;

                      });*/

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

