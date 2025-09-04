import '../entities/podcastEpisodeEntity.dart';

class GetPodcastEpisodeResponse {
  final List<PodcastEpisodeEntity> episodes;

  GetPodcastEpisodeResponse({required this.episodes});

  // Factory constructor to create response from JSON
  factory GetPodcastEpisodeResponse.fromJson(List<dynamic> json) {
    return GetPodcastEpisodeResponse(
      episodes: json.map((item) => PodcastEpisodeEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return episodes.map((episode) => episode.toJson()).toList();
  }
}