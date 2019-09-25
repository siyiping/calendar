import 'package:calendar/component/taste.dart';
import 'package:calendar/component/test_pageview.dart';
import 'package:flutter/material.dart';
import 'package:calendar/component/month_container.dart';
import 'package:calendar/generated/i18n.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageStat createState() => new _HomePageStat();
}

class _HomePageStat extends State<HomePage> {

  DateTime date = DateTime.now();
  
  void selectedDateChange(DateTime dateTime) {
    setState(() {
      date = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(_buildTitleFromDate(), style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){

          },),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top:10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MonthContainer(),
          ],
        ),
      ),
    );
  }

  String _buildTitleFromDate() {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(date.month);
    stringBuffer.write(S.of(context).month);
    stringBuffer.write(date.day);
    stringBuffer.write(S.of(context).day);
    return stringBuffer.toString();
  }

}