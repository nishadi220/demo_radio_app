import 'package:radio_super_app/services/dioClient.dart';
import '../models/podcast/responses/getCategoryListResponse.dart';
import '../models/podcast/responses/getFeaturedPodcastResponse.dart';
import '../models/podcast/responses/getPodcastEpisodeResponse.dart';
import '../models/podcast/responses/getPodcastsResponse.dart';
import '../models/podcast/responses/getTrendingPodcastListResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';

class PodcastService {
  final ApiService _apiService = ApiService(dioClient: DioClient());

  Future<GetTrendingPodcastListResponse> fetchTrendingPodcasts() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getTrendingPodcastList}");
      return GetTrendingPodcastListResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching trending podcasts: $e');
      return GetTrendingPodcastListResponse(podcasts: []);
    }
  }

  Future<GetPodcastResponse> fetchPodcast(String categoryId) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getPodcastListByCategoryId}?categoryId=$categoryId");
      return GetPodcastResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching playlists: $e');
      return GetPodcastResponse(podcasts: []);
    }
  }

  Future<GetCategoryGridResponse> fetchCategories() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getCategoryList}"); // Replace with the correct endpoint
      return GetCategoryGridResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching category grid: $e');
      return GetCategoryGridResponse(categories: []);
    }
  }

  Future<GetPodcastEpisodeResponse> fetchPodcastEpisodes({required String podcastId}) async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getContentByPodcastId}?podacstId=$podcastId");
      return GetPodcastEpisodeResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching podcast episodes: $e');
      return GetPodcastEpisodeResponse(episodes: []);
    }
  }

  Future<GetFeaturedPodcastResponse> fetchFeaturedPodcast() async {
    try {
      final response = await _apiService.getData("${ApiEndpoints.getFeaturedPodcasts}");
      return GetFeaturedPodcastResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching featured podcasts: $e');
      return GetFeaturedPodcastResponse(featuredPodcasts: []);
    }
  }
}
