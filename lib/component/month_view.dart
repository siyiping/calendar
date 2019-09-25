import 'package:flutter/cupertino.dart';
import 'package:calendar/utils/TimeUtils.dart';

class MonthView extends StatefulWidget {

  final int year;
  final int month;

  MonthView({
    Key key,
    @required this.year,
    @required this.month}):
  super(key:key);

  @override
  _MonthViewState createState() => new _MonthViewState();
}

class _MonthViewState extends State<MonthView> {

  Map<int, TableColumnWidth> columnWidth;

  @override
  void initState() {
    super.initState();
    columnWidth = {
      0:FixedColumnWidth(MediaQuery.of(context).size.width/7),
      1:FixedColumnWidth(MediaQuery.of(context).size.width/7),
      2:FixedColumnWidth(MediaQuery.of(context).size.width/7),
      3:FixedColumnWidth(MediaQuery.of(context).size.width/7),
      4:FixedColumnWidth(MediaQuery.of(context).size.width/7),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: columnWidth,
      children: _buildTableRow(),
    );
  }

  List<TableRow> _buildTableRow() {
    List<TableRow> tableRows = new List();
    DateTime now = new DateTime.utc(widget.year, widget.month, 1);
    int rowNum = 5;
    if (now.weekday == DateTime.monday && 28 == TimeUtils.getDayOfMonth(widget.year, widget.month)) {
      rowNum = 4;
    }
    for (var i = 0; i < rowNum ; i++ ) {
      tableRows.add(new TableRow(
        
      ));
    }
    return tableRows;
  }
}