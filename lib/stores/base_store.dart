// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../routes/routes.dart';
import '../utils/db.dart';

// Include generated file
part 'base_store.g.dart';

// This is the class used by rest of your codebase
class BaseStore = _BaseStore with _$BaseStore;

// The store-class
abstract class _BaseStore with Store {
  /// make one database instance for entire application
  DB? _db;

  /// Should instantiate the database on application start
  DB get db => _db!;

  // set the database
  set db(DB db) => _db = db;

  @observable
  int _currentHomeWidget = 0;
}
