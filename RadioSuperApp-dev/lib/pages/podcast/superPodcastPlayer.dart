import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_super_app/configs/assets/appVectors.dart';

import '../../configs/assets/appImages.dart';
import '../../models/podcast/playerEpisodeEntity.dart';
import '../../providers/playerEpisodeProvider.dart';

class SuperPodCastPlayer extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final bool isPlaying;
  final VoidCallback seekForwardCallback;
  final VoidCallback seekBackwardCallback;
  final LinearGradient gradient;
  final Stream<Duration?> positionStream;

  // Private constructor
  const SuperPodCastPlayer({
    super.key,
    required this.audioPlayer,
    required this.isPlaying,
    required this.gradient,
    required this.seekBackwardCallback,
    required this.seekForwardCallback,
    required this.positionStream,
  });

  @override
  State<SuperPodCastPlayer> createState() => _SuperPodCastPlayerState();
}

class _SuperPodCastPlayerState extends State<SuperPodCastPlayer> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4360AA), // Blue at 8%
            Color(0xFF91B7F6), // Purple at 46%
            Color(0xFF908DF3), // Pink at 100%
          ],
          stops: [0.10, 0.60, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              width: screenWidth * 0.75,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  currentPodcast.pic, // Network URL
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
            const SizedBox(height: 16),
            Text(
              currentPodcast?.name ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              playerDescription,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO : GO TO PREVIOUS PODCAST
                    },
                    icon: SvgPicture.asset(AppVectors.previousIcon,
                        width: 30),
                  ),
                  IconButton(
                    onPressed: widget.seekBackwardCallback,
                    icon: SvgPicture.asset(
                        AppVectors.backwardTenSecondsIcon,
                        width: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.isPlaying ? widget.audioPlayer.stop() : widget.audioPlayer.play();
                    },
                    icon: Icon(
                      widget.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.seekForwardCallback,
                    icon: SvgPicture.asset(AppVectors.forwardTenSecondsIcon,
                        width: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO : GO TO NEXT PODCAST
                    },
                    icon: SvgPicture.asset(AppVectors.nextIcon, width: 30),
                  ),
                ],
              ),
            ),
            StreamBuilder<Duration?>(
              stream: widget.positionStream,
              builder: (context, snapshot) {
                final duration = snapshot.data;
                return Slider(
                  value: duration?.inSeconds.toDouble() ?? 0,
                  min: 0,
                  max: widget.audioPlayer.duration?.inSeconds.toDouble() ?? 1,
                  onChanged: (value) {
                    widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Handle like action
                    debugPrint("Liked podcast");
                  },
                  icon: const Icon(Icons.thumb_up, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Handle dislike action
                    debugPrint("Disliked podcast");
                  },
                  icon: const Icon(Icons.thumb_down, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
