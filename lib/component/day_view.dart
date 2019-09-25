import 'package:flutter/material.dart';

class DayView extends StatefulWidget {

  final int day;
  final bool isSelected;
  final bool isCurrentDay;

  DayView(this.day, this.isSelected, this.isCurrentDay);

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}