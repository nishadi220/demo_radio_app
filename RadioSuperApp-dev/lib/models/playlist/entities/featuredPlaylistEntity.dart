class FeaturedPlaylistEntity {
  final int id;
  final String playlistId;
  final String createBy;
  final String name;
  final String language;
  final String description;
  final String picUrl;

  FeaturedPlaylistEntity({
    required this.id,
    required this.playlistId,
    required this.createBy,
    required this.name,
    required this.language,
    required this.description,
    required this.picUrl,
  });

  // Factory constructor to create a ShowEntity from JSON
  factory FeaturedPlaylistEntity.fromJson(Map<String, dynamic> json) {
    return FeaturedPlaylistEntity(
      id: json['id'] as int,
      playlistId: json['playlistId'] as String,
      createBy: json['createBy'] as String,
      name: json['name'] as String,
      language: json['language'] as String,
      description: json['description'] as String,
      picUrl: json['picUrl'] as String,
    );
  }

  // Method to convert ShowEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playlistId': playlistId,
      'createBy': createBy,
      'name': name,
      'language': language,
      'description': description,
      'picUrl': picUrl,
    };
  }
}
