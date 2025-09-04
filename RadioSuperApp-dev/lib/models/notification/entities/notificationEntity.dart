class NotificationEntity {
  final int id;
  final String header;
  final String description;

  NotificationEntity({
    required this.id,
    required this.header,
    required this.description,
  });

  // Factory constructor to create a NotificationEntity from JSON
  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] as int,
      header: json['header'] as String,
      description: json['description'] as String,
    );
  }

  // Method to convert NotificationEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'header': header,
      'description': description,
    };
  }
}
