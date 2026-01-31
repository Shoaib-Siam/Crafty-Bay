import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/asset_paths.dart';
import '../../../notifications/presentation/screens/notification_screen.dart';
import '../../../settings/presentation/screens/account_settings_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  // Dummy Profile Image URL (Replace with real API data later)
  final String userProfileImage =
      "https://i.pravatar.cc/150?u=a042581f4e29026704d";

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor = isDarkMode
        ? const Color(0xFF2C2C2C)
        : Colors.grey.shade200;
    final Color iconColor = isDarkMode ? Colors.grey.shade400 : Colors.grey;

    return AppBar(
      title: SvgPicture.asset(AssetPaths.logoNavSvg),
      actions: [
        // 1. Notification Icon (Unchanged)
        InkWell(
          onTap: () {
            // FIX: Navigate to Notification Screen
            Navigator.pushNamed(context, NotificationScreen.routeName);
          },
          borderRadius: BorderRadius.circular(16),
          child: CircleAvatar(
            backgroundColor: circleColor,
            radius: 16,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  size: 20,
                  color: iconColor,
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: circleColor, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 12),

        // 2. Profile Icon (Click to go to Settings)
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AccountSettingsScreen.routeName);
          },
          borderRadius: BorderRadius.circular(24), // Increased ripple radius
          child: Container(
            padding: const EdgeInsets.all(
              2,
            ), // White space between border and image
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary, // Color of the circle
                width: 2, // Thickness of the circle
              ),
            ),
            child: CircleAvatar(
              backgroundColor: circleColor,
              radius: 16,
              backgroundImage: NetworkImage(userProfileImage),
              onBackgroundImageError: (_, __) {
                // Handle image load error
              },
              // Tip: Standard CircleAvatar puts child ON TOP of image.
              // If you want a fallback, consider using CachedNetworkImage library later.
              child: null,
            ),
          ),
        ),

        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
