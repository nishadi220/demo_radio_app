import 'package:flutter/material.dart';
import 'package:radio_super_app/components/Common/ContentSlider.dart';
import 'package:radio_super_app/models/playlist/responses/getFeaturedPlaylistResponse.dart';
import 'package:radio_super_app/models/podcast/responses/getFeaturedPodcastResponse.dart';
import 'package:radio_super_app/models/radio/responses/getShowListResponse.dart';
import 'package:radio_super_app/services/radioService.dart';
import '../../components/Common/contentCard.dart';
import '../../components/Common/futureBuilderWidget.dart';
import '../../components/Home/radioChannelCarousel.dart';
import '../../managers/sharedPreferencesManager.dart';
import '../../router/appRoutes.dart';
import '../../services/playlistService.dart';
import '../../services/podcastService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String? selectedStationId;
  String? favoriteStationId;

  GetFeaturedPodcastResponse? featuredPodcastData;
  GetFeaturedPlaylistResponse? featuredPlaylistData;
  bool isPodcastsLoading = true;
  bool isPlaylistsLoading = true;

  void _onStationChanged(String stationId) {
    setState(() {
      selectedStationId = stationId;
    });
  }

  @override
  void initState() {
    super.initState();

    SharedPreferencesManager().getFavoriteStationId().then((value) {
      setState(() {
        favoriteStationId = value;
      });
    });

    // Fetch Podcasts
    PodcastService().fetchFeaturedPodcast().then((data) {
      setState(() {
        featuredPodcastData = data;
        isPodcastsLoading = false;
      });
    }).catchError((_) {
      setState(() {
        isPodcastsLoading = false;
      });
    });

    // Fetch Playlists
    PlaylistService().fetchFeaturedPlaylists().then((data) {
      setState(() {
        featuredPlaylistData = data;
        isPlaylistsLoading = false;
      });
    }).catchError((_) {
      setState(() {
        isPlaylistsLoading = false;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // if (state == AppLifecycleState.resumed) {
    //   SharedPreferencesManager().getFavoriteStationId().then((value) {
    //     setState(() {
    //       favoriteStationId = value;
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1087AE), // Blue at 8%
            Color(0xFFFB7589), // Purple at 46%
            Color(0xFFF5C474), // Pink at 100%
          ],
          stops: [0.02, 0.45, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 225,
                    child: RadioChannelCarousel(
                        onStationChanged: _onStationChanged,
                        favoriteStationId: favoriteStationId
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      ContentSlider(
                        headerText: "Upcoming Shows",
                        futureWidgetBuilder: () =>
                            FutureBuilderWidget<GetShowListResponse>(
                              future: selectedStationId != null
                                  ? RadioService().fetchRadioShowsForStation(
                                  stationId: selectedStationId!,
                                  upcomming: true,
                              )
                                  : Future.value(
                                  GetShowListResponse(shows: [])),
                              onSuccess: (data) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.shows.length,
                                  itemBuilder: (context, index) {
                                    final show = data.shows[index];
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0),
                                        child: ContentCard(
                                          id: show.id,
                                          imagePath: show.picUrl,
                                          title: show.showName,
                                          description: show.description,
                                          startTime: show.startTime,
                                        ),
                                    );
                                  },
                                );
                              },
                              onError: (error) {
                                return const Center(
                                    child: Text('Failed to load shows.'));
                              },
                            ),
                      ),

                      // Featured Podcast Shows
                      ContentSlider(
                        headerText: "Featured Podcast Shows",
                        futureWidgetBuilder: () {
                          if (isPodcastsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (featuredPodcastData == null) {
                            return const Center(
                              child: Text('Failed to load podcasts.'),
                            );
                          }
                          final podcasts = featuredPodcastData!.featuredPodcasts;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: podcasts.length,
                            itemBuilder: (context, index) {
                              final podcast = podcasts[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ContentCard(
                                  id: podcast.podcastId,
                                  imagePath: podcast.picUrl,
                                  title: podcast.name,
                                  description: podcast.podcastDescription,
                                  routingPath: AppRoutes.homePage +
                                      AppRoutes.podcastsOpen,
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Featured Playlist Shows
                      ContentSlider(
                        headerText: "Featured Playlist Shows",
                        futureWidgetBuilder: () {
                          if (isPlaylistsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (featuredPlaylistData == null) {
                            return const Center(
                              child: Text('Failed to load playlists.'),
                            );
                          }
                          final playlists =
                              featuredPlaylistData!.featuredPlaylist;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: playlists.length,
                            itemBuilder: (context, index) {
                              final playlist = playlists[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ContentCard(
                                  id: playlist.playlistId,
                                  imagePath: playlist.picUrl,
                                  title: playlist.name,
                                  description: playlist.description,
                                  routingPath: AppRoutes.homePage +
                                      AppRoutes.playlistOpen,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
