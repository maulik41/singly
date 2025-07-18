import 'package:flutter/material.dart';
import 'package:singly/core/routes/app_routes.dart';
import 'package:singly/core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        _sectionTitle(context, 'Account'),
        _settingsTile(
          context,
          icon: Icons.person_outline,
          title: 'Edit Profile',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.editProfile);
          },
        ),
        _settingsTile(
          context,
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _sectionTitle(context, 'Notifications'),
        _settingsTile(
          context,
          icon: Icons.notifications_none,
          title: 'Push Notifications',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _sectionTitle(context, 'App Preferences'),
        _settingsTile(
          context,
          icon: Icons.color_lens_outlined,
          title: 'Theme',
          onTap: () {},
        ),
        _settingsTile(
          context,
          icon: Icons.language,
          title: 'Language',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _sectionTitle(context, 'Support'),
        _settingsTile(
          context,
          icon: Icons.help_outline,
          title: 'Help & FAQs',
          onTap: () {},
        ),
        _settingsTile(
          context,
          icon: Icons.feedback_outlined,
          title: 'Send Feedback',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _sectionTitle(context, 'About'),
        _settingsTile(
          context,
          icon: Icons.info_outline,
          title: 'About Singly',
          onTap: () {},
        ),
        _settingsTile(
          context,
          icon: Icons.verified_outlined,
          title: 'Terms & Privacy',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _sectionTitle(context, 'Danger Zone'),
        _settingsTile(
          context,
          icon: Icons.logout,
          title: 'Logout',
          titleColor: AppColors.error,
          iconColor: AppColors.error,
          onTap: () {},
        ),
        _settingsTile(
          context,
          icon: Icons.delete_forever_outlined,
          title: 'Delete Account',
          titleColor: AppColors.error,
          iconColor: AppColors.error,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: iconColor ?? AppColors.textMuted),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: titleColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}
