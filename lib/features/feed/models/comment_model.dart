class Comment {
  final String user;
  final String username;
  final String comment;
  int likes;
  bool liked;
  final DateTime timestamp;
  List<Comment> replies; // Replies are also Comments

  Comment({
    required this.user,
    required this.username,
    required this.comment,
    this.likes = 0,
    this.liked = false,
    required this.timestamp,
    this.replies = const [],
  });

  // Factory constructor to create a Comment from a Map
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      user: map['user'] ?? '',
      username: map['username'] ?? map['user']?.toLowerCase() ?? '',
      comment: map['comment'] ?? '',
      likes: map['likes'] ?? 0,
      liked: map['liked'] ?? false,
      timestamp: map['timestamp'] is DateTime
          ? map['timestamp']
          : DateTime.tryParse(map['timestamp'].toString()) ?? DateTime.now(),
      replies:
          (map['replies'] as List<dynamic>?)
              ?.map((replyMap) => Comment.fromMap(replyMap))
              .toList() ??
          [],
    );
  }

  // Method to convert a Comment to a Map (useful for sending data)
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'username': username,
      'comment': comment,
      'likes': likes,
      'liked': liked,
      'timestamp': timestamp.toIso8601String(),
      'replies': replies.map((reply) => reply.toMap()).toList(),
    };
  }
}
