import 'package:calendar/utils/SpUtil.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'routers/Application.dart';
import 'routers/routers.dart';
import 'package:calendar/utils/analytics.dart' as Analytics;

void main() async {
  await SpUtil.getInstance();
  runApp(new MyApp());
}

class MyApp extends  StatefulWidget{

  MyApp() {
    final router = new Router();
    Routers.configRouters(router);

    Application.router = router;
  }

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _MyAppState() {
    final eventBus = new EventBus();
    Application.eventBus = eventBus;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '日历',
      theme: new ThemeData.light(),
      home: new Scaffold(body: showWelcomePage()),
      onGenerateRoute: Application.router.generator,
      navigatorObservers: <NavigatorObserver>[Analytics.observer],
    );

  }

  showWelcomePage(){

  }

}
