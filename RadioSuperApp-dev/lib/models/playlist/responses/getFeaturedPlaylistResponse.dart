import '../entities/featuredPlaylistEntity.dart';

class GetFeaturedPlaylistResponse {
  final List<FeaturedPlaylistEntity> featuredPlaylist;

  GetFeaturedPlaylistResponse({required this.featuredPlaylist});

  // Factory constructor to create response from JSON
  factory GetFeaturedPlaylistResponse.fromJson(List<dynamic> json) {
    return GetFeaturedPlaylistResponse(
      featuredPlaylist: json.map((item) => FeaturedPlaylistEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return featuredPlaylist.map((show) => show.toJson()).toList();
  }
}
