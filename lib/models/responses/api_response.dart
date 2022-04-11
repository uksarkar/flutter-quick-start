import 'dart:convert';

import '../../utils/log.dart';
import '../../utils/constants.dart';

class ApiResponse<T> {
  final bool isValid;
  final String message;
  final int statusCode;
  final dynamic rawData;
  final bool isServerError;
  T? data;

  bool get isNotValid => !isValid;

  ApiResponse({
    required this.isValid,
    required this.message,
    required this.statusCode,
    this.isServerError = false,
    this.data,
    this.rawData,
  });

  ApiResponse.unknown({String? message})
      : message = message ?? Constants.exceptionUnknown,
        data = null,
        rawData = null,
        statusCode = 0,
        isServerError = false,
        isValid = false;

  ApiResponse.noInternat()
      : data = null,
        rawData = null,
        message = Constants.exceptionNoInternet,
        isValid = false,
        isServerError = false,
        statusCode = 0;

  ApiResponse.timeout()
      : data = null,
        rawData = null,
        message = Constants.exceptionTimeOut,
        isValid = false,
        isServerError = false,
        statusCode = 0;

  ApiResponse.fromMap(Map<String, dynamic> data)
      : data =
            data.containsKey("data") && data["data"] is T ? data["data"] : null,
        rawData = data,
        isValid = data.containsKey("statusCode") &&
            [200, 201].contains(data["statusCode"]),
        statusCode = data.containsKey("statusCode") ? data["statusCode"] : 0,
        isServerError =
            data.containsKey("isServerError") ? data["isServerError"] : false,
        message = data.containsKey("message") ? data["message"] : "";

  ApiResponse.updatedModel(
    ApiResponse old, {
    T? model,
    bool? isServerError,
  })  : data = model,
        rawData = old.rawData,
        message = old.message,
        isValid = old.isValid,
        isServerError = isServerError ?? old.isServerError,
        statusCode = old.statusCode;

  static ApiResponse<T> serializeData<T>(String jsonString, int? statusCode) {
    final output = <String, dynamic>{};
    final parsedMap = _serverResponseToMap(jsonString);

    if (parsedMap != null) {
      if (parsedMap.containsKey("errors")) {
        output["message"] = List<String>.from(
                Map<String, dynamic>.from(parsedMap["errors"]).values.first)
            .first;
      } else if (parsedMap.containsKey("message")) {
        output["message"] = parsedMap["message"] ?? "";
      } else if (![200, 201].contains(statusCode)) {
        final firstElementsKey = parsedMap.keys.first;
        final firstElement = List.from(parsedMap[firstElementsKey]);
        output["message"] = firstElement.first.toString();
      }
      output["statusCode"] = statusCode;
      output["data"] =
          parsedMap.containsKey("data") ? parsedMap["data"] : parsedMap;
    } else {
      output["data"] = _serverResponseToList(jsonString);
    }

    return ApiResponse<T>.fromMap(output);
  }

  static ApiResponse<T> fromJsonString<T>(String data) {
    final parsed = jsonDecode(data);
    return ApiResponse<T>.fromMap(Map<String, dynamic>.from(parsed));
  }

  static Map<String, dynamic>? _serverResponseToMap(String jsonString) {
    try {
      return Map<String, dynamic>.from(jsonDecode(jsonString));
    } catch (e) {
      Log.info(e);
      return null;
    }
  }

  static List<dynamic>? _serverResponseToList(String jsonString) {
    try {
      return List.from(jsonDecode(jsonString));
    } catch (e) {
      Log.info(e);
      return null;
    }
  }
}
