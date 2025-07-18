import 'package:flutter/material.dart';
import 'package:singly/core/routes/app_routes.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/discover/screens/discover_page.dart';
import 'package:singly/features/feed/screens/feed_page.dart';
import 'package:singly/features/notifications/notification_page.dart';
import 'package:singly/features/settings/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    FeedPage(),
    DiscoverPage(),
    SizedBox(),
    NotificationPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    const String userName = 'Maulik';
    final String initials = userName.isNotEmpty ? userName[0] : '?';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 16,
        title: () {
          if (_currentIndex == 1) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.search),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Search users...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (_currentIndex == 3) {
            return Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            );
          } else if (_currentIndex == 4) {
            return Text(
              'Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [Image.asset('assets/images/logo.png', height: 28)],
            );
          }
        }(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline),
            color: AppColors.textPrimary,
          ),
        ],
      ),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.createPost);
            return;
          }
          setState(() => _currentIndex = index);
        },
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, size: 30),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 30),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _currentIndex == 4
                      ? AppColors.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withAlpha(50),
                child: Text(
                  initials,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
