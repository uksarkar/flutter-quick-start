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
  final DB _db;

  _BaseStore(DB db) : _db = db;

  DB get db => _db;
}
