// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/models/post.dart';
import 'package:flutter_quick_start/models/user.dart';
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

  @observable
  bool loadingAllUsers = false;

  @observable
  ObservableList<User> _users = ObservableList<User>();

  @computed
  List<User> get users => _users;

  @observable
  bool loadingAllPosts = false;

  @observable
  ObservableList<Post> _posts = ObservableList<Post>();

  @computed
  List<Post> get posts => _posts;

  @action
  Future<void> loadAllPosts() async {
    /// set loading true
    loadingAllPosts = true;

    /// make the request
    final posts = await Post.all();

    /// set loading to false
    loadingAllPosts = false;

    /// check if not blank and
    /// set posts to the store
    if (posts != null) _posts.addAll(posts);
  }

  Future<void> loadAllUsers() async {
    /// set loading true
    loadingAllUsers = true;

    /// make the request
    final users = await User.all();

    /// set loading to false
    loadingAllUsers = false;

    /// check if not blank and
    /// set Users to the store
    if (users != null) _users.addAll(users);
  }
}
