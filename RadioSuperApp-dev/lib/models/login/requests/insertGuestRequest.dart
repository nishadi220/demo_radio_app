class InsertGuestRequest {
  final String guestId;
  final int languageId;

  InsertGuestRequest({
    required this.guestId,
    required this.languageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'guestId': guestId,
      'languageId': languageId,
    };
  }
}