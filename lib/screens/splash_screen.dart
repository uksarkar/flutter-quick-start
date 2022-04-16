import 'package:flutter/material.dart';
import 'package:flutter_quick_start/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// do check authentication incase you need
    /// and redirect user to the desired screen
    Future.delayed(const Duration(seconds: 2), () {
      Routes.homeScreen.navigatePermanently(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome!")),
    );
  }
}
