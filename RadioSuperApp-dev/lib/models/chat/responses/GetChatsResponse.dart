class GetChatsResponse {
  final List<Map<String, String>> chats;

  GetChatsResponse({required this.chats});

  // Factory constructor to create a response object from JSON
  factory GetChatsResponse.fromJson(Map<String, dynamic> json) {
    return GetChatsResponse(chats: []
      // json["chats"].map((chat) => Chat.fromJson(chat)).toList(),
      // message: json["message"],
    );
  }
}