import 'package:flutter_quick_start/api/user_requests.dart';

import 'address.dart';
import 'company.dart';

class User {
  final int id;
  final String name, username, email, phone, website;
  final Address address;
  final Company company;

  /// construct from map
  User.fromMap(Map<String, dynamic> payload)
      : id = payload["id"],
        name = payload["name"],
        username = payload["username"],
        email = payload["email"],
        phone = payload["phone"],
        website = payload["website"],
        address = Address.fromMap(payload["address"]),
        company = Company.fromMap(payload["company"]);

  /// construct user's list from list of map
  static List<User> fromList(List<Map<String, dynamic>> payload) {
    return payload.map((user) => User.fromMap(user)).toList();
  }

  /// make the initial map from constructed model
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "phone": phone,
      "website": website,
      "address": address.toMap(),
      "company": company.toMap(),
    };
  }

  /// get user by id from api
  static Future<User?> find(int id) async {
    /// get data from server
    final _req = await UserRequests().findUserById(id);

    /// return the data only
    return _req.data;
  }

  /// get all posts
  static Future<List<User>?> all() async {
    /// get data from the server
    final _req = await UserRequests().getAllUsers();

    /// return body only
    return _req.data;
  }
}
