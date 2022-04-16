import 'package:flutter/material.dart';
import '../models/post.dart';
import '../api/base_request.dart';
import '../models/responses/api_response.dart';

class PostRequests extends BaseRequest {
  /// base request constructor
  PostRequests({
    bool showMessage = true,
    BuildContext? context,
  }) : super(
          redirectIf401: false,
          showMessage: showMessage,
          context: context,
        );

  /// get all posts
  Future<ApiResponse<List<Post>>> getAllPosts() {
    return handle(
      url: "/posts",
      modelList: (List<dynamic> payload) =>
          Post.fromList(List<Map<String, dynamic>>.from(payload)),
    );
  }

  /// find Post by id
  Future<ApiResponse<Post?>> findPostById(int id) {
    return handle(url: "/posts/$id", model: Post.fromMap);
  }
}
