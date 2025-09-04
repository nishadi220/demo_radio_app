import 'package:radio_super_app/models/radio/entities/stationEntity.dart';
import 'package:radio_super_app/models/radio/requests/getCurrentShowByStationRequest.dart';
import 'package:radio_super_app/models/radio/responses/getShowListResponse.dart';
import 'package:radio_super_app/services/dioClient.dart';
import '../models/radio/responses/getShowByStation.dart';
import '../models/radio/responses/getStationListResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class RadioService {
  final ApiService _apiService = ApiService(dioClient: DioClient());
  final String companyId = "COM001";
  // final String stationId = "STA002";

  Future<GetStationListResponse> fetchRadioStations() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getStationListByCompanyId}?companyId=$companyId");
      return GetStationListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching radio stations: $e');
      return GetStationListResponse(stations: []);
    }
  }

  Future<GetShowListResponse> fetchRadioShowsForStation({required String stationId, required bool upcomming}) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getShowsByStationId}?stationId=$stationId&upcoming=${true}");
      return GetShowListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching radio shows: $e');
      return GetShowListResponse(shows: []);
    }
  }
  
  Future<GetShowByStationResponse?> fetchCurrentShowByStation({required GetCurrentShowByStationRequest request}) async {
    try {
      final response = await _apiService.postData(
          ApiEndpoints.getCurrentShowsByStationId,
          request.toJson()
      );

      // return StationEntity.fromJson(response.data);
      if (response.statusCode == 200) {
        print('Show fetched successfully : ${response.data}');
        return GetShowByStationResponse.fromJson(response.data);
      } else {
        return null;
      }

    } catch (e) {
      print('Error fetching radio shows: $e');
      return null;
    }
  }
}



