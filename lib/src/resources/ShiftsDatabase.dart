import 'dart:async';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShiftsDatabase {
  static final ShiftsDatabase shiftsDatabase = new ShiftsDatabase.internal();

  final String tableName = "Shifts";

  Database database;

//  bool didInit = false;

  static ShiftsDatabase getShiftsDatabase() {
    return shiftsDatabase;
  }

  ShiftsDatabase.internal();

  Future<Database> getDatabase() async {
    if (database == null) await initDatabase();
    return database;
  }

  initDatabase() async {
    var documentsDirectoryPath = await getDatabasesPath();
    print("Trying to create");
    String path = join(documentsDirectoryPath, "shifts.db");
    database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "${ShiftModel.dbShiftId} STRING PRIMARY KEY,"
          "${ShiftModel.dbShiftDate} TEXT,"
          "${ShiftModel.dbShiftStartTime} TEXT,"
          "${ShiftModel.dbShiftEndTime} TEXT,"
          "${ShiftModel.dbBreakStartTime} TEXT,"
          "${ShiftModel.dbBreakEndTime} TEXT,"
          "${ShiftModel.dbHoursWorked} TEXT,"
          "${ShiftModel.dbBreakDuration} TEXT,"
          "${ShiftModel.dbShiftName} TEXT,"
          "${ShiftModel.dbShiftWage} TEXT,"
          "${ShiftModel.dbHadBreak} TEXT"
          ")");
    });
  }

  Future<ShiftModel> insertShift(ShiftModel model) async {
    var db = await getDatabase();
    var something = await db.insert(tableName, model.toMap());
    return model;
  }

  Future<ShiftModel> getShiftModel(String id) async {
    List<Map> maps = await database.query(tableName,
        columns: [
          ShiftModel.dbShiftId,
          ShiftModel.dbShiftDate,
          ShiftModel.dbShiftStartTime,
          ShiftModel.dbShiftEndTime,
          ShiftModel.dbBreakStartTime,
          ShiftModel.dbBreakEndTime,
          ShiftModel.dbHoursWorked,
          ShiftModel.dbBreakDuration,
          ShiftModel.dbShiftName,
          ShiftModel.dbShiftWage,
          ShiftModel.dbHadBreak
        ],
        where: '${ShiftModel.dbShiftId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print("NOT EMPTY");
      return ShiftModel.fromMap(maps.first);
    } else {
      print("EMPTY");
      return null;
    }
  }

  Future close() async => database.close();
}
