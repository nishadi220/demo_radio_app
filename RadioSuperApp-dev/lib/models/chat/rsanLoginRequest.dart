class RsanLoginRequest {
  final String phone;
  final String name;
  final String guestId;
  final int languageId;
  final String? email; //

  RsanLoginRequest({
    required this.phone,
    required this.name,
    required this.guestId,
    required this.languageId,
    this.email,
  });

  // Convert the request object to JSON for API calls
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "phone": phone,
      "name": name,
      "guestId": guestId,
      "languageId": languageId,
    };

    // Only include email if it's not null
    if (email != null) {
      data["email"] = email;
    }

    return data;
  }
}