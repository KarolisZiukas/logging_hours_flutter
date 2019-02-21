
class ShiftModel {
  static final String dbShiftId = "shiftId";
  static final String dbShiftDate = "shiftdate";
  static final String dbShiftStartTime = "shiftStartTime";
  static final String dbShiftEndTime = "shiftEndTime";
  static final String dbBreakStartTime = "breakStartTime";
  static final String dbBreakEndTime = "breakEndTime";
  static final String dbHoursWorked = "hoursWorked";
  static final String dbBreakDuration = "breakDuration";
  static final String dbShiftName = "shiftName";
  static final String dbShiftWage = "shiftWage";
  static final String dbHadBreak = "hadBreak";


  String shiftId = "";
  String shiftDate = "";
  String shiftStartTime = "";
  String shiftEndTime = "";
  String breakStartTime = "";
  String breakEndTime = "";
  String hoursWorked = "";
  String breakDuration = "";
  String shiftName = "";
  String shiftWage = "";
  int hadBreak = 0;

  ShiftModel({this.shiftId,
    this.shiftDate,
    this.shiftStartTime,
    this.shiftEndTime,
    this.breakStartTime,
    this.breakEndTime,
    this.hoursWorked,
    this.breakDuration,
    this.shiftName,
    this.shiftWage,
    this.hadBreak
  });


  ShiftModel.fromMap(Map<String, dynamic> map) : this (
      shiftId: map[dbShiftId],
      shiftDate: map[dbShiftDate],
      shiftStartTime: map[dbShiftStartTime],
      shiftEndTime: map[dbShiftEndTime],
      breakStartTime: map[dbBreakStartTime],
      breakEndTime: map[dbBreakEndTime],
      hoursWorked: map[dbHoursWorked],
      breakDuration: map[dbBreakDuration],
      shiftName: map[dbShiftName],
      shiftWage: map[dbShiftWage],
      hadBreak: map[dbHadBreak]
  );

  Map<String, dynamic> toMap() {
    return {
      dbShiftId: shiftId,
      dbShiftDate: shiftDate,
      dbShiftStartTime: shiftStartTime,
      dbShiftEndTime: shiftEndTime,
      dbBreakStartTime: breakStartTime,
      dbBreakEndTime: breakEndTime,
      dbHoursWorked: hoursWorked,
      dbBreakDuration: breakDuration,
      dbShiftName: shiftName,
      dbShiftWage: shiftWage,
      dbHadBreak: hadBreak.toString()
    };
  }
}
