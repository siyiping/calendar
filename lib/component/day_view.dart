import 'package:calendar/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:calendar/model/date_model.dart';
import 'package:provider/provider.dart';
import 'package:calendar/model/select_day_model.dart';

class DayView extends StatefulWidget {

  final DateTime day;
  final bool isCurrentDay;
  final bool hasEvent;
  final int holidayType;

  DayView({Key key, this.day, this.isCurrentDay:false, this.hasEvent:false, this.holidayType}):super(key:key);

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {

  @override
  Widget build(BuildContext context) {
    DateModel date;
    if(widget.day != null) {
      date = DateModel.fromDateTime(widget.day);
    }
    return GestureDetector(
      onTap: (){
        Provider.of<SelectDayModel>(context).selectDay(date);
      },
      child: Consumer<SelectDayModel>(
        builder: (context, selectDayModel, _) {
          return SizedBox(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ((widget.day != null && widget.day.isAtSameMomentAs(selectDayModel.date.getDateTime())) ? widget.isCurrentDay ? Color(0xFFEA5348) : Colors.grey[350] : Colors.transparent)
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text((date != null && date.day != null) ? date.day.toString():"", textAlign: TextAlign.center, style: TextStyle(color: (widget.day != null && widget.day.isAtSameMomentAs(selectDayModel.date.getDateTime())) ? Colors.white:widget.isCurrentDay? Color(0xFFEA5348):Colors.black, fontSize: 16),),
                        Text((date != null && date.lunarString != null) ? date.lunarString:"", textAlign: TextAlign.center, style: TextStyle(color: (widget.day != null && widget.day.isAtSameMomentAs(selectDayModel.date.getDateTime())) ? Colors.white:widget.isCurrentDay? Color(0xFFEA5348):Colors.grey, fontSize: 10)),
                      ],
                    ),

                    Positioned(
                      bottom: 3,
                      child: Visibility(
                        visible: widget.hasEvent,
                        child: Container(
                          width: 4,
                          height: 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _getColor(widget.day)
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 6,
                      right: 4,
                      child: Visibility(
                        visible: widget.holidayType != null,
                        child: Text(widget.holidayType == 1 ? "休":"班",
                          style: TextStyle(color: widget.holidayType == 1 ? Colors.green:Color(0xFFEA5348), fontSize: 10),
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        }
      )
    );
  }

  Color _getColor(DateTime currentDay) {
    if(currentDay == null) {
      return null;
    }
    DateTime compareTime = DateTime(currentDay.year, currentDay.month, currentDay.day, 23, 59);
    if(DateUtil.isCurrentDay(currentDay.year, currentDay.month, currentDay.day)) {
      return Colors.white;
    } else if (compareTime.isBefore(DateTime.now())) {
      return Colors.grey;
    } else if (compareTime.isAfter(DateTime.now())) {
      return Color(0xFFEA5348);
    }
    return null;
  }
}