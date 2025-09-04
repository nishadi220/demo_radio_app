import '../entities/stationEntity.dart';

class GetStationListResponse {
  final List<StationEntity> stations;

  GetStationListResponse({required this.stations});

  // Factory constructor to create response from JSON
  factory GetStationListResponse.fromJson(List<dynamic> json) {
    return GetStationListResponse(
      stations: json.map((item) => StationEntity.fromJson(item)).toList(),
    );
  }

  // Method to convert response to JSON format
  List<Map<String, dynamic>> toJson() {
    return stations.map((station) => station.toJson()).toList();
  }
}