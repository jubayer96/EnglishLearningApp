import 'package:flutter/material.dart';
import 'package:go_eng/questions/intermediate/iquestion2.dart';

class IQuestion1 extends StatefulWidget {
  final String email;
  IQuestion1(this.email, {Key key}) : super(key: key);
  @override
  _IQuestion1 createState() => _IQuestion1();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _IQuestion1 extends State<IQuestion1> {
  List<String> options = [];
  var widthX = 150.0;
  var heightY = 150.0;
  var pad = 0.0;  

  int score = 0;
  String type = "intermediate"; 
  String tempEmail;

  bool check = true;

  List<String> answer = [];
  var quesNo = 1;
  var question = "She (soon) was tired so she sat down to have a rest. - rearrange to correct order.";

  void optionList() {
    for (int i = 0; i < 4; i++) {
      answer.add("");
    }
    options.add("Soon she was tired so she sat down to have a rest.");
    options.add("She was tired so she sat soon down to have a rest.");
    options.add("She was tired so she sat down to have soon a rest.");
    options.add("She was tired soon so she sat down to have a rest.");
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
            style: TextStyle(color: Colors.white, fontSize: 10.0),
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
              fontSize: 10,
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
                      return new IQuestion2(tempEmail, score, type);
                    }));
                },
              ),
            ],
          );
        } else
          return AlertDialog(
            title: new Text("Oops...! Wrong Answer"),
            content: new Text("Correct Answer: Soon she was tired so she sat down to have a rest."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Next"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new IQuestion2(tempEmail, score, type);
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
                if(answer.elementAt(0) == "Soon she was tired so she sat down to have a rest."){
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
