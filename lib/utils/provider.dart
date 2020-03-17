import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

const createSql = {
  'event': """
      CREATE TABLE event (
      id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
      title	TEXT NOT NULL,
      remark	TEXT ,
      time	INTEGER NOT NULL,
      eventtype	INTEGER NOT NULL);
  """,
  'holiday': """
    CREATE TABLE holiday (id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, time INTEGER NOT NULL, type INTEGER);
  """,
};

const insertInitDate = {
  'holiday':"""
    insert into holiday values(null, strftime('%s','2019-09-13'), 1), 
                              (null, strftime('%s','2019-09-14'), 1), 
                              (null, strftime('%s','2019-09-15'), 1), 
                              (null, strftime('%s','2019-09-29'), 2), 
                              (null, strftime('%s','2019-10-01'), 1), 
                              (null, strftime('%s','2019-10-02'), 1), 
                              (null, strftime('%s','2019-10-03'), 1), 
                              (null, strftime('%s','2019-10-04'), 1), 
                              (null, strftime('%s','2019-10-05'), 1), 
                              (null, strftime('%s','2019-10-06'), 1), 
                              (null, strftime('%s','2019-10-07'), 1), 
                              (null, strftime('%s','2019-10-12'), 2);
  """,
};

class Provider {
  static Database db;

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item)  {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ["event", "holiday"];

    List<String> tables = await getTables();

    for(int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
   return true;

  }

  //初始化数据库
  Future init(bool isCreate) async {
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter.db');
    print(path);
    try {
      db = await openDatabase(path, version: 1);
    } catch (e) {
      print("Error $e");
    }
    bool tableIsRight = await this.checkTableIsRight();

    if (!tableIsRight) {
      createSql.forEach((String key, String value) {
        print("create table $key  value  $value");
        db.execute(value);
      });
      insertInitDate.forEach((String key, String value) {
        db.execute(value);
      });
    } else {
      print("Opening existing database");
    }
  }

}
