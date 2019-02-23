import 'package:logging_hours/src/addNewShift/ShiftModel.dart';
import 'package:logging_hours/src/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ShiftsListBloc {
  final shiftsFetcher = PublishSubject<List<ShiftModel>>();

  Observable<List<ShiftModel>> get allShifts => shiftsFetcher.stream;

  getAllShifts() async {
    var shiftModel = await Repository.getRepository().getAllShiftModels();
    shiftsFetcher.sink.add(shiftModel);
  }

  dispose() {
    shiftsFetcher.close();
  }
}

final bloc = ShiftsListBloc();
