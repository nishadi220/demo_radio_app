import '../entities/favouriteEntity.dart';

class GetFavoriteListResponse {
  final List<FavoriteEntity> favorites;

  GetFavoriteListResponse({required this.favorites});

  // Factory constructor to create response from JSON
  factory GetFavoriteListResponse.fromJson(List<dynamic> json) {
    return GetFavoriteListResponse(
      favorites: json.map((item) => FavoriteEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return favorites.map((favorite) => favorite.toJson()).toList();
  }
}
