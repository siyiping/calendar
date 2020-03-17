import 'package:calendar/model/date_model.dart';
import 'package:calendar/model/select_day_model.dart';
import 'package:calendar/utils/SpUtil.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'routers/Application.dart';
import 'routers/routers.dart';
import 'package:calendar/utils/analytics.dart' as Analytics;
import 'package:calendar/view/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'utils/provider.dart' as DateBaseProvider;
import 'package:calendar/model/holiday_plan.dart';

void main() async {
  final DateModel dateModel = DateModel()
    ..year=DateTime.now().year
    ..month=DateTime.now().month
    ..day=DateTime.now().day;

  await SpUtil.getInstance();
  final provider = new DateBaseProvider.Provider();
  await provider.init(true);
  HolidayPlanModel().getAllPlan().then((list){
    Application.getInstance().planList = list;
    runApp(
        ChangeNotifierProvider<SelectDayModel>.value(
            value: SelectDayModel(dateModel),
            child: MyApp()
        )
    );
  });
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
      home: new Scaffold(
        body: showHomePage(),
        floatingActionButton: Consumer<SelectDayModel>(
          builder: (context, SelectDayModel selectDayModel, _) => FloatingActionButton(
            onPressed: (){

            },
          ),
        ),
      ),
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
