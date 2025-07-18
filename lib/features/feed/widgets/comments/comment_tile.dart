import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:singly/features/feed/models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final int index;
  final bool showReplies;
  final ValueChanged<Comment> onLikeComment;
  final ValueChanged<Comment> onLikeReply;
  final ValueChanged<String> onStartReply;
  final VoidCallback onToggleReplies;

  const CommentTile({
    super.key,
    required this.comment,
    required this.index,
    required this.showReplies,
    required this.onLikeComment,
    required this.onLikeReply,
    required this.onStartReply,
    required this.onToggleReplies,
  });

  @override
  Widget build(BuildContext context) {
    final initial = comment.user.isNotEmpty
        ? comment.user[0].toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withAlpha(30),
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          comment.user,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => onLikeComment(comment),
                              child: Icon(
                                comment.liked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: comment.liked
                                    ? Colors.red
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${comment.likes}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      timeago.format(comment.timestamp),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      comment.comment,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => onStartReply(comment.user),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Reply',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        if (comment.replies.isNotEmpty)
                          GestureDetector(
                            onTap: onToggleReplies,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                              ), // more spacing
                              child: Text(
                                '${comment.replies.length} repl${comment.replies.length == 1 ? 'y' : 'ies'}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showReplies)
            ...comment.replies.map<Widget>((reply) {
              final replyInitial = reply.user.isNotEmpty
                  ? reply.user[0].toUpperCase()
                  : '?';
              return Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 32,
                ), // Reduced left padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primary.withAlpha(30),
                        child: Text(
                          replyInitial,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => {},
                            child: Text(
                              reply.user,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                          ),
                          Text(
                            timeago.format(reply.timestamp),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            reply.comment,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            reply.liked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: reply.liked ? Colors.red : AppColors.primary,
                          ),
                          onPressed: () => onLikeReply(reply),
                        ),
                        Text(
                          '${reply.likes}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
