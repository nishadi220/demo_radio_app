import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:radio_super_app/components/main/bottomBarItem.dart';
import 'package:radio_super_app/components/main/playerAppBar.dart';
import 'package:radio_super_app/components/main/podcastMiniPlayer.dart';
import 'package:radio_super_app/components/main/radioMiniPlayer.dart';
import 'package:radio_super_app/models/radio/entities/stationEntity.dart';
import 'package:radio_super_app/pages/podcast/superPodcastPlayer.dart';
import 'package:radio_super_app/pages/radio/superRadioPlayer.dart';
import 'package:radio_super_app/router/appRoutes.dart';
import 'package:radio_super_app/utils/AppMinimizer.dart';
import '../configs/theme/appColors.dart';
import '../models/podcast/playerEpisodeEntity.dart';
import '../providers/playerEpisodeProvider.dart';
import '../providers/radioChannelProvider.dart';
import '../services/audioPlayerService.dart';
import '../styles/radioTextStyles.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final List<LinearGradient> gradients = [
    const LinearGradient(
        colors: [Color(0xFF1087AE), Color(0xFF1087AE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    const LinearGradient(
        colors: [Color(0xFFD5576E), Color(0xFFD5576E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    const LinearGradient(
        colors: [Color(0xFF4360AA), Color(0xFF4360AA)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    const LinearGradient(
        colors: [Color(0xFF7F57F6), Color(0xFF7F57F6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    const LinearGradient(
        colors: [Colors.black, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  ];

  static const LinearGradient gradientHome = LinearGradient(
      colors: [Color(0xFF1087AE), Color(0xFF1087AE)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient gradientRadio = LinearGradient(
      colors: [Color(0xFFD5576E), Color(0xFFD5576E)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient gradientPodcast = LinearGradient(
      colors: [Color(0xFF4360AA), Color(0xFF4360AA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient gradientPlaylist = LinearGradient(
      colors: [Color(0xFF7F57F6), Color(0xFF7F57F6)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient gradientSettings = LinearGradient(
      colors: [Colors.black, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  final Map<String, LinearGradient> gradientMap = {
    // home page
    AppRoutes.homePage: gradientHome,
    AppRoutes.homePage + AppRoutes.podcastsOpen: gradientPodcast,
    AppRoutes.homePage + AppRoutes.playlistOpen: gradientPlaylist,

    // radio page
    AppRoutes.radioPage: gradientRadio,
    AppRoutes.radioPage + AppRoutes.radioPlayer: gradientRadio,
    AppRoutes.radioPage + AppRoutes.radioProgramme: gradientRadio,

    // podcast page
    AppRoutes.podcastPage: gradientPodcast,
    AppRoutes.podcastPage + AppRoutes.categories: gradientPodcast,
    AppRoutes.podcastPage + AppRoutes.podcastsOpen: gradientPodcast,
    AppRoutes.podcastPage + AppRoutes.podcastPlayer: gradientPodcast,

    // playlist page
    AppRoutes.playlistPage: gradientPlaylist,
    AppRoutes.playlistPage + AppRoutes.playlistCategories: gradientPlaylist,
    AppRoutes.playlistPage + AppRoutes.playlistOpen: gradientPlaylist,
    AppRoutes.settingsPage + AppRoutes.podcastPlayer: gradientPlaylist,

    // settings page
    AppRoutes.settingsPage: gradientSettings,
  };

  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isRadioPlaying = false;
  List<String>? metadata;

  late StationEntity? _currentRadioChannel;

  bool showSuperRadioPlayer = false;
  bool showSuperPodcastPlayer = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  late Stream<Duration?> _positionStream;
  late Stream<Duration?> _bufferedPositionStream;

  bool isPodcastPlaying = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<RadioChannelProvider>(context, listen: false)
          .addListener(_onRadioChannelChanged);
    });

    Future.microtask(() {
      Provider.of<PlayerEpisodeProvider>(context, listen: false)
          .addListener(_onPodcastEpisodeChanged);
    });

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        print("Radio Stream value : $value");
        isRadioPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      print("Radio Stream Meta value : $value");
      setState(() {
        metadata = value;
      });
    });

    _positionStream = _audioPlayer.positionStream;
    _bufferedPositionStream = _audioPlayer.bufferedPositionStream;

    _audioPlayer.playingStream.listen((playing) {
      setState(() {
        isPodcastPlaying = playing;
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove listener to avoid memory leaks
    // Provider.of<RadioChannelProvider>(context, listen: false)
    //     .removeListener(_onRadioChannelChanged);

    WidgetsBinding.instance.removeObserver(this);
    _radioPlayer.stop(); // Stop the player
    // _radioPlayer.clearNotification(); // Remove notification widget

    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _radioPlayer.stop(); // Stop the player when app is being killed
      // _radioPlayer.clearNotification(); // Clear the notification widget
    }
  }

  // Radio Channel listener callback
  void _onRadioChannelChanged() {
    final radioProvider =
        Provider.of<RadioChannelProvider>(context, listen: false);

    if (radioProvider.currentRadioChannel != null) {
      // Hide or stop any playing podcast or song
      Provider.of<PlayerEpisodeProvider>(context, listen: false)
          .setCurrentPlayerEpisode(null);

      changeChannel(radioProvider.currentRadioChannel);
    }
  }

  void changeChannel(StationEntity? radioChannel) {
    // _currentRadioChannel = radioChannel;
    _radioPlayer.pause().then((value) {
      _setRadioChannel(radioChannel);
    });
  }

  void _setRadioChannel(StationEntity? radioChannel) {
    if (radioChannel == null) {
      return;
    }

    _radioPlayer
        .setChannel(
            title: radioChannel.name,
            url: radioChannel.contentUrl,
            imagePath: radioChannel.picUrl)
        .then((value) {
      _radioPlayer.play();
    });
  }

  // Podcast episode listener callback
  void _onPodcastEpisodeChanged() {
    final podcastProvider =
        Provider.of<PlayerEpisodeProvider>(context, listen: false);

    if (podcastProvider.currentPlayerEvent != null) {
      // Hide or radio channel
      Provider.of<RadioChannelProvider>(context, listen: false)
          .setCurrentRadioChannel(null);

      final currentPlayerEvent = podcastProvider.currentPlayerEvent;

      final podcastEpisode = currentPlayerEvent?.podcastEpisode;
      final songEpisode = currentPlayerEvent?.songEpisode;

      // Check player event type and parse the file url
      if (currentPlayerEvent?.type == PlayerType.podcast) {
        changePodcastEpisode(podcastEpisode?.fileUrl);
      } else {
        changePodcastEpisode(songEpisode?.fileUrl);
      }
    }
  }

  void changePodcastEpisode(String? fileUrl) {
    _audioPlayer.pause().then((value) {
      _setPodcastEpisode(fileUrl);
    });
  }

  void _setPodcastEpisode(String? fileUrl) {
    if (fileUrl == null) {
      return;
    }

    try {
      _audioPlayer.setUrl(fileUrl).then((value) {
        _audioPlayer.play();
      });
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  void _seekForward() async {
    final currentPosition = _audioPlayer.position;
    final duration = _audioPlayer.duration;

    if (currentPosition != null && duration != null) {
      final newPosition = currentPosition + const Duration(seconds: 10);

      if (newPosition < duration) {
        await _audioPlayer.seek(newPosition);
      } else {
        await _audioPlayer
            .seek(duration); // Seek to the end if exceeding duration
      }
    }
  }

  void _seekBackward() async {
    final currentPosition = _audioPlayer.position;

    if (currentPosition != null) {
      final newPosition = currentPosition - const Duration(seconds: 10);
      if (newPosition > Duration.zero) {
        await _audioPlayer.seek(newPosition);
      } else {
        await _audioPlayer
            .seek(Duration.zero); // Seek to the beginning if negative
      }
    }
  }

  void _podcastPlayOrStopTapped() {
    setState(() {
      isPodcastPlaying ? _audioPlayer.stop() : _audioPlayer.play();
    });
  }

  void _onShowsButtonTapped() {
    hideSuperRadioPlayer();
    // Navigate to radio programme screen
    GoRouter.of(context).push(AppRoutes.radioPage + AppRoutes.radioProgramme);
  }

  void hideSuperRadioPlayer() {
    setState(() {
      showSuperRadioPlayer = false;
    });
  }

  void _playOrStopTapped() {
    setState(() {
      isRadioPlaying ? _radioPlayer.stop() : _radioPlayer.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (position, result) async {
        if (Platform.isAndroid) {
          // SystemNavigator.pop();
          AppMinimizer.minimizeApp();
        }
      },
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradientMap[widget
                    .navigationShell.shellRouteContext.routerState.fullPath],
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              const BottomBarItem(
                  appRoute: AppRoutes.search, icon: Icons.search),
              const BottomBarItem(
                  appRoute: AppRoutes.notifications, icon: Icons.notifications),
              IconButton(
                onPressed: () {
                  context.push(AppRoutes.favourites);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(child: widget.navigationShell),

              /// Mini radio player
              /// Self height adjusting tab
              InkWell(
                onTap: () {
                  setState(() {
                    // Show full screen player
                    showSuperRadioPlayer = true;
                  });
                },
                child: RadioMiniPlayer(
                  gradient: gradients[widget.navigationShell.currentIndex],
                  playOrStopCallback: _playOrStopTapped,
                  isPlaying: isRadioPlaying,
                ),
              ),

              /// Mini podcast player
              /// Self height adjusting tab
              InkWell(
                onTap: () {
                  setState(() {
                    // Show full screen player podcast or song
                    showSuperPodcastPlayer = true;
                  });
                },
                child: PodcastMiniPlayer(
                  gradient: gradients[widget.navigationShell.currentIndex],
                  isPlaying: isPodcastPlaying,
                  playOrStopCallback: _podcastPlayOrStopTapped,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            // Add vertical padding
            color: Colors.white,
            // Set background color for the padding
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    color: AppColors.iconColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.radio,
                    color: AppColors.iconColor,
                  ),
                  label: 'Radio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.podcasts,
                    color: AppColors.iconColor,
                  ),
                  label: 'Podcast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.queue_music,
                    color: AppColors.iconColor,
                  ),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: AppColors.iconColor,
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: widget.navigationShell.currentIndex,
              onTap: _onItemTap,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: RadioTextStyles.bottomBarTextStyle,
              unselectedLabelStyle: RadioTextStyles.bottomBarTextStyle,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
          ),
        ),

        /// Radio full screen player
        showSuperRadioPlayer
            ? Scaffold(
                appBar: PlayerAppBar(backgroundColor: const Color(0xFFD5576E),
                    // Handle OnMinimizeCallback
                    () {
                  setState(() {
                    showSuperRadioPlayer = false;
                  });
                },
                    // Handle OnClosedCallback
                    () {
                  setState(() {
                    showSuperRadioPlayer = false;
                  });
                  _radioPlayer.stop();
                  Provider.of<RadioChannelProvider>(context, listen: false)
                      .setCurrentRadioChannel(null);
                }),
                body: SuperRadioPlayer(
                  radioPlayer: _radioPlayer,
                  isPlaying: isRadioPlaying,
                  onShowsButtonTapped: _onShowsButtonTapped,
                  gradient: gradients[widget.navigationShell.currentIndex],
                ))
            : Container(),

        /// Podcast full screen player
        showSuperPodcastPlayer
            ? Scaffold(
                appBar: PlayerAppBar(backgroundColor: const Color(0xFF4360AA),
                    // Handle minimize player
                    () {
                  setState(() {
                    showSuperPodcastPlayer = false;
                  });
                },
                    // Handle player closed
                    () {
                  setState(() {
                    showSuperPodcastPlayer = false;
                  });
                  _audioPlayer.stop();
                  Provider.of<PlayerEpisodeProvider>(context, listen: false)
                      .setCurrentPlayerEpisode(null);
                }),
                body: SuperPodCastPlayer(
                  audioPlayer: _audioPlayer,
                  isPlaying: isPodcastPlaying,
                  gradient: gradients[widget.navigationShell.currentIndex],
                  seekBackwardCallback: _seekBackward,
                  seekForwardCallback: _seekForward,
                  positionStream: _positionStream,
                ),
              )
            : Container(),
      ]),
    );
  }

  void _onItemTap(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}
