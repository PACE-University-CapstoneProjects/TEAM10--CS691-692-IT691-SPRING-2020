import 'package:flutter/material.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:public_unity_app/Screens/login.dart';

class ResetPassword extends StatelessWidget {
  TextEditingController _emailResetController = TextEditingController(text: "");

 static final _formEmailIdReset = GlobalKey<FormFieldState<String>>();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: new Container (
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

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("Please enter an Email Id for password rest link.",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  key: _formEmailIdReset,
                  controller: _emailResetController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email-Id is missing.';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(250),
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
                              if (_formEmailIdReset.currentState.validate()) {
                                bool res = await AuthProvider().resetPassword(_emailResetController.text.trim());
                                if(!res) {
                                  print("Invalid Email-Id entered.");
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        //title: Text('Login Failed1'),
                                        content: const Text('Invalid Email-Id entered.'),
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
                                else
                                {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        //title: Text('Login Failed'),
                                        content: const Text('Reset Password link is sent to your email.'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Login()),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Center(
                              child: Text("RESET",
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
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}