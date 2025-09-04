class PodcastEpisodeEntity {
  final String id;
  final String name;
  final String description;
  final String pic;
  final String duration;
  final String fileUrl;
  final int? languageId;
  final String? loopId;

  PodcastEpisodeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pic,
    required this.duration,
    required this.fileUrl,
    this.languageId,
    this.loopId,
  });

  // Factory constructor for creating an instance from a JSON object
  factory PodcastEpisodeEntity.fromJson(Map<String, dynamic> json) {
    return PodcastEpisodeEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pic: json['pic'] as String,
      duration: json['duration'] as String,
      fileUrl: json['fileUrl'] as String,
      languageId: json['languageId'] as int,
      loopId: json['loopId'] as String ,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic': pic,
      'duration': duration,
      'fileUrl': fileUrl,
      'languageId': languageId!,
      'loopId': loopId!,
    };
  }
}