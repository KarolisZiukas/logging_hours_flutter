import 'package:logging_hours/src/WageCalculatorHelper.dart';
import 'package:logging_hours/src/ui/TimePickerComponent.dart';

class AddNewShiftValidator {

  static ShiftValidationClass isInputValid(
      String shiftDate,
      ShiftTimeModel shiftStartTime,
      ShiftTimeModel shiftEndTime,
      bool didHadBreak,
      ShiftTimeModel breakStartTime,
      ShiftTimeModel breakEndTime,
      String workPlaceName) {
    if (!isSelectionNotNull(shiftDate)) {
      return ShiftValidationClass(ShiftValidationStatus.Error, "Please select date");
    }
    if (!isTimeSelected(shiftStartTime)) {
      return ShiftValidationClass(ShiftValidationStatus.Error, "Please shift select start time");
    }
    if (!isTimeSelected(shiftEndTime)) {
      return ShiftValidationClass(ShiftValidationStatus.Error, "Please select shift end time");
    }
    if(didHadBreak) {
      if(!isTimeSelected(breakStartTime)) {
        return ShiftValidationClass(ShiftValidationStatus.Error, "Please break start time");
      }
      if(!isTimeSelected(breakEndTime)) {
        return ShiftValidationClass(ShiftValidationStatus.Error, "Please select break end time");
      }
      if (!isSelectedTimeCorrect(breakStartTime, breakEndTime)) {
        return ShiftValidationClass(ShiftValidationStatus.Error, "Please check if you correctly entered your break hours");
      }
      if (!isShiftLongerThanBreak(
        shiftStartTime,
        shiftEndTime,
        breakStartTime,
        breakEndTime
      )) {
        return ShiftValidationClass(ShiftValidationStatus.Error, "Please make sure that shift and and break times are correct");
      }
    }
    if(!isSelectionNotNull(workPlaceName)) {
      return ShiftValidationClass(ShiftValidationStatus.Error, "Please select work place");
    }
    if(!isSelectedTimeCorrect(shiftStartTime, shiftEndTime)) {
      return ShiftValidationClass(ShiftValidationStatus.Error, "Please check if you correctly entered your shift hours");
    }
    return ShiftValidationClass(ShiftValidationStatus.Success, "Validation succesful");
  }

  static bool isSelectionNotNull(String date) {
    return date != null ? true : false;
  }

  static bool isShiftLongerThanBreak(
      ShiftTimeModel shiftStart
      ShiftTimeModel shiftEnd
      ShiftTimeModel breakStart
      ShiftTimeModel breakEnd
      ) {
  if(WageCalculatorHelper.calculateSpentTime(shiftStart, shiftEnd)
            >= WageCalculatorHelper.calculateSpentTime(breakStart, breakEnd)) {
    return false;
  } else {
    return true;
  }
  }

  static bool isSelectedTimeCorrect(ShiftTimeModel start, ShiftTimeModel end) {
    if (addHourAndMinutes(start.hour, start.minute) > addHourAndMinutes(end.hour, end.minute)) {
      return false;
    } else {
      return true;
    }
  }

  static int addHourAndMinutes(int hours, int minutes) {
    return WageCalculatorHelper.convertHoursToMinutes(hours) + minutes;
  }

  static bool isTimeSelected(ShiftTimeModel model) {
    return model != null ? true : false;
  }
}

class ShiftValidationClass {
    final ShiftValidationStatus status;
    final String message;

    ShiftValidationClass(this.status, this.message);
}

enum ShiftValidationStatus {
  Success,
  Error
}


