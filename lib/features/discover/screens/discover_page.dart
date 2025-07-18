import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/discover/widgets/user_tile.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final randomUsers = [
      'maulik_s',
      'john_doe',
      'emma_w',
      'maulik_s',
      'john_doe',
      'emma_w',
      'maulik_s',
      'john_doe',
      'emma_w',
      'maulik_s',
      'john_doe',
      'emma_w',
      'maulik_s',
      'john_doe',
      'emma_w',
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: randomUsers.length,
        itemBuilder: (context, index) {
          final name = randomUsers[index];
          return UserTile(name: name);
        },
      ),
    );
  }
}
