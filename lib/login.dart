import 'package:flutter/material.dart';
import 'package:go_eng/database/db_helper.dart';
import 'package:go_eng/database/user.dart';
import 'package:go_eng/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_eng/teacher/teacherHome.dart';

import 'signup.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final uemail = new TextEditingController();
  final upass = new TextEditingController();

  String userEmail;
  String userPass;

  var dbHelper;

  @override
  void initState() {
    setState(() {
      dbHelper = DBHelper();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('goEng',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: uemail,
                  decoration: InputDecoration(
                      labelText: 'USERNAME',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: upass,
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  height: 40,
                  child: Container(
                    child: RaisedButton(
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.transparent),
                      ),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        bool check = false;
                        String type;
                        String email;
                        dbHelper.getUser().then(
                          (users) {
                            for (User temp in users) {
                              var tempEmail = temp.email;
                              var tempPass = temp.pass;
                              if (uemail.text == tempEmail &&
                                  upass.text == tempPass) {
                                email = tempEmail;
                                type = temp.type;
                                check = true;
                              }
                            }
                            if (check) {
                              if(type == "student") {
                                Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new MyHomePage(email);
                                  },
                                ),
                              );
                              }
                              else if(type == "teacher"){
                                Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new TeacherHome();
                                  },
                                ),
                              );
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Invalid Login!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to goEng ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new SignupPage();
                  }));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
