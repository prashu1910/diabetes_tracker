import 'dart:async';
import 'dart:io';

import 'package:diabetes_tracker/model/record.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final String dbName = "when.db";

  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  AppDatabase._();

  Completer<Database> _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final database = await initDB();
    _dbOpenCompleter.complete(database);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "diabetes_tracker.db");
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE records ("
          "id INTEGER PRIMARY KEY,"
          "fasting INTEGER,"
          "pp INTEGER,"
          "date INTEGER"
          ")");
    });
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from records");
  }

  deleteRecord(int id) async {
    final db = await database;
    return db.delete("records", where: "id = ?", whereArgs: [id]);
  }

  getRecord(int id) async {
    final db = await database;
    var res = await db.query("records", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Record.fromMap(res.first) : null;
  }

  Future<List<Record>> getRecords() async {
    final db = await database;
    var res = await db.query("records");
    List<Record> list =
        res.isNotEmpty ? res.map((c) => Record.fromMap(c)).toList() : [];
    return list;
  }

  updateRecord(Record record) async {
    final db = await database;
    var res = await db.update("records", record.toMap(),
        where: "id = ?", whereArgs: [record.id]);
    return res;
  }

  addRecord(Record record) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM records");
    int id = table.first["id"];
    //insert to the table using the new id
    var res = await db.insert("records", record.toMap());
    return res;
  }
}
