import 'package:flutter/material.dart';

class IntermediateLayout extends StatefulWidget {
  @override
  _IntermediateLayout createState() => _IntermediateLayout();
}

class _IntermediateLayout extends State<IntermediateLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        //child: RaisedButton(
          //color: Colors.red,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Add answer',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
            style: TextStyle(color: Colors.black, fontSize: 22.0),
          ),
        //   onPressed: () {
        //     //Use`Navigator` widget to pop oir go back to previous route / screen
        //     Navigator.pop(context);
        //   },
        // ),
      ),
    );
  }
}
