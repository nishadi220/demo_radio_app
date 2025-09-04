class UpdateNotificationEntity {
  final Future<String> guestId;
  final int notificationSettingId;
  bool isActive;

  UpdateNotificationEntity({
    required this.guestId,
    required this.notificationSettingId,
    required this.isActive,
  });

  // Convert the request object to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'guestId': guestId,
      'notificationSettingId': notificationSettingId,
      'isActive': isActive,
    };
  }
}
