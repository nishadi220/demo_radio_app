import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/Common/futureBuilderWidget.dart';
import '../../components/Favourites/favouriteListIcon.dart';
import '../../models/favourite/responses/getFavouriteResponse.dart';
import '../../router/appRoutes.dart';
import '../../services/favouriteService.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data
  final List<Map<String, String>> allFavoritesItems = [
    {"image": "https://i.imgur.com/YmPvyqi.png", "title": "Podcast A"},
    {"image": "https://i.imgur.com/8K3woTn.png", "title": "Podcast B"},
    {"image": "https://i.imgur.com/dF02Kf0.png", "title": "Playlist A"},
    {"image": "https://i.imgur.com/Q9tyOM2.png", "title": "Playlist B"},
    {"image": "https://i.imgur.com/YmPvyqi.png", "title": "Podcast C"},
  ];

  late List<Map<String, String>> podcastsFavoritesItems;
  late List<Map<String, String>> playlistsFavoritesItems;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // allFavoritesItems = List.from(allItems);

    podcastsFavoritesItems = allFavoritesItems
        .where((item) => item['title']!.toLowerCase().contains("podcast"))
        .toList();
    playlistsFavoritesItems = allFavoritesItems
        .where((item) => item['title']!.toLowerCase().contains("playlist"))
        .toList();
  }

  void removeItemFromAll(int index) {
    setState(() {
      allFavoritesItems.removeWhere((item) => item == allFavoritesItems[index]);
    });

    setState(() {
      podcastsFavoritesItems = allFavoritesItems
          .where((item) => item['title']!.toLowerCase().contains("podcast"))
          .toList();
      playlistsFavoritesItems = allFavoritesItems
          .where((item) => item['title']!.toLowerCase().contains("playlist"))
          .toList();
    });
  }

  void removeItemFromPodcast(int index) {

    // Get the item to be removed based on the index
    final itemToRemove = podcastsFavoritesItems[index];

    // Remove the item from the list
    setState(() {
      allFavoritesItems.remove(itemToRemove);
      podcastsFavoritesItems.removeWhere((item) => item == podcastsFavoritesItems[index]);
    });
  }

  void removeItemFromPlaylist(int index) {

    // Get the item to be removed based on the index
    final itemToRemove = playlistsFavoritesItems[index];

    setState(() {
      allFavoritesItems.remove(itemToRemove);
      playlistsFavoritesItems.removeWhere((item) => item == playlistsFavoritesItems[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favourites',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the desired color for the back arrow
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          isScrollable: true, // Allows tabs to scroll if content overflows
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Podcast Episodes'),
            Tab(text: 'Songs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFavouriteList(allFavoritesItems, removeItemFromAll),
          buildFavouriteList(podcastsFavoritesItems, removeItemFromPodcast),
          buildFavouriteList(playlistsFavoritesItems, removeItemFromPlaylist),
        ],
      ),
    );
  }

  Widget buildFavouriteList(
      List<Map<String, String>> favoritesItems, Function(int index) removeItem) {
    return Container(
      color: Colors.black, // Sets the background color to black
      child: FutureBuilderWidget<GetFavoriteListResponse>(
        future: FavoriteService().fetchFavorites(),
        onSuccess: (data) {
          // Filter data based on typeId
          final allFavorites = data.favorites;
          final podcasts = allFavorites
              .where((favourite) => favourite.type == 2)
              .toList();
          final playlists = allFavorites
              .where((favourite) => favourite.type == 1)
              .toList();
          final shows = allFavorites
              .where((favourite) => favourite.type == 3)
              .toList();

          final filteredFavorites = _tabController.index == 1
              ? podcasts
              : _tabController.index == 2
              ? playlists
              : allFavorites;

          return filteredFavorites.isEmpty
              ? const Center(child: Text(
                'No favourites found',
                style: TextStyle(color: Colors.white),
              ))
              : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredFavorites.length,
            itemBuilder: (context, index) {
              final favourite = filteredFavorites[index];
              return FavouriteListIcon(
                  imageUrl: favourite.pic,
                  title: favourite.name,
                  onRemove: () {
                    // Logic to handle item removal if needed
                  },
                  entity: favourite,
              );
            },
          );
        },
        onError: (error) {
          return const Center(
            child: Text('Failed to load favourites, please try again.'),
          );
        },
      ),
    );
  }


}
