class ChatMessage {
  final String showId;
  final String name;
  final String userId;
  final String userTypeId;
  final String message;
  final DateTime createDateTime;

  ChatMessage({
    required this.showId,
    required this.name,
    required this.userId,
    required this.userTypeId,
    required this.message,
    required this.createDateTime,
  });

  // Factory constructor for JSON deserialization
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      showId: json['showId'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      userTypeId: json['userTypeId'] as String,
      message: json['message'] as String,
      createDateTime: DateTime.parse(json['createDateTime'] as String),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'name': name,
      'userId': userId,
      'userTypeId': userTypeId,
      'message': message,
      'createDateTime': createDateTime.toIso8601String(),
    };
  }
}