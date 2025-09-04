import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/models/radio/entities/stationEntity.dart';
import 'package:radio_super_app/pages/Notification/notificationsScreen.dart';
import 'package:radio_super_app/pages/chats/chatLoginScreen.dart';
import 'package:radio_super_app/pages/chats/chatOtpScreen.dart';
import 'package:radio_super_app/pages/home/homeScreen.dart';
import 'package:radio_super_app/pages/Search/searchScreen.dart';
import 'package:radio_super_app/pages/mainScreen.dart';
import 'package:radio_super_app/pages/playlist/playlistCategoriesScreen.dart';
import 'package:radio_super_app/pages/playlist/playlistOpenScreen.dart';
import 'package:radio_super_app/pages/playlist/playlistScreen.dart';
import 'package:radio_super_app/pages/podcast/podcastCategoriesScreen.dart';
import 'package:radio_super_app/pages/podcast/podcastScreen.dart';
import 'package:radio_super_app/pages/radio/radioProgrammeScreen.dart';
import 'package:radio_super_app/pages/radio/radioScreen.dart';
import 'package:radio_super_app/pages/Settings/downloadQuality.dart';
import 'package:radio_super_app/pages/Settings/notificationSettings.dart';
import 'package:radio_super_app/pages/settings/settingsScreen.dart';
import 'package:radio_super_app/pages/splashScreen.dart';
import 'package:radio_super_app/router/appRoutes.dart';
import 'package:radio_super_app/router/wrappers/ChatScreenArgs.dart';
import '../models/playlist/entities/playlistsCategoryEntity.dart';
import '../models/podcast/entities/categoryGridEntity.dart';
import '../pages/Settings/languagePreferences.dart';
import '../pages/Settings/playbackQuality.dart';
import '../pages/chats/chatScreen.dart';
import '../pages/favourites/favouritesScreen.dart';
import '../pages/podcast/podcastEpisodeScreen.dart';
import '../pages/settings/privacyPolicyScreen.dart';
import '../pages/settings/termsAndConditions.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: null);
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen()
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainScreen(shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.homePage,
                  builder: (context, state) => const HomeScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.playlistOpen,
                      builder: (context, state) {
                        final data = state.extra as Map<String, dynamic>;
                        return PlaylistOpenScreen(data: data);
                      },
                    ),
                    GoRoute(
                      path: AppRoutes.podcastsOpen,
                      builder: (context, state) {
                        final data = state.extra as Map<String, dynamic>;
                        return PodcastEpisodeScreen(data: data);
                      },
                    ),
                  ]
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.radioPage,
                  builder: (context, state) => const RadioScreen(),
                  routes: [
                    // GoRoute(
                    //   path: AppRoutes.radioPlayer,
                    //   builder: (context, state) => const SuperRadioPlayer(),
                    // ),
                    GoRoute(
                      path: AppRoutes.radioProgramme,
                      builder: (context, state) => const RadioProgrammeScreen(),
                    )
                  ]
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.podcastPage,
                  builder: (context, state) => const PodcastScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.categories,
                      builder: (context, state) {
                          final podcastCategory = state.extra as CategoryEntity;
                          return PodcastCategoriesScreen(podcastCategory: podcastCategory);
                      }
                    ),
                    GoRoute(
                      path: AppRoutes.podcastsOpen,
                      builder: (context, state) {
                        // final playlistId = state.uri.queryParameters['playlistId'] ?? '';
                        // final podcastsId = state.extra as String;
                        // return PodcastEpisodeScreen(podcastsId: podcastsId);
                       
                        final data = state.extra as Map<String, dynamic>;
                        return PodcastEpisodeScreen(data: data);

                      },
                    ),
                    // GoRoute(
                    //   path: AppRoutes.podcastPlayer,
                    //   builder: (context, state) {
                    //     // final dummyPodcastEpisode = PodcastEpisodeEntity(
                    //     //   id: '12345',
                    //     //   name: 'The Art of Resilience',
                    //     //   description: 'A deep dive into building mental strength in challenging times.',
                    //     //   fileUrl: 'https://nadeo.azurewebsites.net/Images/INNA_Be_My_Lover_Official_Music_Video.mp3',
                    //     //   pic: 'https://nadeo.azurewebsites.net/Images/Music.jpg',
                    //     //   duration: '45:30',
                    //     //   languageId: 1,
                    //     //   loopId: 'loop123',
                    //     // );
                    //
                    //     final data = state.extra as PodcastEpisodeEntity; // Replace `ShowEntity` with the actual data type
                    //     // return const SuperPodCastPlayer(audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", title: "Tipsy Podcast");
                    //     // return const SuperPodCastPlayer(playerData: null,);
                    //
                    //     return SuperPodCastPlayer.forPodcast(
                    //       podcastPlayerData: data,
                    //     );
                    //   },
                    // ),
                  ]
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.playlistPage,
                  builder: (context, state) => const PlaylistScreen(),
                  routes: [
                    GoRoute(
                        path: AppRoutes.playlistCategories,
                        builder: (context, state) {
                            final category = state.extra as PlaylistsCategoryEntity;
                            return PlaylistCategoriesScreen(category: category);
                        }
                    ),
                    GoRoute(
                      path: AppRoutes.playlistOpen,
                      builder: (context, state) {

                        // final playlistId = state.uri.queryParameters['playlistId'] ?? '';
                        // final playlistId = state.extra as String;
                        // return PlaylistOpenScreen(playlistId: playlistId);

                        final data = state.extra as Map<String, dynamic>;
                        return PlaylistOpenScreen(data: data);
                      },
                    ),
                    // GoRoute(
                    //   path: AppRoutes.podcastPlayer,
                    //   builder: (context, state) {
                    //     final dummyPodcastEpisode = EpisodeEntity(
                    //       id: '12345',
                    //       playlistId: "001",
                    //       name: 'The Art of Resilience',
                    //       artists: "test artist",
                    //       composers: "test composer",
                    //       lyricists: "test lyricist",
                    //       // description: 'A deep dive into building mental strength in challenging times.',
                    //       fileUrl: 'https://nadeo.azurewebsites.net/Images/Music.jpg',
                    //       pic: 'https://nadeo.azurewebsites.net/Images/INNA_Be_My_Lover_Official_Music_Video.mp3',
                    //       duration: '45:30',
                    //       // languageId: 1,
                    //       // loopId: 'loop123',
                    //     );
                    //
                    //     // final show = state.extra as ShowEntity; // Replace `ShowEntity` with the actual data type
                    //     // return const SuperPodCastPlayer(audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", title: "Tipsy Podcast");
                    //     // return const SuperPodCastPlayer(playerData: null,);
                    //
                    //     return SuperPodCastPlayer.forPlaylist(
                    //       playlistPlayerData: dummyPodcastEpisode,
                    //     );
                    //   },
                    // ),
                  ]
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.settingsPage,
                  builder: (context, state) => const SettingsScreen(),
                  )
            ],
          ),
        ]),
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const SearchScreen()
    ),
    GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => NotificationsScreen()
    ),

    // Settings routes
    GoRoute(
        path: AppRoutes.languagePreferences,
        builder: (context, state) => const LanguagePreferencesScreen()
    ),
    GoRoute(
        path: AppRoutes.playbackQuality,
        builder: (context, state) => const PlaybackQualityScreen()
    ),
    GoRoute(
        path: AppRoutes.downloadQuality,
        builder: (context, state) => const DownloadQualityScreen()
    ),
    GoRoute(
        path: AppRoutes.notificationsSettings,
        builder: (context, state) => const NotificationSettingsScreen()
    ),
    GoRoute(
      path: AppRoutes.privacyPolicy,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.termsAndConditions,
      builder: (context, state) => const TermsAndConditionsScreen(),
    ),

    // Chat routes
    GoRoute(
        path: AppRoutes.chatLogin,
        builder: (context, state) {
          final chatScreenArgs = state.extra as ChatScreenArgs;
          return ChatLoginScreen(chatScreenArgs: chatScreenArgs);
        },
    ),
    GoRoute(
        path: AppRoutes.chatOtp,
        builder: (context, state) {
          final chatScreenArgs = state.extra as ChatScreenArgs;
          return ChatOTPScreen(chatScreenArgs: chatScreenArgs);
        }
    ),
    GoRoute(
        path: AppRoutes.chatScreen,
        builder: (context, state) {
          final chatScreenArgs = state.extra as ChatScreenArgs;
          return ChatScreen(chatScreenArgs: chatScreenArgs);
        }
    ),
    GoRoute(
      path: AppRoutes.favourites,
      builder: (context, state) => const FavouritesScreen(),
    ),
  ],
);
