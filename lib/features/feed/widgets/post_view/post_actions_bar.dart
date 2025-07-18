import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/feed/screens/comment_page.dart';

class PostActionsBar extends StatelessWidget {
  final Map<String, dynamic> post;
  final int index;

  const PostActionsBar({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Views, Likes, Comments
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye_outlined,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post['views']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post['likes']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CommentPage(
                        postId: 'post-$index',
                        comments: List<Map<String, dynamic>>.from(
                          post['comments'] ?? [],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post['comments']?.length ?? 0}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Timestamp
          Text(
            post['timestamp'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
