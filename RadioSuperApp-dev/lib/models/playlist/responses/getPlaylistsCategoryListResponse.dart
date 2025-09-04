import '../entities/playlistsCategoryEntity.dart';

class GetPlaylistsCategoryGridResponse {
  final List<PlaylistsCategoryEntity> categories;

  GetPlaylistsCategoryGridResponse({required this.categories});

  // Factory constructor to create response from JSON
  factory GetPlaylistsCategoryGridResponse.fromJson(List<dynamic> json) {
    return GetPlaylistsCategoryGridResponse(
      categories: json.map((item) => PlaylistsCategoryEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return categories.map((category) => category.toJson()).toList();
  }
}
