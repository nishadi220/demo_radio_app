import 'package:flutter/cupertino.dart';

class StationProvider extends ChangeNotifier {
  String _selectedStationId = '';

  String get selectedStationId => _selectedStationId;

  void setSelectedStationId(String stationId) {
    _selectedStationId = stationId;
    notifyListeners(); // Notify widgets listening to this provider
  }
}