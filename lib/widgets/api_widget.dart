import 'package:flutter/material.dart';
import '../models/responses/api_response.dart';

class ApiWidget<T> extends StatelessWidget {
  const ApiWidget({
    Key? key,
    required this.future,
    required this.child,
    this.error,
    this.loading,
  }) : super(key: key);

  final Future<ApiResponse<T>> future;
  final Widget Function(T object) child;
  final Widget? loading, error;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<T>>(
      builder: (context, snapshot) {
        /// check if data exist
        if (snapshot.hasData &&
            snapshot.data!.data != null &&
            snapshot.data!.data is T) {
          return child(snapshot.data!.data!);

          /// check if anything goes wrong
        } else if (snapshot.hasError || snapshot.data?.isNotValid == true) {
          return error ??
              Text(snapshot.data?.message ?? snapshot.error.toString());
        }

        /// otherwise it's in loading state
        return loading ?? const Text("Loading...");
      },
      future: future,
    );
  }
}
