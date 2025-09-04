import '../entities/notificationSettingsEntity.dart';

class GetNotificationSettingsResponse {
  final List<NotificationSettingsEntity> notificationList;

  GetNotificationSettingsResponse({required this.notificationList});

  // Factory constructor to create response from JSON
  factory GetNotificationSettingsResponse.fromJson(List<dynamic> json) {
    return GetNotificationSettingsResponse(
      notificationList: json.map((item) => NotificationSettingsEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return notificationList.map((show) => show.toJson()).toList();
  }
}
