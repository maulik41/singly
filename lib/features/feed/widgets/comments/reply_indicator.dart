import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

class ReplyIndicator extends StatelessWidget {
  final String replyingTo;
  final VoidCallback onCancel;

  const ReplyIndicator({
    super.key,
    required this.replyingTo,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            'Replying to @$replyingTo',
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onCancel,
            child: const Icon(Icons.close, size: 16),
          ),
        ],
      ),
    );
  }
}
