import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:public_unity_app/Screens/login.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;


class SignUpCard extends StatefulWidget {

  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {

  GlobalKey<FormFieldState> _formFirstNameSC = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState> _formLastNameSC = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState> _formEmailIdSC = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState> _formPasswordSC = GlobalKey<FormFieldState<String>>();


  GlobalKey<FormState>_SignUpCardKey = GlobalKey<FormState>(debugLabel: '_SignUpCardKey');

  GlobalKey<FormState> _keyLoaderSubmissionSignUp = new GlobalKey<FormState>(debugLabel: '_keyLoaderSubmissionSignUp');

  TextEditingController _firstNameControllerSC = TextEditingController(text: "");
  TextEditingController _lastNameControllerSC = TextEditingController(text: "");
  TextEditingController _emailControllerSC = TextEditingController(text: "");

  TextEditingController _passwordControllerSC = TextEditingController(text: "");
  bool _isFirstResponder = false;
  String strFilePathFirstResponder = "";
  String strFileNameFirstResponder = "";

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

  Future filePicker(BuildContext context) async {
    try {
        var file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['jpg','pdf','doc','jpeg','gif']);

        setState(() {
          strFilePathFirstResponder = file.path;
          strFileNameFirstResponder = path.basename(file.path);
        });
        print(strFilePathFirstResponder);
        print(strFileNameFirstResponder);

    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _SignUpCardKey,
      autovalidate:false,
      child: new Container(
        width: double.infinity,
        //height: ScreenUtil.getInstance().setHeight(500),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Sign Up",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("First Name",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                key: _formFirstNameSC,
                controller: _firstNameControllerSC,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter First Name.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "First Name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Last Name",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                key: _formLastNameSC,
                controller: _lastNameControllerSC,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Last Name.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Last Name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Email Id",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                key: _formEmailIdSC,
                controller: _emailControllerSC,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email-Id.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Email-Id",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Password",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                key: _formPasswordSC,
                controller: _passwordControllerSC,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Password.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Text("SignUp as Professional user",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(28))),
              Row(
                children: <Widget>[
                  Text("Or First Responder",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  Switch(
                    value: _isFirstResponder,
                    onChanged: (value) {
                      setState(() {
                        _isFirstResponder = value;
                        print(_isFirstResponder);

                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),

              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),

              Row(
                 children: <Widget>[
                  Text("Upload Id Proof",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(28))),
                   SizedBox(
                     width: ScreenUtil.getInstance().setWidth(40),
                   ),


                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(160),
                      height: ScreenUtil.getInstance().setHeight(60),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea)
                          ]),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child:
                        InkWell(
                          onTap: () async {

                            filePicker(context);

                          },
                          child: Center(
                            child: Text("Browse",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 16,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

          Text('$strFileNameFirstResponder',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(25),
                  fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(300),
                      height: ScreenUtil.getInstance().setHeight(70),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea)
                          ]),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child:
                        InkWell(
                          onTap: () async {
                            if (_formFirstNameSC.currentState.validate() &&
                                _formLastNameSC.currentState.validate() &&
                                _formEmailIdSC.currentState.validate() &&
                                _formPasswordSC.currentState.validate()) {

                              if(_isFirstResponder && strFilePathFirstResponder == '')
                              {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Id Proof'),
                                        content: Text('As First Responder, Id Proof is require to upload.'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                );
                              }
                              else {

                                showLoadingDialog(context, _keyLoaderSubmissionSignUp);//invoking login


                                String res = await AuthProvider().signUpWithEmail(
                                    _firstNameControllerSC.text.trim(),
                                    _lastNameControllerSC.text.trim(),
                                    _emailControllerSC.text.trim(),
                                    _passwordControllerSC.text.trim(),
                                    _isFirstResponder,
                                    strFileNameFirstResponder,
                                    strFilePathFirstResponder);

                                Navigator.of(_keyLoaderSubmissionSignUp.currentContext,rootNavigator: true).pop();//close the dialogue

                                if(res =="1") {//Signup Success
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('SignUp'),
                                        content: const Text(
                                            'Please click on the link sent to your email account to verify your email and complete the SignUp process.'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(context, "/");
                                           /*   Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()),
                                              );*/
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                else if(res =="2") { //Signup failed
                                  print("Invalid Email and password entered.");
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('SignUp Failed'),
                                        content: const Text(
                                            'Invalid Email and password entered.'),
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
                                else {//exception
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('SignUp Failed'),
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
                          },
                          child: Center(
                            child: Text("SIGNUP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              )
            ],
          ),
        ),
      ),
    );
  }
}
