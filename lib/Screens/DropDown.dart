import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();
 
  final String title = "DropDown Demo";
 
  @override
  DropDownState createState() => DropDownState();
}
 
// For the DropDown Menu, id is the value that corresponds to the name of the medical emergency for dropDown Menu


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

// class MedicalEmergency2 {
//   int id;
//   String name;
//   MedicalEmergency2(this.id, this.name);
//   static List<MedicalEmergency2> getEmergencies2() {
//     return <MedicalEmergency2>[
//       MedicalEmergency2(1, 'Difficult'),
//       MedicalEmergency2(2, 'Choking'),
    
//     ];
//   }
// }


// class MedicalEmergency3 {
//   int id;
//   String name;
//   MedicalEmergency3(this.id, this.name);
//   static List<MedicalEmergency3> getEmergencies3() {
//     return <MedicalEmergency3>[
//       MedicalEmergency3(1, 'Infant'),
//       MedicalEmergency3(2, 'Child'),
//       MedicalEmergency3(3, 'Elderly'),

    
//     ];
//   }
// }
  
class DropDownState extends State<DropDown> {
  //
  List<MedicalEmergency> _emergency = MedicalEmergency.getEmergencies();
  // List<MedicalEmergency2> _emergency2 = MedicalEmergency2.getEmergencies2();
  // List<MedicalEmergency3> _emergency3= MedicalEmergency3.getEmergencies3();

  List<DropdownMenuItem<MedicalEmergency>> _dropdownMenuItems;
  // List<DropdownMenuItem<MedicalEmergency2>> _dropdownMenuItems2;
  // List<DropdownMenuItem<MedicalEmergency3>> _dropdownMenuItems3;

  MedicalEmergency  _selectedEmergency;
  // MedicalEmergency2 _selectedEmergency2;
  // MedicalEmergency3 _selectedEmergency3;
 
// selected Radio when the user selects the radio button, it toggles
int selectedRadio;




  @override
  void initState() {

    selectedRadio =0;

    
    _dropdownMenuItems = buildDropdownMenuItems(_emergency );
    // _dropdownMenuItems2 = buildDropdownMenuItems2(_emergency2);
    // _dropdownMenuItems3 = buildDropdownMenuItems3(_emergency3);

    _selectedEmergency  = _dropdownMenuItems[0].value;
    // _selectedEmergency2 = _dropdownMenuItems2[0].value;
    // _selectedEmergency3 = _dropdownMenuItems3[0].value;
    super.initState();
  }


