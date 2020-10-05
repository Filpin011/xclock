import 'package:clock4/date.dart';
import 'package:clock4/modelli/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'main.dart';

final String tableAlarm = 'Alarm';
final String colunmID = 'id';
final String colunmName = 'title';
final String colunmTime = 'alarmDateTime';
final String colunmPending = 'isPending';
final String colunmColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;
  AlarmHelper.createIstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper.createIstance();
    }
    return _alarmHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        create table $tableAlarm(
          $colunmID integer primary key autoincrement,
          $colunmName text not null,
          $colunmTime text not null,
          $colunmPending  integer,
          $colunmColorIndex integer)
      ''');
    });
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmID = AlarmInfo.fromMap(element);
      _alarms.add(alarmID);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    await flutterLocalNotificationsPlugin.cancel(id);
    return await db.delete(tableAlarm, where: '$colunmID=?', whereArgs: [id]);
  }
}
