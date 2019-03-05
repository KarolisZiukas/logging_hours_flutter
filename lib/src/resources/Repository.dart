import 'package:logging_hours/src/addNewShift/WorkPlaceModel.dart';
import 'package:logging_hours/src/resources/ShiftsDatabase.dart';
import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/resources/WorkPlaceDatabase.dart';

class Repository {
  static final Repository repo = new Repository.internal();

  ShiftsDatabase shiftsDatabase;
  WorkPlaceDatabase workPlaceDatabase;

  static Repository getRepository() {
    return repo;
  }

  Repository.internal() {
    shiftsDatabase = ShiftsDatabase.getShiftsDatabase();
    workPlaceDatabase = WorkPlaceDatabase.getWorkPlaceDatabase();
  }

  Future init() async {
    await workPlaceDatabase.initDatabase();
    await shiftsDatabase.initDatabase();
    return;
  }

  Future<List<ShiftModel>> getAllShiftModels() {
    return shiftsDatabase.getShiftModel();
  }

  Future<ShiftModel> insertNewShift(ShiftModel model) {
    return shiftsDatabase.insertShift(model);
  }

  Future<WorkPlaceModel> insertNewWorkPlace(WorkPlaceModel model) {
    return workPlaceDatabase.insertNewWorkPlace(model);
  }

  Future close() async {
    return shiftsDatabase.close();
  }
}
