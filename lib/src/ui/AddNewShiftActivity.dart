import 'package:flutter/material.dart';
import 'DateRowComponent.dart';
class AddNewShiftActivity extends StatefulWidget {
  @override
  AddNewShiftActivityState createState() => AddNewShiftActivityState();
}

class AddNewShiftActivityState extends State<AddNewShiftActivity> {

  var gotTheDate = "NO DATE";

  void printDate(String date) {
    setState(() {
      gotTheDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeeeee),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Add new shift"),
      ),
      body: Column(
        children: <Widget>[
            DateRowComponent(
              onPressed: printDate,
            ),
          Text(
            '$gotTheDate'
          )
        ],
      ),
    );
  }
}
