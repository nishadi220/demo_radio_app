import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/models/chat/entity/chatMessage.dart';
import 'package:radio_super_app/models/chat/requests/twoFactorRequest.dart';
import 'package:radio_super_app/models/chat/rsanLoginRequest.dart';

import '../models/chat/requests/insertChatRequest.dart';
import '../models/chat/requests/insertUserRequest.dart';
import '../models/chat/responses/GetChatsResponse.dart';
import '../models/login/requests/insertGuestRequest.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';
import 'dioClient.dart';

class ChatLoginService {
  final ApiService _apiService = ApiService(dioClient: DioClient());
  final String companyId = "COM001";
  final String userId = "USE001";

  Future<String?> insertGuest({required InsertGuestRequest insertGuestRequest}) async {
    try {
      final response = await _apiService.postData(
          ApiEndpoints.insertGuest,
          insertGuestRequest.toJson()
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Successfully logged In : ${response.data}');
        }
        // Login successful
        return response.data;
      } else {
        return null;
      }

    } catch (e) {
      if (kDebugMode) {
        print('Error fetching radio stations: $e');
      }
      return null;
      // return GetStationListResponse(stations: []);
    }
  }

  Future<String?> insertUser({required InsertUserRequest insertUserRequest}) async {
    try {
      final response = await _apiService.postData(
          ApiEndpoints.insertUser,
          insertUserRequest.toJson()
      );

      if (response.statusCode == 200) {
        // Login successful
        return response.data;
      } else {
        return null;
      }

    } catch (e) {
      print('Error fetching radio stations: $e');
      return null;
      // return GetStationListResponse(stations: []);
    }
  }

  Future<void> submitLoginData({required RsanLoginRequest userLoginRequest}) async {
    try {
      final response = await _apiService.postData(
          ApiEndpoints.rsanLogin,
          userLoginRequest.toJson()
      );

      if (response.statusCode == 200) {
        // Login successful
        print('Login successful');
      }

    } catch (e) {
      print('Error fetching radio stations: $e');
      // return GetStationListResponse(stations: []);
    }
  }

  Future<void> submitTwoFactorKey({required String twoFactorKey}) async {
    try {
      final twoFactorRequest = TwoFactorRequest(twoFactorKey: twoFactorKey, userId: userId);

      final response = await _apiService.postData(
          ApiEndpoints.insertTwoFactorDetail,
          twoFactorRequest.toJson()
      );

      if (response.statusCode == 200) {
        // Login successful
        print('Two factor detail added successfully.');
      }

    } catch (e) {
      print('Error fetching radio stations: $e');
      // return GetStationListResponse(stations: []);
    }
  }

  Future<void> insertChat({required InsertChatRequest chatRequest}) async {
    try {
      final response = await _apiService.postData(
          ApiEndpoints.insertChat,
          chatRequest.toJson()
      );

      if (response.statusCode == 200) {
        // Login successful
        print('Two factor detail added successfully.');
      }

    } catch (e) {
      print('Error fetching radio stations: $e');
      // return GetStationListResponse(stations: []);
    }
  }

  Future<List<ChatMessage>> getChatByShowId(String showId) async {
    try {
      final userId = await SharedPreferencesManager().getUserId();
      if (userId.isNotEmpty) {
        final response = await _apiService.getData("${ApiEndpoints.getChatByShowId}?userId=$userId&showId=$showId");
        print("Current shows : ${response.data}");

        // Parse the response as List<ChatMessage>
        if (response.data is List) {
          return (response.data as List)
              .map((json) => ChatMessage.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      }
      return [];
    } catch (e) {
      print('Error fetching chat messages: $e');
      return []; // Return an empty list on error
    }
  }

}