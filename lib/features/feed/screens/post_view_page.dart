import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/feed/widgets/post_view/post_app_bar.dart';
import 'package:singly/features/feed/widgets/post_view/post_header.dart';
import 'package:singly/features/feed/widgets/post_view/post_image_list.dart';
import 'package:singly/features/feed/widgets/post_view/post_actions_bar.dart';

class PostViewPage extends StatefulWidget {
  final int initialIndex;
  const PostViewPage({super.key, this.initialIndex = 0});

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  late PageController _pageController;

  final List<Map<String, dynamic>> posts = [
    {
      'name': 'Maulik Savaliya',
      'bio': 'mauliksavaliya',
      'avatar': null,
      'follow': false,
      'text': 'First post on Singly!',
      'media': [
        'https://images.unsplash.com/photo-1522199710521-72d69614c702',
        'https://i.ibb.co/wFRHMJ3g/Whats-App-Image-2025-07-09-at-2-24-40-PM.jpg',
      ],
      'mood': 'Grateful',
      'timestamp': '2h ago',
      'likes': 120,
      'views': 450,
      'comments': [
        {
          'user': 'Alex',
          'comment': 'This is awesome!',
          'replies': [
            {'user': 'Max', 'comment': 'I agree!', 'likes': 1, 'liked': false},
            {
              'user': 'Lily',
              'comment': 'Well said.',
              'likes': 2,
              'liked': false,
            },
          ],
        },
        {'user': 'Jane', 'comment': 'Love this post', 'replies': []},
      ],
    },
    {
      'name': 'John Doe',
      'bio': 'johndoe',
      'avatar': null,
      'follow': true,
      'text': 'Going to London next week!',
      'media': ['https://images.unsplash.com/photo-1522199710521-72d69614c702'],
      'mood': 'Motivated',
      'timestamp': '5h ago',
      'likes': 80,
      'views': 310,
      'comments': [
        {
          'user': 'Alex',
          'comment': 'This is awesome!',
          'replies': [
            {'user': 'Max', 'comment': 'I agree!', 'likes': 1, 'liked': false},
            {
              'user': 'Lily',
              'comment': 'Well said.',
              'likes': 2,
              'liked': false,
            },
          ],
        },
        {'user': 'Jane', 'comment': 'Love this post', 'replies': []},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  void _showOptions(String bio) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.report_gmailerrorred_outlined),
              title: const Text('Report Post'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('View Profile'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PostAppBar(
            name: post['name'],
            bio: post['bio'],
            onMorePressed: () => _showOptions(post['bio']),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostHeader(post: post),
                        const SizedBox(height: 16),
                        if (post['media'] != null)
                          PostImageList(
                            imageUrls: List<String>.from(post['media']),
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1),
                PostActionsBar(post: post, index: index),
              ],
            ),
          ),
        );
      },
    );
  }
}
