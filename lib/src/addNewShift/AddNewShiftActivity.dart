import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/resources/Repository.dart';
import 'package:logging_hours/src/ui/DateRowComponent.dart';
import 'package:logging_hours/src/ui/TimePickerComponent.dart';

class AddNewShiftActivity extends StatefulWidget {
  @override
  AddNewShiftActivityState createState() => AddNewShiftActivityState();
}

class AddNewShiftActivityState extends State<AddNewShiftActivity> {
  var gotTheDate = "NO DATE";
  var gotTheTime = "NO TIME";
  var gotTheTime2 = "NO TIME";
  var isBreakRowVisible = false;

  Widget dropDownList = Row(
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
  );

  Widget saveShiftInformationButton = Flexible(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: () {
                  saveShift();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.save),
                    ),
                    Text("Save Shift"),
                  ]
                ),
              ),
            ))
          ],
        )
      ],
    ),
  );

  Row breakTimePickerRow() {
    return Row(
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
    );
  }

  Row shiftTimePickerRow() {
    return Row(
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
    );
  }

  void printDate(String date) {
    setState(() {
      gotTheDate = date;
    });
  }

  void setBreakRowVisibility(bool isVisible) {
    setState(() {
      isBreakRowVisible = isVisible;
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

  static void saveShift() {
    var model = ShiftModel(
        shiftId: "4",
        shiftDate: "3",
        shiftStartTime: "1",
        shiftEndTime: "baigiasi",
        breakStartTime: "1",
        breakEndTime: "1",
        hoursWorked: "1",
        breakDuration: "1",
        shiftName: "1",
        shiftWage: "1",
        hadBreak: "1");

    Repository.getRepository().insertNewShift(model);
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
          shiftTimePickerRow(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Text(
                    "Had a break?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                Switch(
                  value: isBreakRowVisible,
                  onChanged: (bool value) {
                    setBreakRowVisibility(value);
                  },
                )
              ],
            ),
          ),
          Visibility(
            visible: isBreakRowVisible,
            child: Column(
              children: <Widget>[
                Text(
                  "Break time",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                breakTimePickerRow(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: dropDownList,
          ),
          saveShiftInformationButton,
        ],
      ),
    );
  }
}
