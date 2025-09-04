import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/components/Playlist/playlistCategoryGrid.dart';
import 'package:radio_super_app/components/Common/futureBuilderWidget.dart';
import 'package:radio_super_app/services/podcastService.dart';
import 'package:radio_super_app/models/podcast/responses/getTrendingPodcastListResponse.dart';
import 'package:radio_super_app/components/Common/contentSlider.dart';
import '../../components/Common/contentCard.dart';
import '../../router/appRoutes.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7F57F6), // Blue at 8%
            Color(0xFFB87EAD), // Purple at 46%
            Color(0xFFF1BC99), // Pink at 100%
          ],
          stops: [0.10, 0.60, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          // Trending Podcasts Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ContentSlider(
              headerText: "Trending Playlists",
              futureWidgetBuilder: () => FutureBuilderWidget<GetTrendingPodcastListResponse>(
                future: PodcastService().fetchTrendingPodcasts(),
                onSuccess: (data) {
                  final podcasts = data.podcasts;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: podcasts.length,
                    itemBuilder: (context, index) {
                      final podcast = podcasts[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ContentCard(
                          id: podcast.id,
                          imagePath: podcast.picUrl,
                          title: podcast.name,
                          description: podcast.description,
                          routingPath: AppRoutes.playlistPage + AppRoutes.playlistOpen,
                        ),
                      );
                    },
                  );
                },
                onError: (error) {
                  return const Center(
                    child: Text('Failed to load podcasts.'),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Playlists Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          // Categories Grid Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PlaylistCategoryGrid(),
          ),
        ],
      ),
    );
  }
}
