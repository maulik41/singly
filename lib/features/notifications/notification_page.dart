import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/notifications/models/notification_model.dart';
import 'package:singly/features/notifications/widgets/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationModel.sampleData;

    return Scaffold(
      body: ListView.separated(
        itemCount: notifications.length,
        itemBuilder: (context, index) =>
            NotificationTile(notification: notifications[index]),
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: AppColors.divider),
      ),
    );
  }
}
