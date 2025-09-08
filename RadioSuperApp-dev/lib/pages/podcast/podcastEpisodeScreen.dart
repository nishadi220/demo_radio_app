import 'package:flutter/material.dart';
import 'package:radio_super_app/models/podcast/responses/getPodcastEpisodeResponse.dart';
import 'package:radio_super_app/services/podcastService.dart';
import '../../components/Common/futureBuilderWidget.dart';
import '../../components/programmeTile.dart';
import '../../components/RadioProgramme/currentPlayingWidget.dart';
import '../../services/audioPlayerService.dart';

class PodcastEpisodeScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const PodcastEpisodeScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = data['id'];
    final title = data['name'];
    final subtitle = data['description'];
    final imageUrl = data['picUrl'];

    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    final AudioPlayerService _audioPlayerService = AudioPlayerService();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7030A0), // Custom color
              Colors.black,      // Black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentPlayingWidget(
              screenWidth: MediaQuery.of(context).size.width,
              imagePath: imageUrl,
              stationName: title,
              statusText: subtitle,
              iconColor: Colors.white,
              borderRadius: BorderRadius.circular(12), // Custom border radius for the image
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Episode List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilderWidget<GetPodcastEpisodeResponse>(
                future: PodcastService().fetchPodcastEpisodes(podcastId: id),
                onSuccess: (episodeResponse) {
                  final episodes = episodeResponse.episodes;
                  return episodes.isEmpty
                      ? const Center(child: Text('No upcoming episodes'))
                      : ListView.builder(
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final episode = episodes[index];

                      return ProgrammeTile(
                          entity: episode,
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
    );
  }
}
