import 'package:flutter/material.dart';
import 'package:go_eng/database/db_helper.dart';
import 'package:go_eng/login.dart';
import 'package:go_eng/teacher/viewResult.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHome createState() => _TeacherHome();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _TeacherHome extends State<TeacherHome> {
  String tempEmail;
  bool check = true;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("goEng"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new LoginPage();
              }));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 215,
              width: 380,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: RaisedButton(
                  color: Color.fromRGBO(62, 126, 163, 1.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 80),
                      Text(
                        "View Result",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new ViewResult();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    "goEng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
