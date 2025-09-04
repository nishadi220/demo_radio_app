import '../entities/playlistEntity.dart';

class GetPlaylistResponse {
  final List<PlaylistEntity> playlists;

  GetPlaylistResponse({required this.playlists});

  // Factory constructor to create response from JSON
  factory GetPlaylistResponse.fromJson(List<dynamic> json) {
    return GetPlaylistResponse(
      playlists: json.map((item) => PlaylistEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return playlists.map((playlist) => playlist.toJson()).toList();
  }
}
