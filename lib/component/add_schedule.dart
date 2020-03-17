import 'package:calendar/model/schedule_model.dart';
import 'package:calendar/routers/Application.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {

  final String selectDayMillisecond;
  
  AddSchedule(this.selectDayMillisecond);

  @override
  State createState() => _AddScheduleStat();
}

class _AddScheduleStat extends State<AddSchedule> {

  DateTime selectDay;
  bool inputEmpty = true;
  int type = 1;
  int time;
  TextEditingController eventController = TextEditingController(),
      remarkController = TextEditingController(),
      timeController = TextEditingController();

  _selectType(int type){
    setState(() {
      this.type = type;
    });
  }

  _saveBtnEvent() {
    if (inputEmpty){
      return null;
    } else {
      return () {
        String eventContent = eventController.value?.toString();
        String remarkContent = remarkController.value?.toString();

        ScheduleModel().insertSchedule(Schedule.fromJson({"title":eventContent, "type":type, "remark":remarkContent, "time":time}));
      };
    }
  }

  _judgeInput() {
    setState(() {
      if (eventController.text.trim().length == 0 && time == null) {
        inputEmpty = true;
      } else{
        inputEmpty = false;
      }
    });
  }

  String _eventHintText(int inputType){
    if (type == 1) {
      if(inputType == 1) {
        return "日程";
      } else if(inputType == 2) {
        return "备注";
      }
    } else if (type == 2) {
      if(inputType == 1) {
        return "寿星";
      } else if(inputType == 2) {
        return "出生日期";
      }
    } else if (type == 3) {
      if(inputType == 1) {
        return "纪念日";
      } else if(inputType == 2) {
        return "纪念日期";
      }
    } else if (type == 4) {
      if(inputType == 1) {
        return "倒数日";
      } else if(inputType == 2) {
        return "倒数日期";
      }
    }
    return "";
  }

  Widget _eventTitleIcon(){
    if (type == 1) {
      return Image.asset("assets/images/ic_edit_event_event.png");
    } else if (type == 2) {
      return Image.asset("assets/images/ic_birthday_title.png");
    } else if (type == 3) {
      return Image.asset("assets/images/ic_anniversary_title.png");
    } else if (type == 4) {
      return Image.asset("assets/images/ic_countdown_title.png");
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    selectDay = new DateTime.fromMillisecondsSinceEpoch(int.parse(widget.selectDayMillisecond));
    eventController.addListener((){
      _judgeInput();
    });
    remarkController.addListener((){
      _judgeInput();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 26,
            ),

            Row(
              children: <Widget>[
                FlatButton(
                  child: Text("取消", style: new TextStyle(fontSize: 16)),
                  textColor: Application.themeColor,
                  color: Colors.transparent,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),

                Expanded(
                  flex: 1,
                  child: Center(
                      child: Text("新建事件", style: new TextStyle(fontSize: 19, color: Colors.black),)
                  ),
                ),

                FlatButton(
                  child: Text("保存", style: new TextStyle(fontSize: 16)),
                  textColor: Application.themeColor,
                  color: Colors.transparent,
                  disabledTextColor: Colors.grey,
                  onPressed: _saveBtnEvent(),
                ),

              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(type == 1 ? "assets/images/edit_tab_calendar.png":"assets/images/edit_tab_calendar_none.png",),

                            Text("日程", style: TextStyle(fontSize: 14, color: type == 1 ? Color(0xFF198DED):Colors.grey),),
                          ],
                        ),
                        onTap: (){
                          _selectType(1);
                        },
                      )
                  ),

                  Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(type == 2 ? "assets/images/edit_tab_birthday.png":"assets/images/edit_tab_birthday_none.png"),

                            Text("生日", style: TextStyle(fontSize: 14, color: type == 2 ? Color(0xFFFFAF00):Colors.grey),),
                          ],
                        ),
                        onTap: () {
                          _selectType(2);
                        },
                      )
                  ),

                  Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(type == 3 ? "assets/images/edit_tab_anniversary.png":"assets/images/edit_tab_anniversary_none.png"),

                            Text("纪念日", style: TextStyle(fontSize: 14, color: type == 3 ? Color(0xFFE35050):Colors.grey),),
                          ],
                        ),
                        onTap: (){
                          _selectType(3);
                        },
                      )
                  ),

                  Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(type == 4 ? "assets/images/edit_tab_daysmatter.png":"assets/images/edit_tab_daysmatter_none.png"),

                            Text("倒数日", style: TextStyle(fontSize: 14, color: type == 4 ? Color(0xFF16B7AA):Colors.grey),),
                          ],
                        ),
                        onTap: (){
                          _selectType(4);
                        },
                      )
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: TextField(
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                cursorColor: Application.themeColor,
                controller: eventController,
                decoration: InputDecoration(
                  hintText: _eventHintText(1),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: _eventTitleIcon(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: TextField(
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                cursorColor: Application.themeColor,
                controller: remarkController,
                decoration: InputDecoration(
                  hintText: "备注",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Image.asset("assets/images/ic_edit_event_remark.png"),
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child:TextField(
                        maxLines: 1,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: _eventHintText(2),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          icon: Image.asset("assets/images/ic_edit_event_time.png"),
                        ),
                        onTap: (){
                          showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(new Duration(days: 60)),
                              lastDate: DateTime.now().add(new Duration(days: 60)))
                              .then((DateTime value){
                                time = value.millisecondsSinceEpoch;
                                timeController.text = value.year.toString() + "年" + value.month.toString() + "月" + value.day.toString() + "日";
                          }).catchError((){

                          });
                        },
                      ),
                    ),

                    Image.asset("assets/images/mc_expandable_preference_rotate_icon.png",)
                  ],
                )
            ),


          ],
        ),
    );
  }
  
}