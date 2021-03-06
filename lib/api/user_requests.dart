import 'package:flutter/material.dart';
import '../models/user.dart';
import '../api/base_request.dart';
import '../models/responses/api_response.dart';

class UserRequests extends BaseRequest {
  /// base request constructor
  UserRequests({
    bool showMessage = true,
    BuildContext? context,
  }) : super(
          redirectIf401: false,
          showMessage: showMessage,
          context: context,
        );

  /// get all users
  Future<ApiResponse<List<User>>> getAllUsers() {
    return handle(
      url: "/users",
      modelList: (List<dynamic> payload) =>
          User.fromList(List<Map<String, dynamic>>.from(payload)),
    );
  }

  /// find user by id
  Future<ApiResponse<User?>> findUserById(int id) {
    return handle(url: "/users/$id", model: User.fromMap);
  }
}
