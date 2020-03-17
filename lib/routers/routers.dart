import 'package:calendar/component/add_schedule.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../view/home.dart';

class Routers {

  static String homePage = '/home';
  static String addSchedulePage = '/add_schedule';

  static void configRouters(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){});
    router.define(homePage, handler: new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return new HomePage();
    }));

    router.define(addSchedulePage, handler: new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){
      String selectDay = params["selectDay"]?.first;
      return new AddSchedule(selectDay);
    }));
  }

}