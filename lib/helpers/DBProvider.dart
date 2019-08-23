import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// [DBProvider] is a helper class to cleanly provide a database instance
/// to the app.
///
/// The [DBProvider] class handles initializing the database instance and any
/// migrating between versions of the database.
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
      onUpgrade: (db, oldVersion, newVersion) =>
          _onUpgrade(db, oldVersion, newVersion),
      onOpen: (db) => _onOpen(db),
    );
  }

  /// Callback to configure the database.
  _onConfigure(Database db) async {
    // support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  /// Callback for processes that need to happen once the database is created.
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    // create the bills table
    batch.execute('''CREATE TABLE bills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_type TEXT,
        title TEXT,
        due_on INTEGER,
        amount_due TEXT,
        reminder INTEGER,
        reminder_period TEXT,
        repeats INTEGER,
        repeat_period TEXT,
        notes TEXT,
        paid INTEGER
        )''');

    // create the payments table
    batch.execute('''CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_id INTEGER NOT NULL,
        amount_paid TEXT,
        paid_on INTEGER,
        FOREIGN KEY(bill_id) REFERENCES bills(id) ON DELETE CASCADE
        )''');

    await batch.commit();
  }

  /// Callback to handle migrations of database schema.
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('upgrade');
  }

  /// Callback that's called after the database is opened.
  _onOpen(Database db) async {
    print("Database version: ${await db.getVersion()}");
  }
}
