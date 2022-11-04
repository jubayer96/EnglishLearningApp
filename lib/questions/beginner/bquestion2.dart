import 'package:flutter/material.dart';
import 'package:go_eng/questions/beginner/bquestion3.dart';

class BQuestion2 extends StatefulWidget {
  final String email;
  final int score;
  final String type;
  BQuestion2(this.email, this.score, this.type, {Key key}) : super(key: key);
  @override
  _BQuestion2 createState() => _BQuestion2();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _BQuestion2 extends State<BQuestion2> {
  List<String> options = [];
  var widthX = 150.0;
  var heightY = 150.0;
  var pad = 0.0;

  bool check = true;
  int tempScore;
  String tempType;
  String tempEmail;

  List<String> answer = [];
  var quesNo = 2;

  void optionList() {
    for (int i = 0; i < 3; i++) {
      answer.add("");
    }
    options.add("dry");
    options.add("icy");
    options.add("muddy");
  }

  Draggable optionLoad(String item) {
    return Draggable<String>(
      data: "$item",
      child: Container(
        width: 150.0,
        height: 50.0,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            "$item",
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ),
      ),
      feedback: Container(
        width: 150.0,
        height: 50.0,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            "$item",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 150.0,
        height: 50.0,
        margin: EdgeInsets.all(5),
        color: Color.fromRGBO(130, 178, 220, 1),
      ),
      onDragCompleted: () {
        setState(() {
          int position = options.indexOf("$item");
          options.removeAt(position);
          // widthX = 250.0;
          // heightY = 250.0;
          // pad = 30.0;
        });
      },
    );
  }

  Container targetLoad(int index) {
    return Container(
      width: widthX,
      height: heightY,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.fromLTRB(pad, 0, 0, 0),
      child: DragTarget(
        builder: (context, List<String> candidateData, rejectedData) {
          return Center(
            child: Image.asset('assets/images/bin.png'),
          );
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          answer.insert(index, data);
        },
      ),
    );
  }

  void _showDialog(bool correct) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        if (correct) {
          return AlertDialog(
            title: new Text("Congratulation!"),
            content: new Text("Correct Answer"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Next"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new BQuestion3(tempEmail, tempScore, tempType);
                  }));
                },
              ),
            ],
          );
        } else
          return AlertDialog(
            title: new Text("Oops...! Wrong Answer"),
            content: new Text("Correct Answer: icy"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Next"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new BQuestion3(tempEmail, tempScore, tempType);
                  }));
                },
              ),
            ],
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (check) {
      optionList();
      check = false;
      tempScore = widget.score;
      tempType = widget.type;
      tempEmail = widget.email;
    }

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
          SizedBox(height: 5),
          Container(
              width: 380,
              height: 250,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Image.asset('assets/images/road.jpg')),
          Container(
            width: 380,
            height: 40,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(198, 197, 214, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "The road is _________.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var item in options) optionLoad(item),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: targetLoad(0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text(
              "Question ($quesNo/3)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 147.7,
            ),
            RaisedButton(
              color: Color.fromRGBO(181, 11, 11, 1.0),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {
                bool correct = false;
                if (answer.elementAt(0) == "icy") {
                  tempScore++;
                  correct = true;
                }
                _showDialog(correct);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
