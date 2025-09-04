import '../entities/episodeEntity.dart';

class GetEpisodeListResponse {
  final List<EpisodeEntity> episodes;

  GetEpisodeListResponse({required this.episodes});

  // Factory constructor to create response from JSON
  factory GetEpisodeListResponse.fromJson(List<dynamic> json) {
    return GetEpisodeListResponse(
      episodes: json.map((item) => EpisodeEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return episodes.map((show) => show.toJson()).toList();
  }
}
