// ignore_for_file: depend_on_referenced_packages, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:pupventa/page/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class SQLdb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialisation();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialisation() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "productos.db");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }

  _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY AUTOINCREMENT, codigo TEXT, codbarra TEXT, descripcion TEXT,medida TEXT, categoria TEXT,precio TEXT, stock REAL, image BLOB)');
    debugPrint("==================base de datos creada =======================");
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;
  }

  Future<List<Map>> getData(String sql) async {
    Database? mydb = await db;
    List<Map> rep = await mydb!.rawQuery(sql);
    return rep;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
