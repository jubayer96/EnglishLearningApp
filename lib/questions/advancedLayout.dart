import 'package:flutter/material.dart';

class AdvancedLayout extends StatefulWidget {
  @override
  _AdvancedLayout createState() => _AdvancedLayout();
}

class _AdvancedLayout extends State<AdvancedLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          child: Text('Go back to First Screen'),
          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
