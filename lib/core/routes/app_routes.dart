import 'package:flutter/material.dart';
import 'package:singly/features/discover/screens/discover_page.dart';
import 'package:singly/features/discover/screens/search_page.dart';
import 'package:singly/features/discover/screens/search_results_page.dart';
import 'package:singly/features/feed/screens/feed_page.dart';
import 'package:singly/features/main_screen.dart';
import 'package:singly/features/notifications/notification_page.dart';
import 'package:singly/features/onboarding/onboarding_screen.dart';
import 'package:singly/features/feed/screens/post_view_page.dart';
import 'package:singly/features/post/create_post_page.dart';
import 'package:singly/features/settings/edit_profile_page.dart';
import 'package:singly/features/settings/settings_page.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String main = '/main';
  static const String home = '/home';
  static const String viewPost = '/view-post';
  static const String createPost = '/create-post';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const editProfile = '/edit-profile';

  // Discover
  static const String discover = '/discover';
  static const String search = '/discover/search';
  static const String searchResults = '/discover/search/results';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    home: (context) => const FeedPage(),
    viewPost: (context) => const PostViewPage(),
    discover: (context) => const DiscoverPage(),
    search: (context) => const SearchPage(),
    main: (context) => const MainScreen(),
    createPost: (context) => const CreatePostPage(),
    notifications: (context) => const NotificationPage(),
    settings: (context) => const SettingsPage(),
    editProfile: (context) => const EditProfilePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == searchResults) {
      final query = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchResultsPage(query: query),
        settings: settings,
      );
    }

    // Default fallback
    return MaterialPageRoute(
      builder: (_) => const OnboardingScreen(),
      settings: settings,
    );
  }
}
