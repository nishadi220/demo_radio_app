import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/models/podcast/entities/podcastEpisodeEntity.dart';
import 'package:radio_super_app/models/podcast/playerEpisodeEntity.dart';
import 'package:radio_super_app/providers/playerEpisodeProvider.dart';

import '../../configs/assets/appImages.dart';

class PodcastMiniPlayer extends StatelessWidget {
  final LinearGradient gradient;
  final bool isPlaying;
  final VoidCallback playOrStopCallback;

  const PodcastMiniPlayer({
    super.key,
    required this.gradient,
    required this.isPlaying,
    required this.playOrStopCallback,
  });

  @override
  Widget build(BuildContext context) {

    final podcastProvider = Provider.of<PlayerEpisodeProvider>(context);
    final currentPlayerEvent = podcastProvider.currentPlayerEvent;

    final podcastEpisode = currentPlayerEvent?.podcastEpisode;
    final songEpisode = currentPlayerEvent?.songEpisode;

    final currentPodcast;
    String playerDescription = "";
    if (currentPlayerEvent?.type == PlayerType.podcast) {
      currentPodcast = podcastEpisode;
      playerDescription = podcastEpisode?.description ?? "";
    } else {
      currentPodcast = songEpisode;
      playerDescription = songEpisode?.artists ?? "";
    }

    return Container(
      height: currentPodcast != null ? 80 : 0,
      decoration: BoxDecoration(
        color: Colors.red,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    currentPodcast?.pic ?? "", // Network URL
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
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentPodcast?.name ?? "",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    // currentPodcast?.description ?? ""
                    playerDescription,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: Icon(
                isPlaying ? Icons.pause  : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: playOrStopCallback,
            ),
          ],
        ),
      ),
    );
  }
}
