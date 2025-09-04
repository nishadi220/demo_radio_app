import 'package:radio_super_app/models/radio/entities/showEntity.dart';

class GetShowByStationResponse {
  final String id;
  final String showName;
  final String description;
  final String showSchedule;
  final String picUrl;
  final String startTime;
  final String endTime;
  final String hostName;
  final String? artistName; // Nullable
  final String showCategory;
  final String stationId;
  final int priority;
  final bool active;

  GetShowByStationResponse({
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

  // Factory method to create an instance from JSON
  factory GetShowByStationResponse.fromJson(Map<String, dynamic> json) {
    return GetShowByStationResponse(
      id: json['id'],
      showName: json['showName'],
      description: json['description'],
      showSchedule: json['showSchedule'],
      picUrl: json['picUrl'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      hostName: json['hostName'],
      artistName: json['artistName'], // Handle nullable field
      showCategory: json['showCategory'],
      stationId: json['stationId'],
      priority: json['priority'],
      active: json['active'],
    );
  }

  // Convert the object back to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "showName": showName,
      "description": description,
      "showSchedule": showSchedule,
      "picUrl": picUrl,
      "startTime": startTime,
      "endTime": endTime,
      "hostName": hostName,
      "artistName": artistName, // Nullable field
      "showCategory": showCategory,
      "stationId": stationId,
      "priority": priority,
      "active": active,
    };
  }
}