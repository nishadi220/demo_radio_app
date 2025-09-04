class GetCurrentShowByStationRequest {
  final String stationId;
  final String currentTime;

  GetCurrentShowByStationRequest({
    required this.stationId,
    required this.currentTime,
  });

  // Convert the request object to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      "stationId": stationId,
      "currentTime": currentTime,
    };
  }
}