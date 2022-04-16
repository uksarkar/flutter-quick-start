import 'package:flutter/material.dart';

class PostSingleScreen extends StatelessWidget {
  const PostSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View post"),
      ),
      body: const Center(
        child: Text("Single post screen"),
      ),
    );
  }
}
