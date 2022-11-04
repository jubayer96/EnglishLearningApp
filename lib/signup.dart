import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_eng/database/db_helper.dart';
import 'package:go_eng/database/user.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  var choice = "student";
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
            child: Text(
              'goEng',
              style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      new Radio(
                        value: "student",
                        groupValue: choice,
                        onChanged: (value) {
                          setState(() {
                            choice = value;
                          });
                        },
                      ),
                      new Text(
                        'Student',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: "teacher",
                        groupValue: choice,
                        onChanged: (value) {
                          setState(() {
                            choice = value;
                          });
                        },
                      ),
                      new Text(
                        'Teacher',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'USERNAME',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: passController,
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
                SizedBox(height: 10.0),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'NICK NAME',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 50.0),
                Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          User user = User(
                              email: emailController.text,
                              pass: passController.text,
                              name: nameController.text,
                              type: choice);
                          bool check = false;
                          dbHelper.getUser().then(
                            (users) {
                              for (User temp in users) {
                                var tempEmail = temp.email;
                                if (emailController.text == tempEmail)
                                  check = true;
                              }
                              if (check) {
                                Fluttertoast.showToast(
                                    msg: "Email Already Registered!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                dbHelper.insert(user);
                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                        child: Center(
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text('Go Back',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
