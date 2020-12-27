import 'package:charts_flutter/flutter.dart' as charts;
import 'package:diabetes_tracker/model/record.dart';
import 'package:diabetes_tracker/model/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    List<Record> _record = context.watch<RecordProvider>().recList;
    if (_record != null) {
      _record.sort((a, b) => a.date > b.date
          ? 1
          : a.date == b.date
              ? 0
              : -1);
    }
    return _record == null || _record.length == 0
        ? Center(
            child: Text("No record found."),
          )
        : new charts.TimeSeriesChart(_createSampleData(_record),
            animate: false);
  }

  static List<charts.Series<Record, DateTime>> _createSampleData(
      List<Record> _records) {
    return [
      new charts.Series<Record, DateTime>(
        id: 'fasting',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Record record, _) =>
            DateTime.fromMillisecondsSinceEpoch(record.date),
        measureFn: (Record record, _) => record.fasting,
        data: _records,
      ),
      new charts.Series<Record, DateTime>(
        id: 'pp',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Record record, _) =>
            DateTime.fromMillisecondsSinceEpoch(record.date),
        measureFn: (Record record, _) => record.pp,
        data: _records,
      )
    ];
  }
}
