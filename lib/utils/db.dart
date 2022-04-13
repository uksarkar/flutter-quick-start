import 'dart:io';

import 'package:flutter_quick_start/utils/constants.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  // the database instance
  final Database instance;

  // database class constructor
  DB._init({required this.instance});

  /// the initializer of the database
  static Future<DB> init() async {
    // get the application documents directory
    final Directory dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    final String dbPath = join(dir.path, Constants.appCode);
    // open the database
    final Database db =
        await databaseFactoryIo.openDatabase(dbPath, version: 1);

    // return the database object
    return DB._init(instance: db);
  }

  // save record to database
  Future save(String record, dynamic data) async {
    StoreRef store = StoreRef.main();
    return store.record(record).put(instance, data);
  }

  // get saved record
  Future getRecord(String record) {
    StoreRef store = StoreRef.main();
    return store.record(record).get(instance);
  }

  // delete saved record
  Future delete(String record) {
    StoreRef store = StoreRef.main();
    return store.record(record).delete(instance);
  }
}
