import 'package:calendar/routers/Application.dart';
import 'package:calendar/routers/routers.dart';
import 'package:calendar/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:calendar/component/month_container.dart';
import 'package:calendar/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:calendar/model/select_day_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageStat createState() => new _HomePageStat();
}

class _HomePageStat extends State<HomePage> {

  DateTime date = DateTime.now();
  
  /*void selectedDateChange(DateTime dateTime) {
    setState(() {
      date = dateTime;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Consumer<SelectDayModel>(
          builder: (context, selectDayModel, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_buildFirstTitleFromDate(selectDayModel?.getDateTime()), style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
                Text(_buildSecondTitleFromDate(selectDayModel?.getDateTime()), style: TextStyle(color: Colors.grey, fontSize: 14), textAlign: TextAlign.left,),
              ],
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.black87,),
            onPressed: (){
              Application.router.navigateTo(context, '${Routers.addSchedulePage}?selectDay=${date.millisecondsSinceEpoch}');
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top:10),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            MonthContainer(),
          ]
        )
      ),
    );
  }

  String _buildFirstTitleFromDate(DateTime date) {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(date.month);
    stringBuffer.write(S.of(context).month);
    stringBuffer.write(date.day);
    stringBuffer.write(S.of(context).day);
    return stringBuffer.toString();
  }

  String _buildSecondTitleFromDate(DateTime date) {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(date.year);
    stringBuffer.write("  ");
    stringBuffer.write(DateUtil.awayFromToday(date));
    return stringBuffer.toString();
  }

}