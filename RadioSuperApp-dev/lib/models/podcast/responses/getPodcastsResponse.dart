import '../entities/podcastsEntity.dart';

class GetPodcastResponse {
  final List<PodcastEntity> podcasts;

  GetPodcastResponse({required this.podcasts});

  // Factory constructor to create response from JSON
  factory GetPodcastResponse.fromJson(List<dynamic> json) {
    return GetPodcastResponse(
      podcasts: json.map((item) => PodcastEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return podcasts.map((playlist) => playlist.toJson()).toList();
  }
}
