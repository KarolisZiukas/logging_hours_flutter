import 'package:logging_hours/src/ui/TimePickerComponent.dart';

class WageCalculatorHelper {
  
  static String getFormattedTimeSpent(
      ShiftTimeModel startTime, ShiftTimeModel endTime) {

    var timeSpent = calculateSpentTime(startTime, endTime);
    return formatTimeSpent(
        convertMinutesToHours(timeSpent),
        getRemainingMinutes(timeSpent)
    );
  }

  static int calculateSpentTime(ShiftTimeModel startTime, ShiftTimeModel endTime) {
    var startTimeInMinutes = convertHoursToMinutes(startTime.hour) + startTime.minute;
    var endTimeInMinutes = convertHoursToMinutes(endTime.hour) + endTime.minute;
    return endTimeInMinutes - startTimeInMinutes;
  }
  
  static double calculateWage(int shiftTime, double hourlyRate, {int breakTime = 0}) {
    return (shiftTime - breakTime) * hourlyRate;
  }

  static String getCalculatedWage(
      ShiftTimeModel shiftStartTime,
      ShiftTimeModel shiftEndTime,
      double hourlyRate,
      bool didHadBreak,
      {
        ShiftTimeModel breakStartTime,
        ShiftTimeModel breakEndTime
      }) {

    var timeWorked = calculateSpentTime(shiftStartTime, shiftEndTime);
    var timeOnABreak = 0;

    if (didHadBreak) {
      timeOnABreak = calculateSpentTime(breakStartTime, breakEndTime);
    }
    return ((timeWorked - timeOnABreak) * (hourlyRate / 60)).toStringAsFixed(2);
  }

  static int convertHoursToMinutes(int hours) {
    return hours * 60;
  }

  static int convertMinutesToHours(int minutes) {
    return minutes ~/ 60;
  }

  static int getRemainingMinutes(int minutes) {
    return minutes % 60;
  }

  static String formatTimeSpent(int hoursSpent, int minutesSpent) {
    String formattedHours;
    String formattedMinutes;
    if (hoursSpent < 10) {
      formattedHours = "0$hoursSpent";
    } else {
      formattedHours = "$hoursSpent";
    }

    if (minutesSpent < 10) {
      formattedMinutes = "0$minutesSpent";
    } else {
      formattedMinutes = "$minutesSpent";
    }

    return "$formattedHours" + "h " + "$formattedMinutes" + "min";
  }
}
