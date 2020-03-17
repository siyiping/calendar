
class TimeUtils {

  static int getDayOfMonth(int year, int month) {
    int days = 0;
    if (month != 2) {
      switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
          days = 31;
          break;
        case 4:
        case 6:
        case 9:
        case 11:
          days = 30;

      }
    } else {
      // 闰年
      if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
        days = 29;
      else
        days = 28;
    }
    return days;
  }

  static DateTime getBeginDateOfMonth(int year, int month) {
    return new DateTime(year, month, 1);
  }

  static DateTime getEndDateOfMonth(int year, int month) {
    return new DateTime(year, month, getDayOfMonth(year, month));
  }

  static int getWeekNum(int year, int month) {
    DateTime now = new DateTime.utc(year, month, 1);
    int weekNum = 5;
    if (now.weekday == DateTime.monday && 28 == TimeUtils.getDayOfMonth(year, month)) {
      weekNum = 4;
    } else if (now.weekday - 1 + TimeUtils.getDayOfMonth(year, month) > 35) {
      weekNum = 6;
    }
    print("table  row  num $weekNum");
    return weekNum;
  }
}