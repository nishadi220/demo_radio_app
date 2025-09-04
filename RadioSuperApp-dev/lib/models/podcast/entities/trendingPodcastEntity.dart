class TrendingPodcastEntity {
  final String id;
  final String name;
  final String description;
  final String picUrl;

  TrendingPodcastEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.picUrl,
  });

  // Factory constructor to create a TrendingPodcastEntity from JSON
  factory TrendingPodcastEntity.fromJson(Map<String, dynamic> json) {
    return TrendingPodcastEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      picUrl: json['picUrl'] as String,
    );
  }

  // Method to convert TrendingPodcastEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'picUrl': picUrl,
    };
  }
}
