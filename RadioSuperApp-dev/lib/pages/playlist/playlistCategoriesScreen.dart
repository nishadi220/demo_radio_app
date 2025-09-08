import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/Playlist/playlistItemCard.dart';
import '../../models/playlist/entities/playlistsCategoryEntity.dart';
import '../../models/playlist/responses/getPlayListResponse.dart';
import '../../router/appRoutes.dart';
import '../../services/playlistService.dart';
import '../../components/common/futureBuilderWidget.dart';

class PlaylistCategoriesScreen extends StatelessWidget {
  final PlaylistsCategoryEntity category;

  const PlaylistCategoriesScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Custom Back Button and Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  category.type, // playlist category name
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilderWidget<GetPlaylistResponse>(
                  future: PlaylistService().fetchPlaylists(category.id), // Adjust service method
                  onSuccess: (playlistData) {
                    return GridView.builder(
                      itemCount: playlistData.playlists.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final playlists = playlistData.playlists[index];
                        return PlaylistItemCard(
                          id: playlists.id,
                          name: playlists.name,
                          description: playlists.description,
                          picUrl: playlists.pic,
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


