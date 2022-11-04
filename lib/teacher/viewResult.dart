import 'package:flutter/material.dart';
import 'package:go_eng/database/db_helper.dart';
import 'package:go_eng/database/user.dart';

class ViewResult extends StatefulWidget {
  @override
  _ViewResult createState() => _ViewResult();
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

class _ViewResult extends State<ViewResult> {
  String tempEmail;
  bool check = true;

  var dbHelper;
  var data = List<User>();

  @override
  void initState() {
    setState(() {
      dbHelper = DBHelper();
      resultData();
    });
    super.initState();
  }

  void resultData() {
      dbHelper.getUser().then((users) {
        for (User temp in users) {
          if (temp.type == "student")
              setState(() => data.add(temp));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Result"),
      ),
      body: DataTable(
        columnSpacing: 22,
        columns: [
          DataColumn(label: Text("Username")),
          DataColumn(label: Text("Beginner")),
          DataColumn(label: Text("Intermediate")),
          DataColumn(label: Text("Advanced")),
        ],
        rows: data
            .map((user) => DataRow(cells: [
                  DataCell(Text(user.email)),
                  DataCell(Text(user.beginnerMark.toString())),
                  DataCell(Text(user.intermediateMark.toString())),
                  DataCell(Text(user.advancedMark.toString())),
                ]))
            .toList(),
      ),
      backgroundColor: Color.fromRGBO(130, 178, 220, 1),
    );
  }
}
