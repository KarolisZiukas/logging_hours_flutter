import 'package:logging_hours/src/ui/TimePickerComponent.dart';

class ShiftTimeModelHelper {

  static String getFormattedDateString(ShiftTimeModel model) {
    String formattedHour;
    String formattedMinute;

    if(model.hour < 10) {
      formattedHour = "0${model.hour}";
    } else {
      formattedHour = "${model.hour}";
    }

    if(model.minute < 10) {
      formattedMinute = "0${model.minute}";
    } else {
      formattedMinute = "${model.minute}";
    }

    return "$formattedHour:$formattedMinute";
  }
}