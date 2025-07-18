import 'package:flutter/material.dart';
import 'package:singly/core/constants/app_constants.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/onboarding/widgets/login_bottom_sheet.dart';
import 'package:singly/features/onboarding/widgets/onboarding_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Your One & Only Post',
      'description':
          'Singly lets you keep a single post that evolves. Replace it anytime. Stay current. Stay unique.',
    },
    {
      'title': 'Profile-First Feed',
      'description':
          'Browse users, not clutter. Tap into curated single posts and swipe to explore profiles.',
    },
    {
      'title': 'No Clutter, Just Content',
      'description':
          'No noise. No old posts. One post per person. Ads only. Simple, clean, and distraction-free.',
    },
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      showLoginBottomSheet(context);
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(child: Image.asset('assets/images/logo.png', height: 80)),
            const SizedBox(height: 12),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: OnboardingPageView(
                controller: _controller,
                pages: _pages,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: _pages.length,
              effect: WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                spacing: 8,
                dotColor: Colors.grey.shade300,
                activeDotColor: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentIndex > 0
                      ? TextButton(
                          onPressed: _prevPage,
                          child: Text(
                            "Back",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        )
                      : const SizedBox(width: 60),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isLastPage ? "Get Started" : "Next",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
