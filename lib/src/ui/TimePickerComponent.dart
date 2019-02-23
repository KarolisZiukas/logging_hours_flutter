import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShiftTimeModel {
  final int hour;
  final int minute;

  ShiftTimeModel(this.hour, this.minute);
}

class TimePickerComponent extends StatefulWidget {
  final ValueChanged<ShiftTimeModel> onPressed;
  final String whichValueToSelect;

  TimePickerComponent({this.onPressed, this.whichValueToSelect});

  @override
  State createState() {
    return TimePickerComponentState();
  }
}

class TimePickerComponentState extends State<TimePickerComponent> {
  TimeOfDay currentTime = TimeOfDay.now();
  String formatted = "Select time";

  Future<Null> _selectDate(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: currentTime);
    if (picked != null)
      setState(() {
        if (picked.minute < 10) {
          formatted = "${picked.hour}:0${picked.minute}";
        } else {
          formatted = "${picked.hour}:${picked.minute}";
        }
        widget.onPressed(ShiftTimeModel(picked.hour, picked.minute));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () => _selectDate(context),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFFFFFFFF),
                    border: Border.all(color: Color(0xFFFFFFFF), width: 2.0)),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.whichValueToSelect} time',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$formatted',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                )),
            splashColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
