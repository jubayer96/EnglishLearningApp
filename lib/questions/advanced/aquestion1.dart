import 'package:flutter/material.dart';
import 'package:go_eng/achievement.dart';

class AQuestion1 extends StatefulWidget {
  final String email;
  AQuestion1(this.email, {Key key}) : super(key: key);
  @override
  _AQuestion1 createState() => _AQuestion1();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _AQuestion1 extends State<AQuestion1> {
  List<String> options = [];
  var widthX = 150.0;
  var heightY = 150.0;
  var pad = 0.0;  

  int score = 0;
  String type = "advanced"; 
  String tempEmail;

  bool check = true;

  List<String> answer = [];
  var quesNo = 1;
  var question = "1.	Hi Emma! Something really strange happened to me today. I (1)... (walk) home from school and suddenly lots of apples started falling out of the sky. I couldn't believe it! It (2)... (rain) apples! Where (3) ... they... (come) from? I went home and told my mum and brother, but they said I (4).. (not tell) the truth. However, that evening, my mum and dad (5) ... (watch) the news on TV and they heard the story. Nobody knows why the apples fell out of the sky, but they did. - key in correct form";

  void optionList() {
    for (int i = 0; i < 4; i++) {
      answer.add("");
    }
    options.add("walked");
    options.add("did come");
    options.add("was raining");
    options.add("watched");
    options.add("didn't tell");

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
                      return new Achievement(tempEmail, score, type);
                    }));
                },
              ),
            ],
          );
        } else
          return AlertDialog(
            title: new Text("Oops...! Wrong Answer"),
            content: new Text("Correct Answer: walked, was raining , did come, didn't tell, watched"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Next"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return Achievement(tempEmail, score, type);
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
          child: Text("Advanced"),
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
                fontSize: 15,
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
                if(answer.elementAt(0) == "walked" && answer.elementAt(1) == "was raining" && answer.elementAt(2) == "did come" &&answer.elementAt(3) == "didn't tell" && answer.elementAt(4) == "watched"){
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
