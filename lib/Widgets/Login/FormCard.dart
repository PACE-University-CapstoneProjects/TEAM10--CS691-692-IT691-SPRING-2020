import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:public_unity_app/main.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:public_unity_app/Screens/resetPassword.dart';


class FormCard extends StatefulWidget {


  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  GlobalKey<FormFieldState> _formEmailId = new GlobalKey<FormFieldState<String>>(debugLabel: '_formEmailId');
  GlobalKey<FormFieldState> _formPassword = new GlobalKey<FormFieldState<String>>(debugLabel: '_formPassword');

  GlobalKey<FormState>_FormCardKey = new GlobalKey<FormState>(debugLabel: '_FormCardKey');

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _FormCardKey,
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
              Text("Sign In",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Email Id",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                key: _formEmailId,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email-Id.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
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
                key: _formPassword,
                controller: _passwordController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                       context,
                        MaterialPageRoute(builder: (context) => ResetPassword()),
                     );
                    },
                    child: Text('Forgot Password?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Poppins-Medium",

                            fontSize: ScreenUtil.getInstance().setSp(25)
                        )),
                  ),

                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(280),
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
                            if (_formPassword.currentState.validate() && _formPassword.currentState.validate()) {
                              String res = await AuthProvider().signInWithEmail(_emailController.text.trim(), _passwordController.text.trim());

                              if(res == "1") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                );

                              }
                              else if(res == "2") {
                                print('Please click on the link sent to your email account to verify your email and complete the SignUp process.');
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Failed'),
                                      content: const Text('Please click on the link sent to your email account to verify your email and complete the SignUp process.'),
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
                              else if(res != "1"){
                                String strErroMsg;
                                if(res == "3")
                                  strErroMsg = 'Invalid Email and password entered.';
                                else
                                  strErroMsg = res;

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Failed'),
                                      content: Text(strErroMsg),
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
                          },
                          child: Center(
                            child: Text("SIGNIN",
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
