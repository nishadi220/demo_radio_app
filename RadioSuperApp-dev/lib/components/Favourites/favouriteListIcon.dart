import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/models/favourite/entities/favouriteEntity.dart';

import '../../models/playlist/entities/episodeEntity.dart';
import '../../models/podcast/entities/podcastEpisodeEntity.dart';
import '../../models/podcast/playerEpisodeEntity.dart';
import '../../providers/playerEpisodeProvider.dart';

class FavouriteListIcon extends StatelessWidget {
  final FavoriteEntity entity;
  final String imageUrl;
  final String title;
  final VoidCallback onRemove;

  const FavouriteListIcon({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onRemove,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final podcastEpisodeEntity = PodcastEpisodeEntity(
          id: entity.id,
          name: entity.name,
          description: entity.description ?? "",
          pic: entity.pic,
          duration: entity.duration,
          fileUrl: entity.fileUrl,
        );

        final playlistEpisodeEntity = EpisodeEntity(
          id: entity.id,
          playlistId: '',
          name: entity.name,
          artists: entity.description ?? "",
          composers: "",
          lyricists: "",
          pic: entity.pic,
          duration: entity.duration,
          fileUrl: entity.fileUrl,
        );

        switch (entity.type) {
          case 2: // Podcast
            PlayerEpisodeEntity playerEntity = PlayerEpisodeEntity(
                podcastEpisode: podcastEpisodeEntity,
                type: PlayerType.podcast
            );
            Provider.of<PlayerEpisodeProvider>(context, listen: false)
                .setCurrentPlayerEpisode(playerEntity);

          case 3: // Song
            PlayerEpisodeEntity playerEntity = PlayerEpisodeEntity(
                songEpisode: playlistEpisodeEntity,
                type: PlayerType.song
            );

            Provider.of<PlayerEpisodeProvider>(context, listen: false)
                .setCurrentPlayerEpisode(playerEntity);
            break;

          case 1: // Ignore radio shows
          default:
            return;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 68, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(width: 16),
            // Text Information
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