  setSelectedRadio (int val){
    setState(() {
      selectedRadio = val;
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

  //   List<DropdownMenuItem<MedicalEmergency2>> buildDropdownMenuItems2(List emergencies2) {
  //   List<DropdownMenuItem<MedicalEmergency2>> items = List();
  //   for (MedicalEmergency2 emergency2 in emergencies2) {
  //     items.add(
  //       DropdownMenuItem(
  //         value: emergency2,
  //         child: Text(emergency2.name),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  //   List<DropdownMenuItem<MedicalEmergency3>> buildDropdownMenuItems3(List emergencies3) {
  //   List<DropdownMenuItem<MedicalEmergency3>> items = List();
  //   for (MedicalEmergency3 emergency3 in emergencies3) {
  //     items.add(
  //       DropdownMenuItem(
  //         value: emergency3,
  //         child: Text(emergency3.name),
  //       ),
  //     );
  //   }
  //   return items;
  // }
 
  onChangeDropdownItem(MedicalEmergency selectedEmergency) {
    setState(() {
     _selectedEmergency = selectedEmergency;
    });
  }

  //  onChangeDropdownItem2(MedicalEmergency2 selectedEmergency2) {
  //   setState(() {
  //    _selectedEmergency2 = selectedEmergency2;
  //   });
  // }

  //  onChangeDropdownItem3(MedicalEmergency3 selectedEmergency3) {
  //   setState(() {
  //    _selectedEmergency3 = selectedEmergency3;
  //   });
  // }
 

//  String email = 'ksaini7595@gmail.com';
// _launchEmail() async {
  
//    if (await canLaunch("mailto:$email")) {
//         await launch("mailto:$email");
//       } else {
//         throw 'Could not launch';
//       }
//     }


// email function for the endDrawer widget, for the Contact Us Link
_launchEmail() async {
    // ios specification
    final String subject = "Subject:";
    final String stringText = "Same Message:";
    String uri = 'mailto:ksaini7595@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
           resizeToAvoidBottomPadding: false,
           resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          leading: 
          new IconButton(
              //  the back button will send the user to the 'Home Screen' : Civilian Role
               icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: () => Navigator.of(context).pop(),
              ), 
          title: new Text("Public Unity Safety"),
          backgroundColor: Color.fromRGBO(211, 11, 52, 1),
        ),
        endDrawer: MainDrawer(),


        body: new Container(
          
          child: Center(
            // This will remove the padding black and yellow stripes warning
            // user can scroll down as the phone rotates left or right
            child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            new Padding(padding: EdgeInsets.only( left:15.0 , top:15.0),),

              //  The beginning of the set of three radio button questions.
                new Text(
                      'Is patient consious?',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )
                ),

            //  new Padding(
            //           padding: new EdgeInsets.all(5.0),
            //         ),

            // this is new row for the radio buttons: Yes/No
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 1 $val");
                            setSelectedRadio(val);
                          },
                          
                        ),
                       Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                       Divider(height: 20,color: Colors.green),
                        Radio(
                         value: 2,
                          groupValue: selectedRadio,
                          activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 1 $val");
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

  //  The beginning of the second question
                      Text(
                      'Is patient breathing?',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    // new Padding(
                    //   padding: new EdgeInsets.all(5.0),
                    // ),
                      //  new row for the second row yes/no
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         Radio(
                          value: 3,
                          groupValue: selectedRadio,
                          activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 1 $val");
                            setSelectedRadio(val);
                          },
                          
                        ),
                         Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 4,
                          groupValue: selectedRadio,
                            activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 2 $val");
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
                    //   the beginning of the third question
                    Text(
                      'Is patient bleeding heavily?',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    //    new Padding(
                    //   padding: new EdgeInsets.all(5.0),
                    // ),

                    // The third set of radio buttons for the third question
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       new Radio(
                        value: 5,
                          groupValue: selectedRadio,
                          activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 1 $val");
                            setSelectedRadio(val);
                          },
                          
                        ),
                        Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 6,
                          groupValue: selectedRadio,
                          activeColor: Colors.red,
                          onChanged: (val){
                            print("Radio 1 $val");
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
                  
           new Padding(
                         
            padding: EdgeInsets.only(top: 20.0)
                         
            ),
            
                  // The Beginning of the Drop Down Questions

                Text("Select Emergency Type", style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButton(
                  value: _selectedEmergency,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 10.0,
                ),




                
                   new Padding(padding: EdgeInsets.only(top: 30.0)),
                       new Text(
                      'Describe the Emergency',
                       style: new TextStyle( fontSize: 20.0),
                       
                       ),
                       new Padding(
                         
                         padding: EdgeInsets.only(top: 30.0)
                         
                         ),
                              
           
                
                new Container(
                  width: 200.0,
                  child: new TextField(
                       textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                     decoration: new InputDecoration(
                       contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                        labelText: "Enter Text", 
                        
                  
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(1.0),
                         
                        ),
                        //fillColor: Colors.green
                      ),
                  )
                ),
                
                // Text('Selected: ${_selectedEmergency.name}'),
            //        Text("Breathing",  style: new TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 24.0,
            //           )),
            //     SizedBox(
            //       height: 10.0,
            //     ),
            //     DropdownButton(
            //       value: _selectedEmergency2,
            //       items: _dropdownMenuItems2,
            //       onChanged: onChangeDropdownItem2,
            //     ),
            //     SizedBox(
            //       height: 50.0,
            //     ),
            //     Text("Who is injured?",  style: new TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 24.0,
            //           )),
            //     SizedBox(
            //       height: 10.0,
            //     ),
            //     DropdownButton(
            //       value: _selectedEmergency3,
            //       items: _dropdownMenuItems3,
            //       onChanged: onChangeDropdownItem3,
                 
            //     ),
            //     SizedBox(
            //       height: 50.0,
            //     ),



           new Padding(
                         
            padding: EdgeInsets.only(top: 30.0)
                         
            ),
            RaisedButton(
          
        
          onPressed: () {

          },
          
         child: Text('Submit', 
                          style: new TextStyle(
                            color: Colors.white,
                           
                          ),
                          ),
                          
        color: Color.fromRGBO(211, 11, 52, 1),
       

        ),
              ],
              
            ),
           
            ),
          ),
        ),
        
      ),
    );
  }
}