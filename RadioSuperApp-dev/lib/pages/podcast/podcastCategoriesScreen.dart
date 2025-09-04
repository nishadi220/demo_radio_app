import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/Podcast/podcastItemCard.dart';
import '../../models/podcast/entities/categoryGridEntity.dart';
import '../../models/podcast/responses/getPodcastsResponse.dart';
import '../../router/appRoutes.dart';
import '../../components/common/futureBuilderWidget.dart';
import '../../services/podcastService.dart';

class PodcastCategoriesScreen extends StatelessWidget {
  final CategoryEntity podcastCategory;

  const PodcastCategoriesScreen({Key? key, required this.podcastCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Custom Back Button and Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  podcastCategory.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilderWidget<GetPodcastResponse>(
                  future: PodcastService().fetchPodcast(podcastCategory.id),
                  onSuccess: (podcastData) {
                    return GridView.builder(
                      itemCount: podcastData.podcasts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final podcast = podcastData.podcasts[index];
                        return PodcastItemCard(
                          id: podcast.id,
                          name: podcast.name,
                          description: podcast.description,
                          picUrl: podcast.picUrl,
                        );
                      },
                    );
                  },
                  onError: (error) {
                    return const Center(
                      child: Text('Failed to load data, please try again.'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


