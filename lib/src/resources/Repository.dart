import 'package:logging_hours/src/resources/ShiftsDatabase.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';

class Repository {
  static final Repository repo = new Repository.internal();

  ShiftsDatabase database;

  static Repository getRepository() {
    return repo;
  }

  Repository.internal() {
    database = ShiftsDatabase.getShiftsDatabase();
  }

  Future init() async {
    return await database.initDatabase();
  }

  Future<List<ShiftModel>> getAllShiftModels() {
    return database.getShiftModel();
  }

  Future<ShiftModel> insertNewShift(ShiftModel model) {
    return database.insertShift(model);
  }

  Future close() async {
    return database.close();
  }
}
