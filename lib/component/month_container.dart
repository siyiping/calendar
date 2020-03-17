import 'dart:ffi';

import 'package:calendar/component/month_view.dart';
import 'package:calendar/model/date_model.dart';
import 'package:calendar/model/holiday_plan.dart';
import 'package:calendar/model/schedule_model.dart';
import 'package:calendar/model/select_day_model.dart';
import 'package:calendar/routers/Application.dart';
import 'package:calendar/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

int _getRealIndex(int position, int base, int length) {
  return position % length  < 0 ? position % length + length:position % length;
}

class MonthContainer extends StatefulWidget {

  final int initialPage;
  final double height;

  MonthContainer({
      Key key,
      this.initialPage:1,
      this.height,
      }):
        super(key: key);

  @override
  _MonthContainerState createState() {
    print("_MonthContainerState   createState");
    return new _MonthContainerState();
  }
}

typedef void PageUpdateCallBack(int index, DateTime currentMonth);

class _MonthContainerState extends State<MonthContainer> {

  int currentPage;
  List<MonthView> items;
  int lastIndex;
  PageController pageController;
  int kRealPage = 60000;
  DateTime day;
  List<Schedule> scheduleList;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
    lastIndex = widget.initialPage;
    _buildItems(DateTime.now(), Application.getInstance().planList, scheduleList);
    pageController = new PageController(initialPage: 30000 + 1);
    pageController.addListener((){

    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScheduleModel().getAllSchedule().then((list){
      print(list);
      setState(() {
        scheduleList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 25,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("一",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("二",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("三",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("四",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("五",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("六",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text("日",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: TimeUtils.getWeekNum(items[1].year, items[1].month) * 70.toDouble(),
          child:PageView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            itemCount: kRealPage,
            itemBuilder: (context, int i) {
              print("init  index  $i");
              return _buildItems(DateTime.now(), Application.getInstance().planList, scheduleList).elementAt(1);
            },
            onPageChanged: (int index){
              _pageChanged(index);
            },
            controller: pageController,
          ),
        ),


      ],
    );
  }

  List<MonthView> _buildItems(DateTime day, List<HolidayPlan> planList, List<Schedule> scheduleList) {
    DateTime currentMonth = day;
    DateTime previousMonth;
    DateTime nextMonth;
    if (DateTime.january == currentMonth.month) {
      previousMonth = new DateTime(currentMonth.year - 1, DateTime.december);
    } else {
      previousMonth = new DateTime(currentMonth.year, currentMonth.month - 1);
    }
    if (DateTime.december == currentMonth.month) {
      nextMonth = new DateTime(currentMonth.year + 1, DateTime.january);
    } else {
      nextMonth = new DateTime(currentMonth.year, currentMonth.month + 1);
    }
    items = [
      MonthView(year: previousMonth.year, month: previousMonth.month, planList: planList, scheduleList:scheduleList),
      MonthView(year: currentMonth.year, month: currentMonth.month, planList: planList, scheduleList:scheduleList),
      MonthView(year: nextMonth.year, month: nextMonth.month, planList: planList, scheduleList:scheduleList)
    ];
    return items;
  }

  _pageChanged(int index) {
    currentPage = _getRealIndex(index, kRealPage, items.length);
    print("Page  Change  $index   currentPage  $currentPage");
    int currentMonth = items[1].month;
    int currentYear = items[1].year;
    int newMonth = currentMonth;
    int newYear = currentYear;
    if(index - lastIndex == -1) {
      //向右划，月份减小
      if (currentMonth == DateTime.january) {
        newMonth = DateTime.december;
        newYear = currentYear - 1;
      } else {
        newMonth = currentMonth - 1;
      }
    } else if (index - lastIndex == 1) {
      //向左划，月份增加
      if (currentMonth == DateTime.december) {
        newMonth = DateTime.january;
        newYear = currentYear + 1;
      } else {
        newMonth = currentMonth + 1;
      }
    }
    lastIndex = index;
    print("newYear  $newYear  newMonth  $newMonth");
    DateTime newMonthTime = new DateTime(newYear, newMonth, 1);
    _buildItems(newMonthTime, Application.getInstance().planList, scheduleList);
    Provider.of<SelectDayModel>(context).selectDay(DateModel.fromDateTime(newMonthTime));
  }
}