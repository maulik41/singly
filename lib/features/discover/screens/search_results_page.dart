import 'package:flutter/material.dart';
import 'package:singly/core/routes/app_routes.dart';
import 'package:singly/core/theme/app_colors.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final List<Map<String, dynamic>> results = [
    {
      'username': 'maulik_s',
      'bio': 'Flutter Developer & Designer',
      'isFollowing': false,
    },
    {
      'username': 'mauliksavaliya',
      'bio': 'Coding memes & clean UI lover',
      'isFollowing': false,
    },
  ]; // Replace with real backend result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.search);
          },
        ),
        title: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.textMuted.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.query,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: results.isEmpty
          ? const Center(
              child: Text(
                'No users found',
                style: TextStyle(color: AppColors.textMuted),
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (_, i) {
                final user = results[i];
                final username = user['username'];
                final bio = user['bio'];
                final isFollowing = user['isFollowing'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.2,
                        ),
                        child: Text(
                          username[0].toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Username & Bio
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Go to $username profile'),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bio,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Follow Button
                      TextButton(
                        onPressed: () {
                          setState(() {
                            user['isFollowing'] = !isFollowing;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFollowing
                                    ? 'Unfollowed $username'
                                    : 'Followed $username',
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
                          style: TextStyle(
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
