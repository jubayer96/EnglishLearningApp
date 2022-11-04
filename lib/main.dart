import 'package:flutter/material.dart';
import 'package:go_eng/login.dart';
import 'package:go_eng/questions/advanced/aquestion1.dart';
import 'package:go_eng/questions/beginner/bquestion1.dart';
import 'package:go_eng/questions/intermediate/iquestion1.dart';
import 'package:go_eng/splashScreen.dart';


import 'database/db_helper.dart';
import 'database/user.dart';

void main() => runApp(MaterialApp(
      home: SplashScreen(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String email; //if you have multiple values add here
  MyHomePage(this.email, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String tempEmail;
  int beginnerMark;
  int intermediateMark;
  int advancedMark;
  bool check = true;

  var dbHelper;

  @override
  void initState() {
    setState(() {
      dbHelper = DBHelper();
    });
    super.initState();
  }

  Text beginnerMarks() {
    dbHelper.getUser().then((users) {
      for (User temp in users) {
        if (temp.email == widget.email)        
          setState(() => beginnerMark = temp.beginnerMark);          
      }
    });
    if (beginnerMark != null) {
      return Text(
        "$beginnerMark" + "/3",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    } else {
      return Text(
        "Not answered yet",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    }
  }

  Text intermediateMarks() {
    dbHelper.getUser().then((users) {
      for (User temp in users) {
        if (temp.email == widget.email)        
          setState(() => intermediateMark = temp.intermediateMark);          
      }
    });
    if (intermediateMark != null) {
      return Text(
        "$intermediateMark" + "/3",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    } else {
      return Text(
        "Not answered yet",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    }
  }

  Text advancedMarks() {
    dbHelper.getUser().then((users) {
      for (User temp in users) {
        if (temp.email == widget.email)        
          setState(() => advancedMark = temp.advancedMark);          
      }
    });
    if (advancedMark != null) {
      return Text(
        "$advancedMark" + "/3",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    } else {
      return Text(
        "Not answered yet",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontSize: 15,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (check) {
      tempEmail = widget.email;
    }

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
                      SizedBox(height: 70),
                      Text(
                        "Beginner",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 20),
                      beginnerMarks(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new BQuestion1(tempEmail);
                    }));
                  },
                ),
              ),
            ),
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
                      SizedBox(height: 70),
                      Text(
                        "Intermediate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 20),
                      intermediateMarks(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new IQuestion1(tempEmail);
                    }));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 210,
              width: 380,
              child: Container(
                child: RaisedButton(
                  color: Color.fromRGBO(62, 126, 163, 1.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 70),
                      Text(
                        "Advanced",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 20),
                      advancedMarks(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new AQuestion1(tempEmail);
                    }));
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
