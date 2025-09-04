import '../entities/languageEntity.dart';

class GetSelectedLanguageResponse {
  final List<LanguageEntity> languages;

  GetSelectedLanguageResponse({required this.languages});

  // Factory constructor to create response from JSON
  factory GetSelectedLanguageResponse.fromJson(List<dynamic> json) {
    return GetSelectedLanguageResponse(
      languages: json.map((item) => LanguageEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return languages.map((language) => language.toJson()).toList();
  }
}
