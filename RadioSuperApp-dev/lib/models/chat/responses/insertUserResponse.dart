class InsertUserResponse {
  final String message;

  InsertUserResponse({required this.message});

  // Factory constructor to create a response object from JSON
  factory InsertUserResponse.fromJson(Map<String, dynamic> json) {
    return InsertUserResponse(
      message: json["message"],
    );
  }
}