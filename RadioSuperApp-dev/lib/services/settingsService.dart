import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/models/language/entities/languageEntity.dart';
import 'package:radio_super_app/models/notification/entities/updateNotificationEntity.dart';
import 'package:radio_super_app/services/dioClient.dart';

import '../models/language/entities/LanguageListWithSelectedEntity.dart';
import '../models/language/entities/UpdateUserAndGuestLanguageEntity.dart';
import '../models/language/responses/getLanguageListResponse.dart';
import '../models/language/responses/getSelectedLanguageResponse.dart';
import '../models/notification/entities/updateUserAndGuestLanguageEntity.dart';
import '../models/settings/requests/getNotificationSettingsResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class SettingsService {
  final ApiService _apiService = ApiService(dioClient: DioClient());

  // String guestId = 'GTest';

  Future<GetLanguageListResponse> fetchLanguages() async {
    try {
      final response = await _apiService.getData(ApiEndpoints.getLanguageList);
      return GetLanguageListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching languages: $e');
      return GetLanguageListResponse(languages: []);
    }
  }

  Future<GetNotificationSettingsResponse> fetchNotificationSettings() async {
    try {
      String guestId = await SharedPreferencesManager().getDeviceId();

      final response = await _apiService.getData("${ApiEndpoints.getNotificationSettingByGuestId}?guestId=$guestId");
      return GetNotificationSettingsResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching notifications settings: $e');
      return GetNotificationSettingsResponse(notificationList: []);
    }
  }

  Future<String?> updateNotificationSettings({required UpdateNotificationEntity updateNotificationEntity}) async {
    try {
      final response = await _apiService.putData(ApiEndpoints.updateNotificationById, updateNotificationEntity.toJson());

      if (response.statusCode == 200) {
        // Login successful
        return response.data;
      } else {
        return null;
      }

    } catch (e) {
      print('Error updating Notifications: $e');
      return null;
      // return GetStationListResponse(stations: []);
    }
  }

  Future<String?> updateUserAndGuestLanguage({required UpdateUserAndGuestLanguageEntity updateUserAndGuestLanguageEntity}) async {
    try {
      final jsonData = updateUserAndGuestLanguageEntity.toJson();
      final response = await _apiService.putData(ApiEndpoints.updateUserAndGuestLanguage, jsonData);

      if (response.statusCode == 200) {

        return response.data;
      } else {
        return null;
      }

    } catch (e) {
      print('Error updating Language: $e');
      return null;
    }
  }

  Future<LanguageListWithSelectedEntity> fetchLanguagesAndSelectedLanguage() async {
    try {
      String guestId = await SharedPreferencesManager().getDeviceId();
      // String guestId = 'GTest';

      GetLanguageListResponse? languageList;
      LanguageEntity? selectedLanguage;

      try {
        final languageResponse = await _apiService.getData(ApiEndpoints.getLanguageList);
        languageList = GetLanguageListResponse.fromJson(languageResponse.data);
      } catch (e) {
        print('Error fetching language list: $e');
        throw Exception('Failed to fetch language list');
      }

      try {
        final selectedLanguageResponse = await _apiService.getData("${ApiEndpoints.getLanguageByGuestOrUserId}?guestId=$guestId");
        selectedLanguage = LanguageEntity.fromJson(selectedLanguageResponse.data);
      } catch (e) {
        print('Error fetching selected language: $e');
        throw Exception('Failed to fetch selected language');
      }

      return LanguageListWithSelectedEntity(
          languageList: languageList,
          selectedLanguage: selectedLanguage
      );

    } catch (e) {
      print('Error fetching languages selected languages: $e');
      throw e;
    }
  }
}
