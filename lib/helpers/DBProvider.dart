import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// `DBProvider` is a helper class to cleanly provide a database instance
/// to the app.
///
/// The `DBProvider` class handles initializing the database instance and any
/// migrating between versions of the database.
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

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
      String dbPath = join(docsDir.path, 'bills_manager.db');
      return await databaseFactoryIo.openDatabase(dbPath);
    } catch (e, _) {
      print(e);
      print("\n");
      print(_);
    }
  }
}
