import '../entities/searchEntity.dart';

class GetSearchesListResponse {
  final List<SearchEntity> searchList;

  GetSearchesListResponse({required this.searchList});

  // Factory constructor to create response from JSON
  factory GetSearchesListResponse.fromJson(List<dynamic> json) {
    // print('Raw Data in fromJson: $json');

    return GetSearchesListResponse(
      // searchList: json.map((item) => SearchEntity.fromJson(item)).toList(),
      searchList: json.map((item) {
        print('Item being mapped: $item'); // Log each item being processed
        return SearchEntity.fromJson(item);
      }).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return searchList.map((show) => show.toJson()).toList();
  }
}
