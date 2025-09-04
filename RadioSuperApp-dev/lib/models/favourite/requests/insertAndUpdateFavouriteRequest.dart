class InsertAndUpdateFavouriteRequest {
  final String contentId;
  final String userId;
  final String guestId;
  final bool active;

  InsertAndUpdateFavouriteRequest({
    required this.contentId,
    required this.userId,
    required this.guestId,
    required this.active
  });

  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'userId': userId,
      'guestId': guestId,
      'active': active,
    };
  }
}