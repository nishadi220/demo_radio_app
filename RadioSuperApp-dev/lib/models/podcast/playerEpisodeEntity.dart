import 'package:radio_super_app/models/playlist/entities/episodeEntity.dart';
import 'package:radio_super_app/models/search/entities/searchEntity.dart';

import 'entities/podcastEpisodeEntity.dart';

enum PlayerType {
  podcast,
  song
}

class PlayerEpisodeEntity {
  final PodcastEpisodeEntity? podcastEpisode;
  final EpisodeEntity? songEpisode;
  final PlayerType type;

  PlayerEpisodeEntity({
    this.podcastEpisode,
    this.songEpisode,
    required this.type
  });

  // Static method to map SearchEntity to PlayerEpisodeEntity
  static PlayerEpisodeEntity? fromSearchEntity(SearchEntity entity) {
    switch (entity.type) {
      case 2: // Podcast
        return PlayerEpisodeEntity(
          podcastEpisode: PodcastEpisodeEntity.fromJson(entity.toJson()),
          type: PlayerType.podcast,
        );
      case 3: // Playlist (map to EpisodeEntity)
        return PlayerEpisodeEntity(
          songEpisode: EpisodeEntity.fromJson(entity.toJson()),
          type: PlayerType.song,
        );
      case 1: // Ignore radio shows
      default:
        return null;
    }
  }
}