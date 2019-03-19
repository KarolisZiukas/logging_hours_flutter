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
        title: Text(
          item.shiftName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Text("${item.shiftDate}", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
        Text(
          "${item.shiftWage}\$",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
          fontSize: 28),
        ));
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