import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/stores/base_store.dart';
import 'package:provider/provider.dart';
import './routes/routes.dart';

void main() {
  // register application routes
  Routes.register();

  // run the application
  runApp(const _InitApp());
}

class _InitApp extends StatelessWidget {
  const _InitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BaseStore>(create: (_) => BaseStore()),
      ],
      child: MaterialApp(
        title: "Flutter quick start application",
        onGenerateRoute: (RouteSettings settings) => FluroRouter.appRouter
            .matchRoute(context, settings.name, routeSettings: settings)
            .route,
        initialRoute: "/",
      ),
    );
  }
}
