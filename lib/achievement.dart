import 'package:flutter/material.dart';
import 'package:go_eng/database/user.dart';
import 'database/db_helper.dart';
import 'main.dart';

class Achievement extends StatefulWidget {
  final String email;
  final int score;
  final String type;
  Achievement(this.email, this.score, this.type, {Key key}) : super(key: key);
  @override
  _Achievement createState() => _Achievement();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _Achievement extends State<Achievement> {
  int awardScore;
  String tempType;
  String tempEmail;

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
    awardScore = widget.score;
    tempType = widget.type;
    tempEmail = widget.email;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Center(
          child: Text("Beginner"),
        ),
      ),
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          SizedBox(height: 120),
          Center(
            child: Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset('assets/images/award.png'),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Your score is: $awardScore/3",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 70),
          Container(
            height: 50,
            width: 300,
            child: RaisedButton(
              color: Color.fromRGBO(181, 11, 11, 1.0),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15),
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(
                  "Back to Homescreen",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {
                dbHelper.getUser().then(
                  (users) {
                    for (User temp in users) {
                      if (tempEmail == temp.email) {
                        if (tempType == "beginner")
                          temp.beginnerMark = awardScore;
                        else if (tempType == "advanced")
                          temp.advancedMark = awardScore;
                        else if (tempType == "intermediate")
                          temp.intermediateMark = awardScore;

                        dbHelper.update(temp);
                      }
                    }
                  },
                );
                Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new MyHomePage(tempEmail);
                    }));          
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
