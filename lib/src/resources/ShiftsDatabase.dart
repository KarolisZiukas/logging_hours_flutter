import 'dart:async';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShiftsDatabase {
  static final ShiftsDatabase shiftsDatabase = new ShiftsDatabase.internal();

  final String tableName = "Shifts";

  Database database;

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
    database = await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "${ShiftModel.dbShiftId} INTEGER PRIMARY KEY AUTOINCREMENT,"
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
    var addedId = await db.insert(tableName, model.toMap());
    model.shiftId = addedId;
    return model;
  }

  Future<List<ShiftModel>> getShiftModel() async {
    var db = await getDatabase();
    print("GET SHIFT MODEL $db");
    var maps = await db.query(tableName,
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
        ]);
    if (maps.isNotEmpty) {
      return maps.map((model) => ShiftModel.fromMap(model)).toList();
    } else {
      print("No shift found");
      return null;
    }
  }

  Future close() async => database.close();
}
