import 'package:radio_super_app/models/search/responses/getRecentSearchesResponse.dart';
import 'package:radio_super_app/services/dioClient.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class SearchService {
  final ApiService _apiService = ApiService(dioClient: DioClient());
  // final String keyword = "Evening";

  Future<GetSearchesListResponse> fetchSearchList(String keyword) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.searchByKeyword}?keyword=$keyword");
      return GetSearchesListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching radio stations: $e');
      return GetSearchesListResponse(searchList: []);
    }
  }
}


