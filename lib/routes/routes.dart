import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import '../utils/str.dart';

abstract class Routes {
  /// argument free routes
  static const _Destination splashScreen = _Destination(
    screen: SplashScreen(),
    path: "/",
  );

  /// all argument free destinations
  /// registerable list
  static final List<_Destination> _cleanDestinations = [
    splashScreen,
  ];

  /// all argument based destinations
  /// registerable list
  static final List<_ArgumentDestination> _argumentDestinations = [];

  /// register all routes to the application
  static void register() {
    /// initiate fluro router
    FluroRouter router = FluroRouter.appRouter;

    // register clean screens
    for (var destination in _cleanDestinations) {
      router.define(
        destination.path,
        handler: Handler(handlerFunc: (_, __) => destination.screen),
      );
    }

    /// register argument based screens
    for (var destination in _argumentDestinations) {
      router.define(
        destination.path,
        handler: destination.handler,
      );
    }
  }

  // end of the routes class
}

class _Destination {
  final Widget screen;
  final String path;

  const _Destination({required this.screen, required this.path});

  navigate(BuildContext context) {
    Navigator.of(context).pushNamed(path);
  }

  navigatePermanently(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(path, (route) => false);
  }

  navigateByReplace(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(path);
  }
}

class _ArgumentDestination {
  final Handler handler;
  final String path;

  const _ArgumentDestination({required this.handler, required this.path});

  navigate(BuildContext context, Map<String, String> params,
      {Map<String, dynamic>? queries}) {
    Navigator.of(context).pushNamed(
        Str(path).setUrlParams(params).setUrlQueries(queries).urlEncoded);
  }

  navigatePermanently(BuildContext context, Map<String, String> params,
      {Map<String, dynamic>? queries}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Str(path).setUrlParams(params).setUrlQueries(queries).urlEncoded,
        (route) => false);
  }

  navigateByReplace(BuildContext context, Map<String, String> params,
      {Map<String, dynamic>? queries}) {
    Navigator.of(context).pushReplacementNamed(
        Str(path).setUrlParams(params).setUrlQueries(queries).urlEncoded);
  }
}
