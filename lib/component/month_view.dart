import 'package:calendar/component/day_view.dart';
import 'package:calendar/model/holiday_plan.dart';
import 'package:calendar/model/schedule_model.dart';
import 'package:calendar/utils/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:calendar/utils/time_utils.dart';
import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {

  final int year;
  final int month;
  final List<HolidayPlan> planList;
  final List<Schedule> scheduleList;

  MonthView({
    Key key,
    @required this.year,
    @required this.month,
    this.planList,
    this.scheduleList,}):
  super(key:key);

  @override
  _MonthViewState createState() => new _MonthViewState();

}

class _MonthViewState extends State<MonthView> {

  double rowWidth = 55;
  double rowHeight = 55;
  Map<int, TableColumnWidth> columnWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> planMap = new Map();
    Map<int, String> scheduleMap = new Map();
    if (widget.planList != null && widget.planList.length > 0) {
      widget.planList.forEach((HolidayPlan plan){
        if (DateTime.fromMillisecondsSinceEpoch((plan.time*1000)).year == widget.year && DateTime.fromMillisecondsSinceEpoch((plan.time*1000)).month == widget.month) {
          planMap[DateTime.fromMillisecondsSinceEpoch(plan.time*1000).day] = plan.type;
        }
      });
    }
    if (widget.scheduleList != null && widget.scheduleList.length > 0) {
      widget.scheduleList.forEach((Schedule schedule) {
        if (DateTime.fromMillisecondsSinceEpoch(schedule.time).year == widget.year && DateTime.fromMillisecondsSinceEpoch(schedule.time).month == widget.month) {
          scheduleMap[DateTime.fromMillisecondsSinceEpoch(schedule.time).day] = schedule.title;
        }
      });
    }
    print(scheduleMap);
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      childAspectRatio: 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 2,
      children: _buildDayView(planMap, scheduleMap),
    );
  }

  List<TableRow> _buildTableRows(int rowNum) {
    List<TableRow> tableRows = new List();
    for (var i = 0; i < rowNum ; i++ ) {
      tableRows.add(new TableRow(
        children: _buildWeekView(i, rowNum),
      ));
    }
    return tableRows;
  }

  List<DayView> _buildDayView(Map<int, int> planDayList, Map<int, String> scheduleMap) {
    List<DayView> dayViews = new List();
    DateTime beginDay = TimeUtils.getBeginDateOfMonth(widget.year, widget.month);
    int weekNum = TimeUtils.getWeekNum(widget.year, widget.month);
    for (var i = 0; i < weekNum; i++ ) {
      for (var j = DateTime.monday; j <= DateTime.daysPerWeek; j++) {
        if ((i == 0 && j < beginDay.weekday) || (i == weekNum - 1 && j > TimeUtils.getEndDateOfMonth(widget.year, widget.month).weekday)) {
          dayViews.add(DayView());
        } else {
          DateTime day = new DateTime(widget.year, widget.month, (i-1)*7 + (7 - beginDay.weekday + 1) + j);
          bool isCurrentDay = (widget.year == DateTime.now().year && widget.month == DateTime.now().month && day.day == DateTime.now().day);
          int holidayType;
          bool hasEvent = false;
          if (planDayList != null && planDayList.length >0 && planDayList.keys.contains(day.day)) {
            holidayType = planDayList[day.day];
          }
          if (scheduleMap != null && scheduleMap.length > 0 && scheduleMap.containsKey(day.day)) {
            hasEvent = true;
          }
          dayViews.add(DayView(day: day, isCurrentDay: isCurrentDay, hasEvent: hasEvent, holidayType: holidayType,));
        }
      }
    }
    return dayViews;
  }

  List<Widget> _buildWeekView(int i, int rowNum) {
    List<Widget> weekWidget = new List<Widget>();
    DateTime beginDay = TimeUtils.getBeginDateOfMonth(widget.year, widget.month);
    for (var j = DateTime.monday; j <= DateTime.daysPerWeek; j++) {
      if (i == 0 && j < beginDay.weekday) {
        weekWidget.add(SizedBox(
          width: rowWidth,
          height: rowHeight,
          child: DayView(),
        ));
      } else if (i == rowNum - 1 && j > TimeUtils.getEndDateOfMonth(widget.year, widget.month).weekday){
        weekWidget.add(SizedBox(
          width: rowWidth,
          height: rowHeight,
          child: DayView(),
        ));
      } else {
        DateTime day = new DateTime(widget.year, widget.month, (i-1)*7 + (7 - beginDay.weekday + 1) + j);
        bool isCurrentDay = (widget.year == DateTime.now().year && widget.month == DateTime.now().month && day.day == DateTime.now().day);
        weekWidget.add(SizedBox(
          width: rowWidth,
          height: rowHeight,
          child: DayView(day: day, isCurrentDay: isCurrentDay),
        ));
      }
    }
    return weekWidget;
  }
}