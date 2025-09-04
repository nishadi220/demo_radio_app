import '../entities/categoryGridEntity.dart';

class GetCategoryGridResponse {
  final List<CategoryEntity> categories;

  GetCategoryGridResponse({required this.categories});

  // Factory constructor to create response from JSON
  factory GetCategoryGridResponse.fromJson(List<dynamic> json) {
    return GetCategoryGridResponse(
      categories: json.map((item) => CategoryEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return categories.map((category) => category.toJson()).toList();
  }
}
