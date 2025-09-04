class StationEntity {
  final String id;
  final String name;
  final String description;
  final String company;
  final String language;
  final int priority;
  final String picUrl;
  final String contentUrl;

  StationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.company,
    required this.language,
    required this.priority,
    required this.picUrl,
    required this.contentUrl,
  });

  // Factory constructor to create a StationEntity from JSON
  factory StationEntity.fromJson(Map<String, dynamic> json) {
    return StationEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      company: json['company'] as String,
      language: json['language'] as String,
      priority: json['priority'] as int,
      picUrl: json['picUrl'] as String,
      contentUrl: json['contentUrl'] as String,
    );
  }

  // Method to convert StationEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'company': company,
      'language': language,
      'priority': priority,
      'picUrl': picUrl,
      'contentUrl': contentUrl,
    };
  }
}
