// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:radio_super_app/components/Favourites/favouriteListIcon.dart';
//
// import '../../components/Common/futureBuilderWidget.dart';
// import '../../models/favourite/responses/getFavouriteResponse.dart';
// import '../../router/appRoutes.dart';
// import '../../services/favouriteService.dart';
//
// class FavouritePodcastScreen extends StatelessWidget {
//   const FavouritePodcastScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF6C43AA),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF6C43AA), // Blue at 8%
//               Color(0xFFD55774), // Purple at 46%
//               Color(0xFFFF9B65), // Pink at 100%
//             ],
//             stops: [0.20, 0.60, 1.0],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 24.0, right: 16.0, top: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Favourite Podcasts',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Expanded(
//                 child: FutureBuilderWidget<GetFavoriteListResponse>(
//                   future: FavoriteService().fetchFavorites(),
//                   onSuccess: (data) {
//                     return data.favorites.isEmpty
//                         ? const Center(child: Text('No favourites found'))
//                         : ListView.builder(
//                       itemCount: data.favorites.length,
//                       itemBuilder: (context, index) {
//                         final favourite = data.favorites[index];
//                         return GestureDetector(
//                           onTap: () {
//                             // Navigate to the podcast player
//                             context.go('${AppRoutes.podcastPage}${AppRoutes.podcastPlayer}');
//                           },
//                           child: FavouriteListIcon(
//                             name: favourite.name,
//                             description: favourite.description ?? 'No description',
//                             pic: favourite.pic ?? '', // Adjust to API response
//                             duration: favourite.duration ?? '00:00:00',
//                             fileUrl: favourite.fileUrl ?? '',
//                             show: favourite.show ?? '',
//                             podcast: favourite.podcast,
//                           ),
//                         );
//                       },
//                     );
//
//                   },
//                   onError: (error) {
//                     return const Center(
//                       child: Text('Failed to load favourites, please try again.'),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
