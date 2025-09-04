import 'package:flutter/material.dart';
import 'package:radio_super_app/models/podcast/playerEpisodeEntity.dart';

class PlayerEpisodeProvider extends ChangeNotifier {
  PlayerEpisodeEntity? _currentPlayerEpisode;

  PlayerEpisodeEntity? get currentPlayerEvent => _currentPlayerEpisode;

  void setCurrentPlayerEpisode(PlayerEpisodeEntity? payerEvent) {
    _currentPlayerEpisode = payerEvent;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}
