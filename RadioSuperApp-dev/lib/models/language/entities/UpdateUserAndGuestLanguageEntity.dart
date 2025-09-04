class UpdateUserAndGuestLanguageEntity {
  final String userId;
  final String guestId;
  final int languageId;
  final String updatedBy;

  UpdateUserAndGuestLanguageEntity({
    required this.userId,
    required this.guestId,
    required this.languageId,
    required this.updatedBy,
  });

  // Factory constructor to create a LanguageEntity from JSON
  factory UpdateUserAndGuestLanguageEntity.fromJson(Map<String, dynamic> json) {
    return UpdateUserAndGuestLanguageEntity(
      userId: json['userId'] as String,
      guestId: json['guestId'] as String,
      languageId: json['languageId'] as int,
      updatedBy: json['updatedBy'] as String,
    );
  }

  // Method to convert LanguageEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'guestId': guestId,
      'languageId': languageId,
      'updatedBy': updatedBy,
    };
  }
}
