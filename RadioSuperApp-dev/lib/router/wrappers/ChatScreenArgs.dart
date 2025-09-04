import '../../models/radio/entities/stationEntity.dart';
import '../../models/radio/responses/getShowByStation.dart';

class ChatScreenArgs {
  final StationEntity stationEntity;
  final GetShowByStationResponse currentShow;

  ChatScreenArgs({required this.stationEntity, required this.currentShow});
}