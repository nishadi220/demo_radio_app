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
        isRadioPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
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
    WidgetsBinding.instance.removeObserver(this);
    _radioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _radioPlayer.stop();
    }
  }

  // Radio Channel listener callback
  void _onRadioChannelChanged() {
    final radioProvider =
    Provider.of<RadioChannelProvider>(context, listen: false);

    if (radioProvider.currentRadioChannel != null) {
      Provider.of<PlayerEpisodeProvider>(context, listen: false)
          .setCurrentPlayerEpisode(null);

      changeChannel(radioProvider.currentRadioChannel);
    }
  }

  void changeChannel(StationEntity? radioChannel) {
    _radioPlayer.pause().then((value) {
      _setRadioChannel(radioChannel);
    });
  }

  void _setRadioChannel(StationEntity? radioChannel) {
    if (radioChannel == null) return;

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
      Provider.of<RadioChannelProvider>(context, listen: false)
          .setCurrentRadioChannel(null);

      final currentPlayerEvent = podcastProvider.currentPlayerEvent;
      final podcastEpisode = currentPlayerEvent?.podcastEpisode;
      final songEpisode = currentPlayerEvent?.songEpisode;

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
    if (fileUrl == null) return;

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
        await _audioPlayer.seek(duration);
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
        await _audioPlayer.seek(Duration.zero);
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
          AppMinimizer.minimizeApp();
        }
      },
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
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
              InkWell(
                onTap: () {
                  setState(() {
                    showSuperRadioPlayer = true;
                  });
                },
                child: RadioMiniPlayer(
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.black],
                  ),
                  playOrStopCallback: _playOrStopTapped,
                  isPlaying: isRadioPlaying,
                ),
              ),

              /// Mini podcast player
              InkWell(
                onTap: () {
                  setState(() {
                    showSuperPodcastPlayer = true;
                  });
                },
                child: PodcastMiniPlayer(
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.black],
                  ),
                  isPlaying: isPodcastPlaying,
                  playOrStopCallback: _podcastPlayOrStopTapped,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.black,
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, color: AppColors.iconColor),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.radio, color: AppColors.iconColor),
                  label: 'Radio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv, color: AppColors.iconColor), // New Live tab
                  label: 'Live',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.podcasts, color: AppColors.iconColor),
                  label: 'Podcast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.queue_music, color: AppColors.iconColor),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, color: AppColors.iconColor),
                  label: 'Settings',
                ),
              ],
              currentIndex: widget.navigationShell.currentIndex,
              onTap: _onItemTap,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: RadioTextStyles.bottomBarTextStyle,
              unselectedLabelStyle: RadioTextStyles.bottomBarTextStyle,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              elevation: 0,
              backgroundColor: Colors.black,
            ),
          ),

        ),

        /// Radio full screen player
        showSuperRadioPlayer
            ? Scaffold(
          appBar: PlayerAppBar(
            backgroundColor: Colors.black,
                () {
              setState(() {
                showSuperRadioPlayer = false;
              });
            },
                () {
              setState(() {
                showSuperRadioPlayer = false;
              });
              _radioPlayer.stop();
              Provider.of<RadioChannelProvider>(context, listen: false)
                  .setCurrentRadioChannel(null);
            },
          ),
          body: SuperRadioPlayer(
            radioPlayer: _radioPlayer,
            isPlaying: isRadioPlaying,
            onShowsButtonTapped: _onShowsButtonTapped,
            gradient:
            const LinearGradient(colors: [Colors.black, Colors.black]),
          ),
        )
            : Container(),

        /// Podcast full screen player
        showSuperPodcastPlayer
            ? Scaffold(
          appBar: PlayerAppBar(
            backgroundColor: Colors.black,
                () {
              setState(() {
                showSuperPodcastPlayer = false;
              });
            },
                () {
              setState(() {
                showSuperPodcastPlayer = false;
              });
              _audioPlayer.stop();
              Provider.of<PlayerEpisodeProvider>(context, listen: false)
                  .setCurrentPlayerEpisode(null);
            },
          ),
          body: SuperPodCastPlayer(
            audioPlayer: _audioPlayer,
            isPlaying: isPodcastPlaying,
            gradient:
            const LinearGradient(colors: [Colors.black, Colors.black]),
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
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
