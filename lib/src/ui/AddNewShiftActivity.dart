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
  var gotTheTime2 = "NO TIME";

  void printDate(String date) {
    setState(() {
      gotTheDate = date;
    });
  }

  void printTime(ShiftTimeModel date) {
    setState(() {
      gotTheTime = date.hour.toString();
    });
  }

  void printTime2(ShiftTimeModel date) {
    setState(() {
      gotTheTime2 = date.minute.toString();
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
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              "Shift date",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          DateRowComponent(
            onPressed: printDate,
          ),
          Text(
            "Work time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printTime,
                  whichValueToSelect: "Start",
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printTime2,
                  whichValueToSelect: "End",
                ),
              ),
            ],
          ),
          Text(
            "Break time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.free_breakfast,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printTime,
                  whichValueToSelect: "Start",
                ),
              ),
              Flexible(
                child: TimePickerComponent(
                  onPressed: printTime2,
                  whichValueToSelect: "End",
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  hint: Text("Select shift"),
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
          Text("$gotTheTime"),
          Text("$gotTheTime2"),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(16),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("TEXT"),
                      ),
                    ))
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
