import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final MediaQueryData media;

  /// breakpoints
  final double _mobile = 600, _tablet = 840;

  Responsive(this.context) : media = MediaQuery.of(context);

  double get width => media.size.width;

  bool get isMobile => width <= _mobile;
  bool get isTablet => width > _mobile && width <= _tablet;
  bool get isLarge => width > _tablet;

  DeviceType get deviceType => isMobile
      ? DeviceType.mobile
      : isTablet
          ? DeviceType.tablet
          : DeviceType.large;

  T devicePreferredValue<T>({
    required T mobile,
    T? tablet,
    T? large,
  }) {
    switch (deviceType) {
      case DeviceType.tablet:
        return tablet ?? large ?? mobile;
      case DeviceType.large:
        return large ?? tablet ?? mobile;
      default:
        return mobile;
    }
  }

  Widget devicePreferredWidget({
    required Widget mobile,
    Widget? tablet,
    Widget? large,
  }) {
    return devicePreferredValue(mobile: mobile, tablet: tablet, large: large);
  }

  T orientationBasedValue<T>(OrientationValue<T> payload) {
    return media.orientation == Orientation.portrait
        ? payload.portrait
        : payload.landscape;
  }

  Widget orientationBasedWidget({
    required Widget portrait,
    required Widget landscape,
  }) {
    return orientationBasedValue(
        OrientationValue(portrait: portrait, landscape: landscape));
  }

  T devicePreferredOrientationBasedValue<T>({
    required OrientationValue<T> mobile,
    OrientationValue<T>? tablet,
    OrientationValue<T>? large,
  }) {
    return devicePreferredValue(
      mobile: orientationBasedValue(mobile),
      tablet: tablet != null ? orientationBasedValue(tablet) : null,
      large: large != null ? orientationBasedValue(large) : null,
    );
  }
}

enum DeviceType { mobile, tablet, large }

class OrientationValue<T> {
  final T portrait, landscape;
  OrientationValue({
    required this.portrait,
    required this.landscape,
  });
}
