import 'package:flutter/material.dart';
import 'package:logging_hours/src/addNewShift/AddNewShiftActivity.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/shiftslist/ShiftsListCreator.dart';

import 'ShiftsListBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Shifts')),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text('Statistics')),
        ],
      ),
      body:
      StreamBuilder(
          stream: bloc.allShifts,
          builder: (context, AsyncSnapshot<List<ShiftModel>> snapshot) {
            if(snapshot.hasData) {
              print("have shifts ${snapshot.data.length}");
              return ShiftsListCreator(
                list: snapshot.data,
              );
            } else if (snapshot.hasError) {
              print("load shifts error ${snapshot.error.toString()}");
              return Text("Error");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewShiftActivity()));
        },
        tooltip: 'Add new shift',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.getAllShifts();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
