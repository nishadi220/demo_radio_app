class InsertChatRequest {
  final String showId;
  final String message;
  final String userId; // Add the chatId field

  InsertChatRequest({
    required this.showId,
    required this.message,
    required this.userId, // Add the chatId field
  });

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'message': message,
      'userId': userId, // Add the chatId field
    };
  }
}
