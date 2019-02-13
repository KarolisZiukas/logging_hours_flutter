import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewShiftActivity extends StatefulWidget {
  @override
  AddNewShiftActivityState createState() => AddNewShiftActivityState();
}

Widget datePickerComponent = Text("Shift date");

class AddNewShiftActivityState extends State<AddNewShiftActivity> {
  final textEditingController = TextEditingController();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime currentDate = DateTime.now();
  String formatted = "Please select date";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    textEditingController.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        formatted = DateFormat('yMMMMd').format(picked);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                          color: Color(0xFFFFFFFF),
                          width: 2.0
                      )
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        'Select shift date',
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                    Text('$formatted',
                                      style: TextStyle(
                                          fontSize: 18
                                      ),),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              )
                            ],
                          )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
