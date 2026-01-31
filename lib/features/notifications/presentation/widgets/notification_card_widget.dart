import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
    required this.onTap,
  });

  final String title;
  final String description;
  final String dateTime;
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0, // Flat design
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: isRead
          ? Colors.transparent // Read: Transparent/Default background
          : Theme.of(context).colorScheme.primary.withOpacity(0.05), // Unread: Slight tint
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          // Add a subtle border for read items so they don't disappear
          color: isRead
              ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            fontSize: 16,
            color: isRead
                ? (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700)
                : null, // Default color for unread
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dateTime,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        // Optional: Red dot for unread
        trailing: isRead
            ? null
            : Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}