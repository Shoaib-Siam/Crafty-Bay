import 'package:flutter/material.dart';
import '../widgets/notification_card_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const String routeName = '/notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy Data
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Order Shipped',
      'body': 'Your order #12345 has been shipped. Track your package now.',
      'time': '2 hours ago',
      'isRead': false,
    },
    {
      'title': 'Flash Sale Alert!',
      'body': 'Get 50% off on all Nike shoes. Offer ends tonight!',
      'time': '5 hours ago',
      'isRead': false,
    },
    {
      'title': 'Payment Successful',
      'body': 'We have received your payment of 1200 BDT for Order #99887.',
      'time': '1 day ago',
      'isRead': true,
    },
    {
      'title': 'Profile Updated',
      'body': 'You have successfully updated your profile picture.',
      'time': '2 days ago',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          // "Mark all as read" button
          TextButton(
            onPressed: () {
              // TODO: Mark all as read logic
              setState(() {
                for (var n in _notifications) {
                  n['isRead'] = true;
                }
              });
            },
            child: const Text('Read All'),
          )
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return NotificationCardWidget(
            title: notification['title'],
            description: notification['body'],
            dateTime: notification['time'],
            isRead: notification['isRead'],
            onTap: () {
              // Mark single item as read on tap
              setState(() {
                notification['isRead'] = true;
              });
              // Navigate to Order Details or relevant screen
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'No Notifications Yet',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}