import 'dart:async';
import 'package:logging_hours/src/addNewShift/WorkPlaceModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WorkPlaceDatabase {
  static final WorkPlaceDatabase workPlacesDatabase = new WorkPlaceDatabase.internal();

  final String tableName = "WorkPlaces";

  Database database;

  static WorkPlaceDatabase getWorkPlaceDatabase() {
    return workPlacesDatabase;
  }

  WorkPlaceDatabase.internal();

  Future<Database> getDatabase() async {
    if (database == null) await initDatabase();
    return database;
  }

  initDatabase() async {
    var documentsDirectoryPath = await getDatabasesPath();
    print("Trying to create");
    String path = join(documentsDirectoryPath, "workplaces.db");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $tableName ("
              "${WorkPlaceModel.dbWorkPlaceId} INTEGER PRIMARY KEY AUTOINCREMENT,"
              "${WorkPlaceModel.dbWorkPlaceName} TEXT,"
              "${WorkPlaceModel.dbWorkPlaceWage} TEXT"
              ")");
        });
  }

  Future<WorkPlaceModel> insertNewWorkPlace(WorkPlaceModel model) async {
    var db = await getDatabase();
    var addedId = await db.insert(tableName, model.toMap());
    model.workPlaceId = addedId;
    return model;
  }

  Future close() async => database.close();
}
