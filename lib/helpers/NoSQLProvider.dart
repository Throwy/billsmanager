import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';

class NoSQLProvider {
  NoSQLProvider._();

  static final NoSQLProvider db = NoSQLProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();

    try {
      await docsDir.create(recursive: true);
    } catch (_) {
      print(_);
    }
    String dbPath = join(docsDir.path, 'bills_manager.db');

    return await createDatabaseFactoryIo().openDatabase(dbPath);
  }
}
