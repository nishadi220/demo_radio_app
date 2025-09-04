import '../entities/featuredPodcastEntity.dart';

class GetFeaturedPodcastResponse {
  final List<FeaturedPodcastEntity> featuredPodcasts;

  GetFeaturedPodcastResponse({required this.featuredPodcasts});

  // Factory constructor to create response from JSON
  factory GetFeaturedPodcastResponse.fromJson(List<dynamic> json) {
    return GetFeaturedPodcastResponse(
      featuredPodcasts: json.map((item) => FeaturedPodcastEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return featuredPodcasts.map((show) => show.toJson()).toList();
  }
}
