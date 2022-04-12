import 'package:flutter/material.dart';

class ConditionalWidget<T> extends StatelessWidget {
  const ConditionalWidget({
    Key? key,
    required this.on,
    required this.exist,
    this.fallback,
  }) : super(key: key);

  final T? on;
  final Widget Function(T exact) exist;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return on != null ? exist(on!) : (fallback ?? Container());
  }
}
