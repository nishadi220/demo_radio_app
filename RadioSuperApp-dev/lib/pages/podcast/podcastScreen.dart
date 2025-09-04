import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/router/appRoutes.dart';
import 'package:radio_super_app/components/Common/futureBuilderWidget.dart';
import 'package:radio_super_app/services/podcastService.dart';
import 'package:radio_super_app/models/podcast/responses/getTrendingPodcastListResponse.dart';
import 'package:radio_super_app/components/Common/contentSlider.dart';
import 'package:radio_super_app/components/Podcast/podcastCategoryGrid.dart';
import '../../components/Common/contentCard.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: ListView(
            children: [
              const SizedBox(height: 10),
              // Trending Podcasts Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ContentSlider(
                  headerText: "Trending Podcasts",
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
                  'Podcasts Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              // Categories Grid Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PodcastCategoryGrid(),
              ),
            ],
        ),
    );
  }
}
