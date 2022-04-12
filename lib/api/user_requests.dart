import 'package:flutter/material.dart';
import 'package:flutter_quick_start/models/user.dart';
import '../api/base_request.dart';
import '../models/responses/api_response.dart';

class UserRequests extends BaseRequest {
  /// base request constructor
  UserRequests({
    bool redirectIf401 = false,
    bool showMessage = true,
    BuildContext? context,
  }) : super(
          redirectIf401: redirectIf401,
          showMessage: showMessage,
          context: context,
        );

  /// get all users
  Future<ApiResponse<List<User>>> getAllUsers() {
    return handle(url: "/users");
  }

  /// find user by id
  Future<ApiResponse<User?>> findUserById(int id) {
    return handle(url: "/users/$id");
  }
}
