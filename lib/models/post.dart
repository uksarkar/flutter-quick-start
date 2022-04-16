import 'package:flutter_quick_start/api/post_requests.dart';

import 'user.dart';

class Post {
  final int userId, id;
  final String title, body;
  User? _user;

  Post.fromMap(Map<String, dynamic> payload)
      : id = payload["id"],
        userId = payload["userId"],
        title = payload["title"],
        body = payload["body"];

  static List<Post> fromList(List<Map<String, dynamic>> payload) {
    return payload.map((post) => Post.fromMap(post)).toList();
  }

  /// get post user
  Future<User?> getUser() async {
    /// if we already have the user then return the user
    if (_user != null) return _user;

    /// since we don't load the user yet, then load it from server
    /// and set it to `_user` variable
    _user = await User.find(userId);

    /// now return the user
    return _user;
  }

  /// get single post by id from api
  static Future<Post?> find(int id) async {
    /// get data from server
    final _req = await PostRequests().findPostById(id);

    /// return the data only
    return _req.data;
  }
}
