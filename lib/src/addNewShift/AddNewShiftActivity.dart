import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging_hours/src/WageCalculatorHelper.dart';
import 'package:logging_hours/src/addNewShift/AddNewShiftBloc.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/addNewShift/ShiftTimeModelHelper.dart';
import 'package:logging_hours/src/ui/DateRowComponent.dart';
import 'package:logging_hours/src/ui/TimePickerComponent.dart';

class AddNewShiftActivity extends StatefulWidget {
  @override
  AddNewShiftActivityState createState() => AddNewShiftActivityState();
}

class AddNewShiftActivityState extends State<AddNewShiftActivity> {
  var isBreakRowVisible = false;
  String shiftDate;
  ShiftTimeModel shiftStartTime;
  ShiftTimeModel shiftEndTime;
  ShiftTimeModel breakStartTime;
  ShiftTimeModel breakEndTime;

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

  Widget saveShiftInformationButton() {
    return Flexible(
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
                    saveShift(
                        context,
                        shiftDate,
                        shiftStartTime,
                        shiftEndTime,
                        breakStartTime,
                        breakEndTime
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.save),
                        ),
                        Text("Save Shift"),
                      ]),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

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
            onPressed: setBreakStartTime,
            whichValueToSelect: "Start",
          ),
        ),
        Flexible(
          child: TimePickerComponent(
            onPressed: setBreakEndTime,
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
            onPressed: setShiftStartTime,
            whichValueToSelect: "Start",
          ),
        ),
        Flexible(
          child: TimePickerComponent(
            onPressed: setShiftEndTime,
            whichValueToSelect: "End",
          ),
        ),
      ],
    );
  }

  void printDate(String date) {
    setState(() {
      shiftDate = date;
    });
  }

  void setBreakRowVisibility(bool isVisible) {
    setState(() {
      isBreakRowVisible = isVisible;
    });
  }

  void setShiftStartTime(ShiftTimeModel time) {
    setState(() {
      shiftStartTime = time;
    });
  }

  void setShiftEndTime(ShiftTimeModel time) {
    setState(() {
      shiftEndTime = time;
    });
  }

  void setBreakStartTime(ShiftTimeModel time) {
    setState(() {
      breakStartTime = time;
    });
  }

  void setBreakEndTime(ShiftTimeModel time) {
    setState(() {
      breakEndTime = time;
    });
  }

  static void saveShift(
      BuildContext context,
      String shiftDate,
      ShiftTimeModel shiftStartTime,
      ShiftTimeModel shiftEndTime,
      ShiftTimeModel breakStartTime,
      ShiftTimeModel breakEndTime) {
    if(shiftDate != null) {
      var model = ShiftModel(
          shiftDate: shiftDate,
          shiftStartTime: ShiftTimeModelHelper.getFormattedDateString(shiftStartTime),
          shiftEndTime: ShiftTimeModelHelper.getFormattedDateString(shiftEndTime),
          breakStartTime: ShiftTimeModelHelper.getFormattedDateString(breakStartTime),
          breakEndTime: ShiftTimeModelHelper.getFormattedDateString(breakEndTime),
          hoursWorked: WageCalculatorHelper.getFormattedTimeSpent(shiftStartTime, shiftEndTime),
          breakDuration: WageCalculatorHelper.getFormattedTimeSpent(breakStartTime, breakEndTime),
          shiftName: "1",
          shiftWage: WageCalculatorHelper.getCalculatedWage(
              shiftStartTime,
              shiftEndTime,
              7,
              breakStartTime: breakStartTime,
              breakEndTime: breakEndTime
          ).toString(),
          hadBreak: "1");
      bloc.insertShift(model);
      Navigator.pop(context, true);
    } else {
      print("Empty date");
    }
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
          saveShiftInformationButton(),
        ],
      ),
    );
  }
}
