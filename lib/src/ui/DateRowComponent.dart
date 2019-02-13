import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRowComponent extends StatefulWidget {
  final ValueChanged<String> onPressed;

  DateRowComponent({this.onPressed});

  @override
  State createState() {
    return DateRowComponentState();
  }
}

class DateRowComponentState extends State<DateRowComponent> {
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime currentDate = DateTime.now();
  String formatted = "Please select date";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        formatted = DateFormat('yMMMMd').format(picked);
        widget.onPressed(formatted);
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
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color: Color(0xFFFFFFFF), width: 2.0)),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
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
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '$formatted',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      )
                    ],
                  )),
            splashColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
