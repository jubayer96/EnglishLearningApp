import 'package:flutter/material.dart';
import 'package:go_eng/questions/beginner/bquestion2.dart';

class BQuestion1 extends StatefulWidget {
  final String email;
  BQuestion1(this.email, {Key key}) : super(key: key);
  @override
  _BQuestion1 createState() => _BQuestion1();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _BQuestion1 extends State<BQuestion1> {
  List<String> options = [];
  var widthX = 150.0;
  var heightY = 150.0;
  var pad = 0.0;  

  int score = 0;
  String type = "beginner"; 
  String tempEmail;

  bool check = true;

  List<String> answer = [];
  var quesNo = 1;
  var question = "Which phrase often goes at the end of a story?";

  void optionList() {
    for (int i = 0; i < 4; i++) {
      answer.add("");
    }
    options.add("One day");
    options.add("Soon");
    options.add("Then");
    options.add("In the end");
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
                 Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new BQuestion2(tempEmail, score, type);
                    }));
                },
              ),
            ],
          );
        } else
          return AlertDialog(
            title: new Text("Oops...! Wrong Answer"),
            content: new Text("Correct Answer: In the end"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Next"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new BQuestion2(tempEmail, score, type);
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
          SizedBox(height: 15),
          Container(
            width: 380,
            height: 250,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(198, 197, 214, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "$question",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 15),
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
                if(answer.elementAt(0) == "In the end"){
                  correct = true;
                  score++;
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
