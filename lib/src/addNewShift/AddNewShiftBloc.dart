import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class AddNewShiftBloc {

  final shiftsInserter = PublishSubject<ShiftModel>();

  Observable<ShiftModel> get addedItemId => shiftsInserter.stream;

  insertShift(ShiftModel shiftModel) async {
    var shiftId = await Repository.getRepository().insertNewShift(shiftModel);
    shiftsInserter.sink.add(shiftId);
  }

  dispose() {
    shiftsInserter.close();
  }
}

final bloc = AddNewShiftBloc();