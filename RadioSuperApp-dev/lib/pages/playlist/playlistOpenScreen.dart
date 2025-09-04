import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/models/playlist/responses/getEpisodeListResponse.dart';
import 'package:radio_super_app/services/playlistService.dart';
import '../../components/Common/futureBuilderWidget.dart';
import '../../components/programmeTile.dart';
import '../../components/RadioProgramme/currentPlayingWidget.dart';
import '../../router/appRoutes.dart';

class PlaylistOpenScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlaylistOpenScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = data['id'];
    final title = data['name'];
    final subtitle = data['description'];
    final imageUrl = data['picUrl'];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7F57F6),
              Color(0xFFB87EAD),
              Color(0xFFF1BC99),
            ],
            stops: [0.0, 0.61, 1.0],
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
              borderRadius: BorderRadius.circular(12),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Song List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilderWidget<GetEpisodeListResponse>(
                future: PlaylistService().fetchPlaylistEpisodesForPlaylist(playlistId: id),
                onSuccess: (episodeResponse) {
                  final episodes = episodeResponse.episodes;
                  return episodes.isEmpty
                      ? const Center(child: Text('No upcoming songs'))
                      : ListView.builder(
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final episode = episodes[index];
                      return ProgrammeTile(
                        entity: episode,
                        // firstIcon: Icons.arrow_downward,
                        // secondIcon: Icons.play_arrow
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
