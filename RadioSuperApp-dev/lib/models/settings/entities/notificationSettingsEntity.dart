class NotificationSettingsEntity {
  final int id;
  final String notification;
  bool status;

  // Constructor
  NotificationSettingsEntity({
    required this.id,
    required this.notification,
    required this.status,
  });

  // Factory method to create a NotificationEntity from JSON
  factory NotificationSettingsEntity.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsEntity(
      id: json['id'] as int,
      notification: json['notification'] as String,
      status: json['status'] as bool,
    );
  }

  // Method to convert a NotificationEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notification': notification,
      'status': status,
    };
  }
}
