import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String bio;
  final bool isFollowing;

  const UserTile({
    super.key,
    required this.name,
    this.bio = 'Photographer',
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withAlpha(30),
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Name & Bio
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bio,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Follow Button
          TextButton(
            onPressed: () {
              // Handle follow action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${isFollowing ? 'Unfollowed' : 'Followed'} $name',
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: isFollowing
                  ? AppColors.textMuted.withValues(alpha: 0.1)
                  : AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              style: theme.textTheme.labelLarge?.copyWith(
                color: isFollowing ? AppColors.textPrimary : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
