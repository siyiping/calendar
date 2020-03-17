import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:calendar/model/holiday_plan.dart';

class Application {

  static Router router;
  static EventBus eventBus;
  static Application instance;
  List<HolidayPlan> planList;

  static Color themeColor = Color(0xFFEA5348);

  static Application getInstance () {
    if (instance == null) {
      instance = Application();
    }
    return instance;
  }
}