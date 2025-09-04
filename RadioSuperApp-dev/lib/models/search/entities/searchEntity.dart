class SearchEntity {
  final String id;
  final String name;
  final String? description;
  final String duration;
  final String fileUrl;
  final String picUrl;
  final int type;

  // Constructor
  SearchEntity({
    required this.id,
    required this.name,
    this.description,
    required this.duration,
    required this.fileUrl,
    required this.picUrl,
    required this.type,
  });

  // Factory method to create a ContentEntity from JSON
  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      duration: json['duration'] as String,
      fileUrl: json['fileUrl'] as String,
      picUrl: json['picUrl'] as String,
      type: json['type'] as int,
    );
  }

  // Method to convert a ContentEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'fileUrl': fileUrl,
      'picUrl': picUrl,
      'type': type,
    };
  }
}
