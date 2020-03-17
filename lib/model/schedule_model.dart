import 'package:calendar/utils/sql.dart';

class Schedule {
  String id;
  String title;
  int type;
  String remark;
  int time;

  Schedule({this.title, this.type, this.remark, this.time});

  factory Schedule.fromJson(Map json) {
    return Schedule(title:json['title'], type: json['eventtype'], remark: json['remark'], time: json['time']);
  }
}

class ScheduleModel {
  final String table = 'event';
  Sql sql;

  ScheduleModel() {
    sql = Sql.setTable(table);
  }

  Future<List<Schedule>> getAllSchedule() async {
    List list = await sql.getByCondition();
    List<Schedule> resultList = [];
    list.forEach((item){
      print(item);
      resultList.add(Schedule.fromJson(item));
    });
    return resultList;
  }

  Future<Map<String, dynamic>> insertSchedule(Schedule schedule) async{
    return await sql.insert({'title':"11", 'remark':"22", 'time':1572796800000, 'eventtype':1, });
  }
}