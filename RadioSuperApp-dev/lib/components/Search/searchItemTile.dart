import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/models/search/entities/searchEntity.dart';

import '../../models/playlist/entities/episodeEntity.dart';
import '../../models/podcast/entities/podcastEpisodeEntity.dart';
import '../../models/podcast/playerEpisodeEntity.dart';
import '../../pages/podcast/superPodcastPlayer.dart';
import '../../providers/playerEpisodeProvider.dart';

class SearchItemTile extends StatelessWidget {
  final SearchEntity entity;
  final String imagePath;
  final String? description;
  final String name;

  const SearchItemTile({
    Key? key,
    required this.imagePath,
    this.description,
    required this.name,
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
              pic: entity.picUrl,
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
            pic: entity.picUrl,
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

              // Navigate to the Podcast Player screen

            case 3:
              PlayerEpisodeEntity playerEntity = PlayerEpisodeEntity(
                  songEpisode: playlistEpisodeEntity,
                  type: PlayerType.song
              );

              Provider.of<PlayerEpisodeProvider>(context, listen: false)
                  .setCurrentPlayerEpisode(playerEntity);

            case 1: // Ignore radio shows
            default:
              return;
          }
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (description != null)
                  Text(
                    description!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[200]),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
