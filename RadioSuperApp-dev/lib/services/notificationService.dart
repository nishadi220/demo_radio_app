import '../managers/sharedPreferencesManager.dart';
import '../models/favourite/responses/getFavouriteResponse.dart';
import '../models/notification/responses/getNotificationListResponse.dart';
import 'apiEndpoints.dart';
import 'apiService.dart';
import 'dioClient.dart';

class NotificationService {
  final ApiService _apiService = ApiService(dioClient: DioClient());
  // final String userId = "GTest";


  Future<GetNotificationListResponse> fetchNotifications() async {
    try {
      final userId = await SharedPreferencesManager().getDeviceId();
      final response = await _apiService.getData("${ApiEndpoints.getNotificationByUserId}?userId=$userId");
      return GetNotificationListResponse.fromJson(response.data);

    } catch (e) {
      print('Error fetching favorites: $e');
      return GetNotificationListResponse(notifications: []);
    }
  }
}