import 'dart:convert';
import 'package:radio_super_app/models/playlist/entities/playlistEntity.dart';
import 'package:radio_super_app/models/playlist/responses/getEpisodeListResponse.dart';
import 'package:radio_super_app/models/playlist/responses/getFeaturedPlaylistResponse.dart';
import 'package:radio_super_app/services/dioClient.dart';
import '../models/playlist/responses/getPlayListResponse.dart';
import '../models/playlist/responses/getPlaylistsCategoryListResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class PlaylistService {
  final ApiService _apiService = ApiService(dioClient: DioClient());

  Future<GetPlaylistResponse> fetchPlaylists(String categoryId) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getPlaylistByCategoryId}?categoryId=$categoryId");
      return GetPlaylistResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching playlists: $e');
      return GetPlaylistResponse(playlists: []);
    }
  }

  Future<GetPlaylistsCategoryGridResponse> fetchCategories() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getPlaylistCategoryList}"); // Replace with the correct endpoint
      return GetPlaylistsCategoryGridResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching playlists category grid: $e');
      return GetPlaylistsCategoryGridResponse(categories: []);
    }
  }

  Future<GetEpisodeListResponse> fetchPlaylistEpisodesForPlaylist({required String playlistId}) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getPlaylistContent}?playlistId=$playlistId");
      return GetEpisodeListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching playlist Episodes: $e');
      return GetEpisodeListResponse(episodes: []);
    }
  }

  Future<GetFeaturedPlaylistResponse> fetchFeaturedPlaylists() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getFeaturedPlaylist}");
      return GetFeaturedPlaylistResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching featured playlists: $e');
      return GetFeaturedPlaylistResponse(featuredPlaylist: []);
    }
  }
}
