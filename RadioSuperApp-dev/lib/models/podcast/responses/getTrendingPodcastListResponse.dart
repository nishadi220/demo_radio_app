import '../entities/trendingPodcastEntity.dart';

class GetTrendingPodcastListResponse {
  final List<TrendingPodcastEntity> podcasts;

  GetTrendingPodcastListResponse({required this.podcasts});

  // Factory constructor to create response from JSON
  factory GetTrendingPodcastListResponse.fromJson(List<dynamic> json) {
    return GetTrendingPodcastListResponse(
      podcasts: json.map((item) => TrendingPodcastEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return podcasts.map((podcast) => podcast.toJson()).toList();
  }
}
