import 'date_model.dart';
import 'package:flutter/material.dart';

class SelectDayModel with ChangeNotifier {

  DateModel dateTime;
  DateModel get date => dateTime;

  DateTime getDateTime(){
    if (dateTime == null)
      return DateTime.now();
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  SelectDayModel(this.dateTime);

  void selectDay(DateModel dateTime) {
    this.dateTime = dateTime;
    notifyListeners();
  }

}