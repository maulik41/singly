import 'package:flutter/material.dart';
import 'package:singly/features/feed/widgets/profile_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 10,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return const ProfileCard(
          name: 'Maulik Savaliya',
          bio: 'Businessmen',
          isFollowing: true,
          updatedTime: '2h ago',
          likesCount: 124,
          viewsCount: 892,
        );
      },
    );
  }
}
