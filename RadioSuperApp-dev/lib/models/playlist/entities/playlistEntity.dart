class PlaylistEntity {
  final String id;
  final String name;
  final String description;
  final String pic;
  final int categoryId;

  PlaylistEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pic,
    required this.categoryId,
  });

  // Factory constructor to create a PlaylistEntity from JSON
  factory PlaylistEntity.fromJson(Map<String, dynamic> json) {
    return PlaylistEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pic: json['pic'] as String,
      categoryId: json['categoryId'] as int,
    );
  }

  // Method to convert PlaylistEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic': pic,
      'categoryId': categoryId,
    };
  }
}