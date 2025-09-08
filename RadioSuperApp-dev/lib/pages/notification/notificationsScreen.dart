import 'package:flutter/material.dart';

import '../../components/Common/futureBuilderWidget.dart';
import '../../components/Notification/NotificationItem.dart';
import '../../models/notification/responses/getNotificationListResponse.dart';
import '../../services/notificationService.dart';

class NotificationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7030A0), // Custom purple
              Colors.black,       // Black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilderWidget<GetNotificationListResponse>(
                future: NotificationService().fetchNotifications(), // Fetch notifications asynchronously
                onSuccess: (notifications) {
                  return ListView.builder(
                    itemCount: notifications.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications.notifications[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 0.0,
                        ),
                        child: NotificationItem(
                          // senderImage: notification["senderImage"]!,
                          // senderName: notification["senderName"]!,
                          // message: notification["message"]!,
                          // timeAgo: notification["timeAgo"]!,
                          header: notification.header,
                          description: notification.description,
                        ),
                      );
                    },
                  );
                },
                onError: (error) {
                  return const Center(
                    child: Text(
                      'Failed to load notifications. Please try again.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
