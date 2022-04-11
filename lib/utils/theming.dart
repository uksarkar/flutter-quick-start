import 'package:flutter/material.dart';

class Theming {
  final BuildContext context;
  final Size size;

  Theming(this.context) : size = MediaQuery.of(context).size;

  double widthInPercentage(double width) {
    return (size.width / 100) * width;
  }

  double heightInPercentage(double height) {
    return (size.height / 100) * height;
  }

  Color get primaryColor {
    return theme.primaryColor;
  }

  Color get secondaryColor {
    return theme.colorScheme.secondary;
  }

  Color get lightColor {
    return theme.scaffoldBackgroundColor;
  }

  ThemeData get theme {
    return Theme.of(context);
  }

  TextTheme get textTheme {
    return theme.textTheme;
  }
}
