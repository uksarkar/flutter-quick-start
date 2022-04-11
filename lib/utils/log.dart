import 'package:flutter/foundation.dart';

abstract class Log {
  static void info(dynamic msg) {
    if (kDebugMode) {
      print("=====================================");
      print(msg);
      print("=====================================");
    }
  }
}
