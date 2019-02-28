import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';

class ShiftsListCreator extends StatefulWidget {

  List<ShiftModel> list;

  ShiftsListCreator({this.list});

  @override
  State createState() {
    return ShiftsListCreatorState();
  }
}

class ShiftsListCreatorState extends State<ShiftsListCreator> {

  static Widget makeListTile(ShiftModel item) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text("${item.shiftWage}", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
  }

  static Widget makeCard(ShiftModel item) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(widget.list[index]);
          },
        ),
      );
  }
}