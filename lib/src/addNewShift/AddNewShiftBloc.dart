import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/addNewShift/WorkPlaceModel.dart';
import 'package:logging_hours/src/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class AddNewShiftBloc {
  final shiftsInserter = PublishSubject<ShiftModel>();
  final workPlaceInserter = PublishSubject<WorkPlaceModel>();
  final workPlaceFetcher = PublishSubject<List<WorkPlaceModel>>();


  Observable<ShiftModel> get addedItemId => shiftsInserter.stream;

  Observable<WorkPlaceModel> get addedWorkPlaceId => workPlaceInserter.stream;

  insertShift(ShiftModel shiftModel) async {
    var shiftId = await Repository.getRepository().insertNewShift(shiftModel);
    shiftsInserter.sink.add(shiftId);
  }

  insertNewWorkPlace(WorkPlaceModel model) async {
    var workPlaceId = await Repository.getRepository().insertNewWorkPlace(model);
    workPlaceInserter.sink.add(workPlaceId);
  }

  getWorkPlaces() async {
    var workPlaceList = await Repository.getRepository().getAllWorkPlaces();
    workPlaceFetcher.sink.add(workPlaceList);
  }

  dispose() {
    workPlaceInserter.close();
    shiftsInserter.close();
  }
}

final bloc = AddNewShiftBloc();
