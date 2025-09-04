class TwoFactorRequest {
  final String twoFactorKey;
  final String userId;

  TwoFactorRequest({required this.twoFactorKey, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'twoFactorKey': twoFactorKey,
      'userId': userId
    };
  }
}