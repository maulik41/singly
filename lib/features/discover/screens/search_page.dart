import 'package:flutter/material.dart';
import 'package:singly/core/routes/app_routes.dart';
import 'package:singly/core/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _allUsers = [
    {'username': 'maulik_s', 'bio': 'Developer', 'isFollowing': false},
    {'username': 'mauliksavaliya', 'bio': 'Code wizard', 'isFollowing': false},
    {'username': 'john_doe', 'bio': 'Photographer', 'isFollowing': false},
    {'username': 'emma_w', 'bio': 'Engineer', 'isFollowing': false},
  ];

  void _onSubmit(String query) {
    if (query.trim().isNotEmpty) {
      Navigator.pushNamed(
        context,
        AppRoutes.searchResults,
        arguments: query.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text.trim().toLowerCase();

    final filteredUsers = query.isEmpty
        ? []
        : _allUsers.where((user) {
            return user['username'].toLowerCase().contains(query);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackButton(color: AppColors.textPrimary),
        title: TextField(
          controller: _controller,
          autofocus: false,
          onChanged: (_) => setState(() {}),
          onSubmitted: _onSubmit,
          decoration: const InputDecoration(
            hintText: 'Search users...',
            border: InputBorder.none,
          ),
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      backgroundColor: AppColors.white,
      body: query.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                final username = user['username'];
                final bio = user['bio'];
                final isFollowing = user['isFollowing'];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary.withAlpha(30),
                        child: Text(
                          username[0].toUpperCase(),
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
                              username,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bio,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textMuted),
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
                          // Dummy follow logic (in real app, use state management)
                          setState(() {
                            user['isFollowing'] = !isFollowing;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${isFollowing ? 'Unfollowed' : 'Followed'} $username',
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isFollowing
                              ? AppColors.textMuted.withValues(alpha: 0.1)
                              : AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isFollowing ? 'Following' : 'Follow',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: isFollowing
                                    ? AppColors.textPrimary
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
