class PodcastEntity {
  final String id;
  final String name;
  final String description;
  final String releaseDate;
  final String picUrl;
  final String startTime;
  final String endTime;
  final String fileUrl;
  final String hostId;
  final String artistName;
  final String podcastCategory;
  final String stationId;
  final int priority;
  final bool active;

  PodcastEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.releaseDate,
    required this.picUrl,
    required this.startTime,
    required this.endTime,
    required this.fileUrl,
    required this.hostId,
    required this.artistName,
    required this.podcastCategory,
    required this.stationId,
    required this.priority,
    required this.active,
  });

  // Factory constructor to create PodcastEntity from JSON
  factory PodcastEntity.fromJson(Map<String, dynamic> json) {
    return PodcastEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      releaseDate: (json['releaseDate'] as String),
      picUrl: json['picUrl'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      fileUrl: json['fileUrl'] as String,
      hostId: json['hostId'] as String,
      artistName: json['artistName'] as String,
      podcastCategory: json['podcastCategory'] as String,
      stationId: json['stationId'] as String,
      priority: json['priority'] as int,
      active: json['active'] as bool,
    );
  }

  // Method to convert PodcastEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'releaseDate': releaseDate,
      'picUrl': picUrl,
      'startTime': startTime,
      'endTime': endTime,
      'fileUrl': fileUrl,
      'hostId': hostId,
      'artistName': artistName,
      'podcastCategory': podcastCategory,
      'stationId': stationId,
      'priority': priority,
      'active': active,
    };
  }
}
