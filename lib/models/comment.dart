class Comment {
  final int id, postId;
  final String name, email, body;

  Comment.fromMap(Map<String, dynamic> payload)
      : id = payload["id"],
        postId = payload["postId"],
        name = payload["name"],
        email = payload["email"],
        body = payload["body"];

  static List<Comment> fromList(List<Map<String, dynamic>> payload) {
    return payload.map((comment) => Comment.fromMap(comment)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "postId": postId,
      "name": name,
      "email": email,
      "body": body,
    };
  }
}
