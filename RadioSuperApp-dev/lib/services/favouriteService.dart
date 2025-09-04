import 'dart:convert';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/services/dioClient.dart';
import '../models/favourite/requests/insertAndUpdateFavouriteRequest.dart';
import '../models/favourite/responses/getFavouriteResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class FavoriteService {
  final ApiService _apiService = ApiService(dioClient: DioClient());

  Future<GetFavoriteListResponse> fetchFavorites() async {
    try {
      final guestId = await SharedPreferencesManager().getDeviceId();
      final response = await _apiService.getData("${ApiEndpoints.getGuestFavoriteListById}?guestId=$guestId");
      return GetFavoriteListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching favorites: $e');
      return GetFavoriteListResponse(favorites: []);
    }
  }

  Future<String?> insertAndUpdateFavourite({required InsertAndUpdateFavouriteRequest InsertAndUpdateFavouriteRequest}) async {
    try {
      final response = await _apiService.postData(ApiEndpoints.insertAndUpdateFavorite, InsertAndUpdateFavouriteRequest.toJson()
      );

      if (response.statusCode == 200) {
        // Login successful
        return response.data;
      } else {
        return null;
      }

    } catch (e) {
      print('Error fetching user favourites: $e');
      return null;
    }
  }
}
