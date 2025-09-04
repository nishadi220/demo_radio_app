class EpisodeEntity {
  final String id;
  final String playlistId;
  final String name;
  final String artists;
  final String duration;
  final String pic;
  final String composers;
  final String lyricists;
  final String fileUrl;


  EpisodeEntity({
    required this.id,
    required this.playlistId,
    required this.name,
    required this.artists,
    required this.duration,
    required this.pic,
    required this.composers,
    required this.lyricists,
    required this.fileUrl,
  });

  // Factory constructor to create a ShowEntity from JSON
  factory EpisodeEntity.fromJson(Map<String, dynamic> json) {
    return EpisodeEntity(
      id: json['id'] as String,
      playlistId: json['playlistId'] as String,
      name: json['name'] as String,
      artists: json['artists'] as String,
      duration: json['duration'] as String,
      pic: json['pic'] as String,
      composers: json['composers'] as String,
      lyricists: json['lyricists'] as String,
      fileUrl: json['fileUrl'] as String,

    );
  }

  // Method to convert ShowEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playlistId': playlistId,
      'name': name,
      'artists': artists,
      'duration': duration,
      'pic': pic,
      'composers': composers,
      'lyricists': lyricists,
      'fileUrl': fileUrl,
    };
  }
}
