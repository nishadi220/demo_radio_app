import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/configs/assets/appImages.dart';
import 'package:radio_super_app/models/podcast/playerEpisodeEntity.dart';
import 'package:radio_super_app/providers/playerEpisodeProvider.dart';

import '../managers/sharedPreferencesManager.dart';
import '../models/favourite/requests/insertAndUpdateFavouriteRequest.dart';
import '../models/playlist/entities/episodeEntity.dart';
import '../models/podcast/entities/podcastEpisodeEntity.dart';
import '../models/radio/entities/showEntity.dart';
import '../router/appRoutes.dart';
import '../services/audioPlayerService.dart';
import '../services/favouriteService.dart';

class ProgrammeTile extends StatefulWidget {
  final dynamic entity;

  const ProgrammeTile({
    required this.entity,
  });

  @override
  _ProgrammeTileState createState() => _ProgrammeTileState();
}

class _ProgrammeTileState extends State<ProgrammeTile> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final FavoriteService _insertAndUpdateFavoriteService = FavoriteService();

  bool isDownloaded = false;
  bool isDownloading = false;
  bool isFavorited = false;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _checkDownloadStatus();
  }

  Future<void> _checkDownloadStatus() async {
    final downloaded = await _audioPlayerService.isPodcastDownloaded(widget.entity.id);
    setState(() {
      isDownloaded = downloaded;
    });
  }

  Future<void> _downloadPodcast() async {
    setState(() {
      _downloadProgress = 0.0; // Initialize progress
      isDownloading = true;
    });

    await _audioPlayerService.downloadPodcast(
      widget.entity.fileUrl,
      widget.entity.id,
      (received, total) {
        if (total > 0) {
          setState(() {
            _downloadProgress = (received / total);
          });
        }
      },
    );

    setState(() {
      isDownloading = false;
      _downloadProgress = 1.0; // Complete
      isDownloaded = true;
    });

    _checkDownloadStatus();
  }

  Future<void> toggleFavorite() async {
    // Additional actions (e.g., API call or log message)
    try {
      // Fetch userId and guestId concurrently
      final userIdFuture = SharedPreferencesManager().getUserId();
      final guestIdFuture = SharedPreferencesManager().getDeviceId();

      // Await both futures to complete
      final values = await Future.wait([userIdFuture, guestIdFuture]);
      final userId = values[0];
      final guestId = values[1];

      // Create the request object
      final insertAndUpdateFavouriteRequest = InsertAndUpdateFavouriteRequest(
        contentId: widget.entity.id, // Ensure this is not null
        userId: userId,
        guestId: guestId,
        active: !isFavorited,
      );

      // Call the service to insert or update favorite
      final response = await _insertAndUpdateFavoriteService.insertAndUpdateFavourite(
        InsertAndUpdateFavouriteRequest:insertAndUpdateFavouriteRequest ,
      );
          
      if (response != null) {
        setState(() {
          isFavorited = !isFavorited;
        });
      }

    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath;
    final String title;
    final String? description;

    if (widget.entity is PodcastEpisodeEntity) {
      imagePath = widget.entity.pic;
      title = widget.entity.name;
      description = widget.entity.description;

    } else if (widget.entity is EpisodeEntity) {
      imagePath = widget.entity.pic; // Replace with correct property for image
      title = widget.entity.name;
      description = widget.entity.artists; // Replace with correct property for description

    } else if (widget.entity is ShowEntity) {
      imagePath = widget.entity.picUrl;
      title = widget.entity.showName;
      description = widget.entity.description;

    } else {
      throw ArgumentError('Invalid data type. Must be ShowEntity, EpisodeEntity, or PodcastEpisodeEntity.');
    }

    void openPlayer() {
      if (widget.entity is PodcastEpisodeEntity) {
        PlayerEpisodeEntity playerEntity = PlayerEpisodeEntity(
          podcastEpisode: widget.entity,
          type: PlayerType.podcast,
        );
        Provider.of<PlayerEpisodeProvider>(context, listen: false).setCurrentPlayerEpisode(playerEntity);
      } else if (widget.entity is EpisodeEntity) {
        PlayerEpisodeEntity playerEntity = PlayerEpisodeEntity(
          songEpisode: widget.entity,
          type: PlayerType.song,
        );
        Provider.of<PlayerEpisodeProvider>(context, listen: false).setCurrentPlayerEpisode(playerEntity);
      } else if (widget.entity is ShowEntity) {
        context.go('${AppRoutes.radioPage}${AppRoutes.radioPlayer}', extra: widget.entity);
      }
    }

    return GestureDetector(
      onTap: openPlayer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
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
                      child:
                        Image.network(
                          imagePath, // Network URLs
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child; // If loaded, show image
                            return const CircularProgressIndicator(); // Show loader while loading
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.defaultImage, // Asset fallback image
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            );
                          },
                        )
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
                            description,
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
                      GestureDetector(
                        onTap: () {
                          if (!isDownloaded && !isDownloading) {
                            _downloadPodcast();
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: isDownloading
                              ? CircularProgressIndicator(
                              value: _downloadProgress,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
                            )
                            : Icon(
                              isDownloaded ? Icons.download_done : Icons.download,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      GestureDetector(
                        onTap: () => setState(() {
                          isFavorited = !isFavorited;
                        }),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                toggleFavorite();
                                print("Icon pressed");
                              },
                              child: Icon(
                                isFavorited ? Icons.favorite : Icons.favorite_border,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress Bar (if downloading)
            // if (isDownloading)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 8.0),
            //     child: LinearProgressIndicator(
            //       value: _downloadProgress,
            //       backgroundColor: Colors.grey,
            //       valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}