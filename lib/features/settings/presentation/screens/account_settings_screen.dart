import 'package:flutter/material.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  static const String routeName = '/account-settings';

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  // Dummy state for the Theme Switch
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Determine colors based on current theme
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color sectionTitleColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account & Settings'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. User Profile Header
          _buildUserProfileHeader(context),

          const SizedBox(height: 30),

          // 2. Account Section
          Text(
            "Account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: sectionTitleColor,
            ),
          ),
          const SizedBox(height: 8),

          _buildSettingsTile(
            icon: Icons.person_outline,
            title: "Personal Information",
            onTap: () {
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
          ),
          _buildSettingsTile(
            icon: Icons.shopping_bag_outlined,
            title: "My Orders",
            onTap: () {},
          ),

          const SizedBox(height: 24),

          // 3. Settings Section
          Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: sectionTitleColor,
            ),
          ),
          const SizedBox(height: 8),

          // Dark Mode Switch
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // FIX: ClipRRect ensures the ripple effect doesn't bleed out
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SwitchListTile(
                secondary: Icon(
                  _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  // TODO: Call your ThemeController here
                },
              ),
            ),
          ),

          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),

          const SizedBox(height: 24),

          // 4. Support Section
          Text(
            "Support",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: sectionTitleColor,
            ),
          ),
          const SizedBox(height: 8),

          _buildSettingsTile(
            icon: Icons.phone_outlined,
            title: "Call Support",
            subtitle: "Call us at +8801700000000",
            onTap: () {
              print("Calling support...");
            },
          ),

          const SizedBox(height: 24),

          // 5. Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Clear User Data & Navigate to Login
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Logout"),
            ),
          ),

          const SizedBox(height: 30),
          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for the User Header
  Widget _buildUserProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: const NetworkImage(
            "https://i.pravatar.cc/150?u=a042581f4e29026704d",
          ),
          backgroundColor: Colors.grey.shade200,
          onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 30),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanvir Ahmed",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "tanvir@gmail.com",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Widget for Standard Settings Tiles
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material( // <--- WRAP IN MATERIAL
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias, // <--- CLIPS RIPPLE
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: subtitle != null
              ? Text(subtitle, style: const TextStyle(fontSize: 12))
              : null,
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}