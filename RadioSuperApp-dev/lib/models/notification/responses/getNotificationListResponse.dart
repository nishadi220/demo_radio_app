import '../entities/notificationEntity.dart';

class GetNotificationListResponse {
  final List<NotificationEntity> notifications;

  GetNotificationListResponse({required this.notifications});

  // Factory constructor to create response from JSON
  factory GetNotificationListResponse.fromJson(List<dynamic> json) {
    return GetNotificationListResponse(
      notifications: json.map((item) => NotificationEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return notifications.map((language) => language.toJson()).toList();
  }
}