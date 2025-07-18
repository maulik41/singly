import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/feed/models/comment_model.dart';
import 'package:singly/features/feed/widgets/comments/comment_input_field.dart';
import 'package:singly/features/feed/widgets/comments/comment_tile.dart';
import 'package:singly/features/feed/widgets/comments/reply_indicator.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  final List<Map<String, dynamic>> comments;

  const CommentPage({super.key, required this.postId, required this.comments});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<Comment> _comments; // Now using the Comment model
  String? _replyingTo;
  final Set<int> _expandedReplies = {};

  @override
  void initState() {
    super.initState();
    // Convert initial raw data to Comment objects
    _comments = widget.comments.map((map) => Comment.fromMap(map)).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addComment(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      if (_replyingTo != null) {
        final parentIndex = _comments.indexWhere((c) => c.user == _replyingTo);
        if (parentIndex != -1) {
          _comments[parentIndex].replies.add(
            Comment(
              user: 'You',
              username: 'you',
              comment: trimmed,
              timestamp: DateTime.now(),
            ),
          );
          _expandedReplies.add(parentIndex); // Auto-expand replies
        }
        _replyingTo = null;
      } else {
        _comments.add(
          Comment(
            user: 'You',
            username: 'you',
            comment: trimmed,
            timestamp: DateTime.now(),
          ),
        );
      }
      _controller.clear();
    });
  }

  void _startReply(String username) {
    setState(() {
      _replyingTo = username;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _cancelReply() {
    setState(() {
      _replyingTo = null;
      _controller.clear();
    });
  }

  void _likeComment(Comment comment) {
    setState(() {
      comment.liked = !comment.liked;
      comment.likes += comment.liked ? 1 : -1;
    });
  }

  void _likeReply(Comment reply) {
    setState(() {
      reply.liked = !reply.liked;
      reply.likes += reply.liked ? 1 : -1;
    });
  }

  void _toggleReplies(int index) {
    setState(() {
      _expandedReplies.contains(index)
          ? _expandedReplies.remove(index)
          : _expandedReplies.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          '${_comments.length} Comments',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _comments.isEmpty
                ? Center(
                    child: Text(
                      'No comments yet.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      return CommentTile(
                        comment: comment,
                        index: index,
                        showReplies: _expandedReplies.contains(index),
                        onLikeComment: _likeComment,
                        onLikeReply: _likeReply,
                        onStartReply: _startReply,
                        onToggleReplies: () => _toggleReplies(index),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          if (_replyingTo != null)
            ReplyIndicator(replyingTo: _replyingTo!, onCancel: _cancelReply),
          CommentInputField(
            controller: _controller,
            focusNode: _focusNode,
            onSubmitted: _addComment,
            onSendPressed: () => _addComment(_controller.text),
          ),
        ],
      ),
    );
  }
}
