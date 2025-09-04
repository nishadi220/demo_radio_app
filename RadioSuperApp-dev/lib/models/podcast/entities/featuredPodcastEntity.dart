class FeaturedPodcastEntity {
  final int id;
  final String podcastId;
  final String createdBy;
  final String name;
  final String podcastDescription;
  final DateTime releaseDate;
  final String picUrl;
  final String startTime;
  final String endTime;
  final String categoryDescription;
  final String stationDescription;

  FeaturedPodcastEntity({
    required this.id,
    required this.podcastId,
    required this.createdBy,
    required this.name,
    required this.podcastDescription,
    required this.releaseDate,
    required this.picUrl,
    required this.startTime,
    required this.endTime,
    required this.categoryDescription,
    required this.stationDescription,
  });

  // Factory constructor to create a FeaturedPlaylistEntity from JSON
  factory FeaturedPodcastEntity.fromJson(Map<String, dynamic> json) {
    return FeaturedPodcastEntity(
      id: json['id'] as int,
      podcastId: json['podcastId'] as String,
      createdBy: json['createdBy'] as String,
      name: json['name'] as String,
      podcastDescription: json['podcastDescription'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      picUrl: json['picUrl'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      categoryDescription: json['categoryDescription'] as String,
      stationDescription: json['stationDescription'] as String,
    );
  }

  // Method to convert FeaturedPlaylistEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'podcastId': podcastId,
      'createdBy': createdBy,
      'name': name,
      'podcastDescription': podcastDescription,
      'releaseDate': releaseDate.toIso8601String(),
      'picUrl': picUrl,
      'startTime': startTime,
      'endTime': endTime,
      'categoryDescription': categoryDescription,
      'stationDescription': stationDescription,
    };
  }
}
