class WorkPlaceModel {
  static final String dbWorkPlaceId = "workPlaceId";
  static final String dbWorkPlaceName = "shiftdate";
  static final String dbWorkPlaceWage = "shiftStartTime";

  int workPlaceId = 0;
  String workPlaceName = "";
  String workPlaceWage = "";

  WorkPlaceModel({
    this.workPlaceId,
    this.workPlaceName,
    this.workPlaceWage,
  });

  WorkPlaceModel.fromMap(Map<String, dynamic> map)
      : this(
          workPlaceId: map[dbWorkPlaceId],
          workPlaceName: map[dbWorkPlaceName],
          workPlaceWage: map[dbWorkPlaceWage],
        );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      dbWorkPlaceName: workPlaceName,
      dbWorkPlaceWage: workPlaceWage,
    };
    if (workPlaceId != null) {
      map[dbWorkPlaceId] = workPlaceId;
    }
    return map;
  }
}
