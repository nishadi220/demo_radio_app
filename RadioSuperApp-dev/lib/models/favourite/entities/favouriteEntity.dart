class FavoriteEntity {
  final String id;
  final String name;
  final String description;
  final String pic;
  final String duration;
  final String fileUrl;
  final int type;
  final String? show;
  final String? podcast;
  // final String loopId;
  // final bool active;

  FavoriteEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pic,
    required this.duration,
    required this.fileUrl,
    required this.type,
    this.show,
    this.podcast,
    // required this.loopId,
    // required this.active,
  });

  // Factory constructor to create a FavoriteItemEntity from JSON
  factory FavoriteEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pic: json['pic'] as String,
      duration: json['duration'] as String,
      fileUrl: json['fileUrl'] as String,
      type: json['type'] as int,
      show: json['show'] as String?,
      podcast: json['podcast'] as String?,
      // loopId: json['loopId'] as String,
      // active: (json['active'] as int) == 1, // Assuming 'bit' is represented as 1/0
    );
  }

  // Method to convert FavoriteItemEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic': pic,
      'duration': duration,
      'fileUrl': fileUrl,
      'type': type,
      'show': show,
      'podcast': podcast,
      // 'loopId': loopId,
      // 'active': active ? 1 : 0, // Convert bool to bit (1/0)
    };
  }
}
