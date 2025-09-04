class updateUserAndGuestLanguageEntity {
  final String userId;
  final String guestId;
  final int languageId;
  final String updatedBy;

  updateUserAndGuestLanguageEntity({
    required this.userId,
    required this.guestId,
    required this.languageId,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'guestId': guestId,
      'languageId': languageId,
      'isActive': updatedBy,
    };
  }
}
