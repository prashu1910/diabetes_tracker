import 'package:diabetes_tracker/model/record.dart';
import 'package:diabetes_tracker/service/db.dart';
import 'package:flutter/foundation.dart';

class RecordProvider with ChangeNotifier {
  Record _record = new Record();
  List<Record> _recList = [];

  get record => _record;
  get recList => _recList;

  set recList(List<Record> newValue) {
    _recList = newValue;
    notifyListeners();
  }

  setFasting(String val) {
    _record.fasting = int.parse(val);
    // notifyListeners();
  }

  setPP(String val) {
    _record.pp = int.parse(val);
    //notifyListeners();
  }

  setDate(int val) {
    _record.date = val;
    //notifyListeners();
  }

  saveRecord() async {
    var res = await AppDatabase.instance.addRecord(_record);
    getRecords();
    notifyListeners();
  }

  deleteRecord(int id) async {
    var res = await AppDatabase.instance.deleteRecord(id);
    getRecords();
    notifyListeners();
  }

  Future<List<Record>> getRecords() async {
    recList = await AppDatabase.instance.getRecords();
  }

  RecordProvider() {
    getRecords();
  }
}
