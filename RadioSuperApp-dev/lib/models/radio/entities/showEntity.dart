class ShowEntity {
  final String id;
  final String showName;
  final String description;
  final String showSchedule;
  final String picUrl;
  final String startTime;
  final String endTime;
  final String hostName;
  final String? artistName;
  final String showCategory;
  final String stationId;
  final int priority;
  final bool active;

  ShowEntity({
    required this.id,
    required this.showName,
    required this.description,
    required this.showSchedule,
    required this.picUrl,
    required this.startTime,
    required this.endTime,
    required this.hostName,
    this.artistName,
    required this.showCategory,
    required this.stationId,
    required this.priority,
    required this.active,
  });

  // Factory constructor to create a ShowEntity from JSON
  factory ShowEntity.fromJson(Map<String, dynamic> json) {
    return ShowEntity(
      id: json['id'] as String,
      showName: json['showName'] as String,
      description: json['description'] as String,
      showSchedule: json['showSchedule'] as String,
      picUrl: json['picUrl'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      hostName: json['hostName'] as String,
      artistName: json['artistName'] as String?,
      showCategory: json['showCategory'] as String,
      stationId: json['stationId'] as String,
      priority: json['priority'] as int,
      active: json['active'] as bool,
    );
  }

  // Method to convert ShowEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'showName': showName,
      'description': description,
      'showSchedule': showSchedule,
      'picUrl': picUrl,
      'startTime': startTime,
      'endTime': endTime,
      'hostName': hostName,
      'artistName': artistName,
      'showCategory': showCategory,
      'stationId': stationId,
      'priority': priority,
      'active': active,
    };
  }
}
