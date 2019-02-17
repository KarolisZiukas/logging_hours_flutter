import 'package:flutter/material.dart';
import 'DateRowComponent.dart';
import 'TimePickerComponent.dart';

class AddNewShiftActivity extends StatefulWidget {
  @override
  AddNewShiftActivityState createState() => AddNewShiftActivityState();
}

class AddNewShiftActivityState extends State<AddNewShiftActivity> {
  var gotTheDate = "NO DATE";
  var gotTheTime = "NO TIME";

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
          Row(
            children: <Widget>[
              Flexible(
                child: TimePickerComponent(
                  onPressed: printDate,
                  whichValueToSelect: "Start",
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printDate,
                  whichValueToSelect: "End",
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: TimePickerComponent(
                  onPressed: printDate,
                  whichValueToSelect: "Start",
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printDate,
                  whichValueToSelect: "End",
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("TEXT"),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
