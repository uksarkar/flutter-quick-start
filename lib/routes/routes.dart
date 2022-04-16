import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/post_create_screen.dart';
import '../screens/post_single_screen.dart';
import '../screens/posts_list_screen.dart';
import '../screens/user_create_screen.dart';
import '../screens/user_single_screen.dart';
import '../screens/users_list_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/str.dart';

abstract class Routes {
  /// argument free routes
  static const _Destination splashScreen = _Destination(
    screen: SplashScreen(),
    path: "/",
  );
  static const _Destination homeScreen = _Destination(
    screen: HomeScreen(),
    path: "/home",
  );
  static const _Destination postCreateScreen = _Destination(
    screen: PostCreateScreen(),
    path: "/posts/create",
  );
  static final _ArgumentDestination postSingleScreen = _ArgumentDestination(
    handler: Handler(
      handlerFunc: (context, parameters) {
        return PostSingleScreen();
      },
    ),
    path: "/posts/:id",
  );
  static const _Destination postListScreen = _Destination(
    screen: PostsListScreen(),
    path: "/posts",
  );
  static const _Destination userCreateScreen = _Destination(
    screen: UserCreateScreen(),
    path: "/users/create",
  );
  static final _ArgumentDestination userSingleScreen = _ArgumentDestination(
    handler: Handler(handlerFunc: (context, parameters) {
      return UserSingleScreen();
    }),
    path: "/users/:id",
  );
  static const _Destination usersListScreen = _Destination(
    screen: UserListScreen(),
    path: "/users",
  );

  /// all argument free destinations
  /// registerable list
  static final List<_Destination> _cleanDestinations = [
    splashScreen,
    homeScreen,
    postCreateScreen,
    postListScreen,
    userCreateScreen,
    usersListScreen,
  ];

  /// all argument based destinations
  /// registerable list
  static final List<_ArgumentDestination> _argumentDestinations = [
    postSingleScreen,
    userSingleScreen,
  ];

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
