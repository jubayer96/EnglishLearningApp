import 'package:flutter/material.dart';

class Question1 extends StatefulWidget {
  @override
  _Question1 createState() => _Question1();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _Question1 extends State<Question1> {
  List<String> options = [];
  var widthX = 150.0;
  var heightY = 150.0;
  var pad = 0.0;

  bool check = true;

  List<String> answer = [];
  var quesNo = 1;
  var question =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  void optionList() {
    for (int i = 0; i < 5; i++) {
      options.add("dolor" + "$i");
      answer.add("");
    }
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
          widthX = 250.0;
          heightY = 250.0;
          pad = 30.0;
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

  @override
  Widget build(BuildContext context) {
    if (check) {
      optionList();
      check = false;
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
              "Question ($quesNo/10)",
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
                for (var i = 0; i < 5; i++) {
                  String x = answer.elementAt(i);
                  scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text("$x")));
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
