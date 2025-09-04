import '../entities/languageEntity.dart';

class GetLanguageListResponse {
  final List<LanguageEntity> languages;

  GetLanguageListResponse({required this.languages});

  // Factory constructor to create response from JSON
  factory GetLanguageListResponse.fromJson(List<dynamic> json) {
    return GetLanguageListResponse(
      languages: json.map((item) => LanguageEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return languages.map((language) => language.toJson()).toList();
  }
}
