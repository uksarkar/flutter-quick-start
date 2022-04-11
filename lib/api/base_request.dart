import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:http/http.dart' as http;

import '../models/responses/api_response.dart';
import '../routes/routes.dart';
import '../utils/log.dart';
import '../utils/constants.dart';
import '../utils/str.dart';

abstract class BaseRequest {
  final bool redirectIf401;
  final bool showMessage;
  final BuildContext? context;

  BaseRequest({
    required this.redirectIf401,
    required this.showMessage,
    required this.context,
  });

  Future<ApiResponse<M>> handle<M>({
    HTTPRequestMethod method = HTTPRequestMethod.get,
    required String url,
    Map<String, dynamic>? payload,
    String? errorCode,
    M Function(Map<String, dynamic>)? model,
    M Function(List<dynamic>)? modelList,
    bool isMultipart = false,
  }) async {
    var req = isMultipart
        ? await _callApiAsMultipart<M>(
            url: url,
            data: payload ?? {},
            method: method,
            errorCode: errorCode,
            model: model,
          )
        : await _callApi<M>(
            url: url,
            payload: payload,
            method: method,
            errorCode: errorCode,
            model: model,
            modelList: modelList,
          );

    /// show message based on request response
    _showMessage(
      req.message,
      (showMessage && req.isNotValid || req.isServerError),
    );

    /// redirect if request response as unauthorized 401
    if (redirectIf401 && req.statusCode == 401) {
      _shouldRedirect();
    }

    /// return the response
    return req;
  }

  void _showMessage(
    String msg,
    bool showMessage,
  ) {
    if (context != null && showMessage) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text(
        msg,
        style: const TextStyle(color: Colors.amber),
      )));
    }
  }

  void _shouldRedirect() {
    if (context != null) {
      // Routes.signinScreen.navigatePermanently(context!);
    }
  }

  Future<ApiResponse<T>> _callApi<T>({
    HTTPRequestMethod method = HTTPRequestMethod.get,
    required String url,
    Map<String, dynamic>? payload,
    String? errorCode,
    T Function(Map<String, dynamic>)? model,
    T Function(List<dynamic>)? modelList,
  }) async {
    ApiResponse<T> res = ApiResponse<T>.unknown(message: errorCode);
    try {
      final headers = await _getHeaders();
      http.Response req;
      switch (method) {
        case HTTPRequestMethod.post:
          req = await http.post(_getApiUrl(url),
              body: jsonEncode(payload), headers: headers);
          break;
        case HTTPRequestMethod.put:
          req = await http.put(_getApiUrl(url),
              body: jsonEncode(payload), headers: headers);
          break;
        case HTTPRequestMethod.patch:
          req = await http.patch(_getApiUrl(url),
              body: jsonEncode(payload), headers: headers);
          break;
        case HTTPRequestMethod.delete:
          req = await http.delete(_getApiUrl(url), headers: headers);
          break;
        default:
          req = await http.get(
              Str(_getApiUrl(url).toString()).setUrlQueries(payload).asUri,
              headers: headers);
      }

      /// log the raw response body
      Log.info(req.body);

      // make the response as ApiResponse model
      final responseModel = ApiResponse.serializeData(req.body, req.statusCode);

      // if the response is not correct the not action needed
      if (responseModel.isNotValid || model == null && modelList == null) {
        res = ApiResponse<T>.updatedModel(responseModel);
      } else if (model != null) {
        final p = model(responseModel.data);
        res = ApiResponse<T>.updatedModel(responseModel, model: p);

        // if convertible to List then convert the list to array
      } else if (modelList != null) {
        final d = modelList(List.from(responseModel.data));
        res = ApiResponse<T>.updatedModel(responseModel, model: d);
      }
    } on TimeoutException {
      res = ApiResponse<T>.timeout();
    } on SocketException {
      res = ApiResponse<T>.noInternat();
    } catch (e, stacktrace) {
      Log.info(e);
      Log.info(stacktrace);
      res = ApiResponse<T>.unknown(message: errorCode);
    }
    return res;
  }

  Future<ApiResponse<R>> _callApiAsMultipart<R>({
    HTTPRequestMethod method = HTTPRequestMethod.post,
    required String url,
    required Map<String, dynamic> data,
    R Function(Map<String, dynamic>)? model,
    String? errorCode,
  }) async {
    ApiResponse<R> res;
    try {
      /// parse the uri for request to the server
      Uri uri = _getApiUrl(url);

      /// create multipart request instance
      http.MultipartRequest req =
          http.MultipartRequest(_requestMethodToString(method), uri);

      /// add all files to the request
      data.forEach((key, value) async {
        if (value is File) {
          final http.MultipartFile makeFile =
              await http.MultipartFile.fromPath(key, value.path);
          req.files.add(makeFile);
          data.remove(key);
        }
      });

      /// get all data into one variable
      final Map<String, String> fields = Map<String, String>.from(
          data.map((key, value) => MapEntry(key, value.toString())));

      /// add all fields to the request
      req.fields.addAll(fields);

      /// add access token
      req.headers.addAll(await _getHeaders());

      /// send response to server
      http.StreamedResponse streamResponse = await req.send();
      String response = await streamResponse.stream.bytesToString();

      Log.info(response);
      final responseModel =
          ApiResponse.serializeData(response, streamResponse.statusCode);
      if (!responseModel.isValid || model == null) {
        res = ApiResponse<R>.updatedModel(
          responseModel,
          isServerError: true,
        );
      } else {
        final d = model(Map<String, dynamic>.from(responseModel.data));
        res = ApiResponse<R>.updatedModel(
          responseModel,
          model: d,
        );
      }
    } on TimeoutException {
      res = ApiResponse<R>.timeout();
    } on SocketException {
      res = ApiResponse<R>.noInternat();
    } catch (e, t) {
      Log.info(e);
      Log.info(t);
      res = ApiResponse<R>.unknown(message: errorCode);
    }
    return res;
  }

  Future<Map<String, String>> _getHeaders() async {
    return {"Content-Type": "application/json", "Accept": "application/json"};
  }

  Uri _getApiUrl(String payload) {
    final Uri uri = Uri.parse(join(Constants.httpHost, payload));
    Log.info(uri);
    return uri;
  }

  /// make string version of the enum
  String _requestMethodToString(HTTPRequestMethod payload) =>
      payload.toString().split(".").last;
}

enum HTTPRequestMethod { get, put, patch, post, delete }
