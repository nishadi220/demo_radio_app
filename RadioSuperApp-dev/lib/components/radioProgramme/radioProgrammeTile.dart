import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/models/podcast/playerEpisodeEntity.dart';
import 'package:radio_super_app/models/search/entities/searchEntity.dart';
import 'package:radio_super_app/providers/playerEpisodeProvider.dart';

import '../../models/playlist/entities/episodeEntity.dart';
import '../../models/podcast/entities/podcastEpisodeEntity.dart';
import '../../models/radio/entities/showEntity.dart';
import '../../router/appRoutes.dart';



class RadioProgrammeTile extends StatefulWidget {
  final dynamic entity;

  const RadioProgrammeTile({
    required this.entity,
  });

  @override
  _RadioProgrammeTileState createState() => _RadioProgrammeTileState();
}

class _RadioProgrammeTileState extends State<RadioProgrammeTile> {
  bool isFavorited = false;
  bool isDownloaded = false;

  @override
  Widget build(BuildContext context) {
    final String imagePath;
    final String title;
    final String? description;

    if (widget.entity is ShowEntity) {
      imagePath = widget.entity.picUrl;
      title = widget.entity.showName;
      description = widget.entity.description;
    } else {
      throw ArgumentError('Invalid data type. Must be ShowEntity, EpisodeEntity, or PodcastEpisodeEntity.');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null)
                      Text(
                        description!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            Row(
              children: [
                Container(
                    width: 40,
                    height: 40,
                  ),
                const SizedBox(width: 10),
                Container(
                    width: 40,
                    height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}