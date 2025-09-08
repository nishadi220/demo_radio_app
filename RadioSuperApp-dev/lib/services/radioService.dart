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

  // Future<GetStationListResponse> fetchRadioStations() async {
  //   try {
  //     final response = await _apiService.getData("${ApiEndpoints.getStationListByCompanyId}?companyId=$companyId");
  //     return GetStationListResponse.fromJson(response.data);
  //
  //   } catch (e) {
  //     print('Error fetching radio stations: $e');
  //     return GetStationListResponse(stations: []);
  //   }
  // }

  Future<GetStationListResponse> fetchRadioStations() async {
    try {
      final testStations = [
        StationEntity(
          id: 'STA001',
          name: 'BBC World Service',
          description: 'Global news, analysis and discussion',
          company: 'BBC',
          language: 'English',
          priority: 1,
          picUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/BBC_World_Service_2022_%28Boxed%29.svg/1200px-BBC_World_Service_2022_%28Boxed%29.svg.png',
          contentUrl: 'http://stream.live.vc.bbcmedia.co.uk/bbc_world_service', // BBC World Service live stream
        ),
        StationEntity(
          id: 'STA002',
          name: 'Cashmere Radio',
          description: 'National Public Radio – news, talk, and music',
          company: 'NPR',
          language: 'English',
          priority: 2,
          picUrl: 'https://media.cashmereradio.com/wp-content/uploads/2017/09/22222251/Cashmere_Logo.jpg',
          contentUrl: 'https://cashmereradio.out.airtime.pro/cashmereradio_b', // NPR live stream
        ),
        StationEntity(
          id: 'STA003',
          name: 'France Inter',
          description: 'French public radio station with music & news',
          company: 'Radio France',
          language: 'French',
          priority: 3,
          picUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/France_Inter_logo_2021.svg/500px-France_Inter_logo_2021.svg.png',
          contentUrl: 'http://direct.franceinter.fr/live/franceinter-midfi.mp3', // France Inter live stream
        ),
        StationEntity(
          id: 'STA004',
          name: 'Newtown Radio',
          description: 'German international broadcaster – news and culture',
          company: 'DW',
          language: 'German/English',
          priority: 4,
          picUrl: 'https://freemusicarchive.org/image/?file=images%2Falbums%2FNewtown_Radio_VA_-_Newtown_Radio_Sessions_-_20120208154037968.jpg&width=290&height=290&type=album',
          contentUrl: 'https://streaming.radio.co/s0d090ee43/listen', // DW live stream
        ),
        StationEntity(
          id: 'STA005',
          name: 'Kiosk Radio',
          description: 'Australian international radio – news, music & culture',
          company: 'ABC',
          language: 'English',
          priority: 5,
          picUrl: 'https://yt3.googleusercontent.com/ytc/AIdro_kgg1Z77NPyRGhb2biQf30iSy3eaN8YpGgwGvv6eSZZew8=s900-c-k-c0x00ffffff-no-rj',
          contentUrl: 'https://kioskradiobxl.out.airtime.pro/kioskradiobxl_b', // Radio Australia live stream
        ),
      ];

      return GetStationListResponse(stations: testStations);
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



