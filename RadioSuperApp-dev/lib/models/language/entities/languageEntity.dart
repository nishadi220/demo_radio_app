class LanguageEntity {
  final int id;
  final String name;

  LanguageEntity({
    required this.id,
    required this.name,
  });

  // Factory constructor to create a LanguageEntity from JSON
  factory LanguageEntity.fromJson(Map<String, dynamic> json) {
    return LanguageEntity(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  // Method to convert LanguageEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
