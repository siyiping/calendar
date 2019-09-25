import 'package:calendar/utils/SpUtil.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'routers/Application.dart';
import 'routers/routers.dart';
import 'package:calendar/utils/analytics.dart' as Analytics;
import 'package:calendar/view/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';

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
  _MyAppState createState() => _MyAppState();
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

  showHomePage(){
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "calendar",
      theme: new ThemeData.light(),
      home: new Scaffold(body: showHomePage()),
      onGenerateRoute: Application.router.generator,
      navigatorObservers: <NavigatorObserver>[Analytics.observer],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );

  }

}
