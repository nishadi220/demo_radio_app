import '../entities/showEntity.dart';

class GetShowListResponse {
  final List<ShowEntity> shows;

  GetShowListResponse({required this.shows});

  // Factory constructor to create response from JSON
  factory GetShowListResponse.fromJson(List<dynamic> json) {
    return GetShowListResponse(
      shows: json.map((item) => ShowEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return shows.map((show) => show.toJson()).toList();
  }
}
