import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String bio;
  final VoidCallback onMorePressed;

  const PostAppBar({
    super.key,
    required this.name,
    required this.bio,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close),
        color: AppColors.textPrimary,
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: AppColors.textPrimary,
          onPressed: onMorePressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
