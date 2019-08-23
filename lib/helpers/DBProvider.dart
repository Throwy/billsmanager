import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  /// Getter for the database.
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  /// Initalizes the database from local storage.
  _initDB() async {
    String databasesPath = await getDatabasesPath();

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {
      print(_);
    }

    String dbPath = join(databasesPath, 'bills_manager.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onConfigure: (db) => _onConfigure(db),
      onCreate: (db, version) => _onCreate(db, version),
    );
  }

  _onConfigure(Database db) async {
    // support for cascade delete
    await db.execute("PRAGMA foregin_keys = ON");
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Bills ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "bill_type TEXT,"
      "title TEXT,"
      "due_on INTEGER,"
      "amount_due TEXT,"
      "reminder INTEGER,"
      "reminder_period TEXT,"
      "repeats INTEGER,"
      "repeat_period TEXT,"
      "notes TEXT,"
      "paid INTEGER"
      ")");
  }
}
