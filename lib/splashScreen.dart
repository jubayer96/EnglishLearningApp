import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_eng/login.dart';
import 'package:go_eng/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Color.fromRGBO(130, 178, 220, 1),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
          ),
          Text(
            "goEng Chapter 3",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 250,
          ),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
