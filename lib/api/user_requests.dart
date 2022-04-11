import 'package:flutter/material.dart';
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
}
