import 'dart:async';

import 'package:calendar/utils/sql.dart';

class HolidayPlan {
  static const int TYPE_HOLIDAY = 1;
  static const int TYPE_WEEKDAY = 2;

  int time;
  int type;

  HolidayPlan({this.time, this.type});

  factory HolidayPlan.fromJson(Map json) {
    return HolidayPlan(time: json['time'],type: json['type']);
  }
}

class HolidayPlanModel{

  final String table = 'holiday';
  Sql sql;

  HolidayPlanModel() {
    sql = Sql.setTable(table);
  }

  Future<List<HolidayPlan>> getAllPlan() async {
    List list = await sql.getByCondition();
    List<HolidayPlan> resultList = [];
    list.forEach((item){
      print(item);
      resultList.add(HolidayPlan.fromJson(item));
    });
    return resultList;
  }

}