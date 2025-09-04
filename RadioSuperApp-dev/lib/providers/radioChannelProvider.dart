import 'package:flutter/material.dart';
import 'package:radio_super_app/models/radio/entities/stationEntity.dart';

class RadioChannelProvider extends ChangeNotifier {
  StationEntity? _currentRadioChannel;

  StationEntity? get currentRadioChannel => _currentRadioChannel;

  void setCurrentRadioChannel(StationEntity? station) {
    _currentRadioChannel = station;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}