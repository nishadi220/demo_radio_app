import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/appRoutes.dart';
import 'movie_player_screen.dart'; // Import the new screen file

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  static const List<Map<String, dynamic>> sections = [
    {
      "title": "Hot Movie Releases",
      "items": [
        {
          "title": "F1",
          "image": "https://image.tmdb.org/t/p/w185/9PXZIUsSDh4alB80jheWX4fhZmy.jpg",
          "isNetwork": true,
          "description": "A film exploring the thrilling and dramatic world of Formula 1 racing."
        },
        {
          "title": "The Conjuring: Last Rites",
          "image": "https://image.tmdb.org/t/p/w185/8XfIKOPmuCZLh5ooK13SPKeybWF.jpg",
          "isNetwork": true,
          "description": "An Eastern European tourist is trapped in an airport terminal after a political coup in his country."
        },
        {
          "title": "Highest 2 Lowest",
          "image": "https://image.tmdb.org/t/p/w185/kOzwIr0R7WhaFgoYUZFLPZA2RBZ.jpg",
          "isNetwork": true,
          "description": "A man's struggle to protect his family from an alien invasion."
        },
        {
          "title": "Superman",
          "image": "https://image.tmdb.org/t/p/w185/ombsmhYUqR4qqOLOxAyr5V8hbyv.jpg",
          "isNetwork": true,
          "description": "A man's struggle to protect his family from an alien invasion."
        },
      ]
    },
    {
      "title": "Hot TV Show Releases",
      "items": [
        {
          "title": "Stranger Things",
          "image": "https://image.tmdb.org/t/p/w185/uOOtwVbSr4QDjAGIifLDwpb2Pdl.jpg",
          "isNetwork": true,
          "description": "A low-level cabinet member becomes President of the United States after a catastrophic attack."
        },
        {
          "title": "Two Graves",
          "image": "https://image.tmdb.org/t/p/w185/bnERtXWzPaTRZfa0iEtvygiOrPP.jpg",
          "isNetwork": true,
          "description": "A high school chemistry teacher diagnosed with lung cancer turns to a life of crime."
        },
        {
          "title": "The Summer I Turned Pretty",
          "image": "https://image.tmdb.org/t/p/w185/xBIz53wYWsKfFpN0TaizVAjKJ0z.jpg",
          "isNetwork": true,
          "description": "After she dies, a woman is mistakenly sent to an idyllic afterlife and must hide her morally imperfect past."
        },
        {
          "title": "Peacemaker",
          "image": "https://image.tmdb.org/t/p/w185/yb4F1Oocq8GfQt6iIuAgYEBokhG.jpg",
          "isNetwork": true,
          "description": "After she dies, a woman is mistakenly sent to an idyllic afterlife and must hide her morally imperfect past."
        },
      ]
    },
    {
      "title": "Top Rated",
      "items": [
        {
          "title": "The Shawshank Redemption",
          "image": "https://image.tmdb.org/t/p/w185/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
          "isNetwork": true,
          "description": "A high school biology teacher becomes a mixed martial arts fighter to save his school's music program."
        },
        {
          "title": "Interstellar",
          "image": "https://image.tmdb.org/t/p/w185/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
          "isNetwork": true,
          "description": "Five childhood friends reunite after 30 years for a reunion."
        },
        {
          "title": "The Dark Knight",
          "image": "https://image.tmdb.org/t/p/w185/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
          "isNetwork": true,
          "description": "A grumpy widower's life changes when a lively young family moves in next door."
        },
        {
          "title": "The Lord of the Rings: The Return of the King",
          "image": "https://image.tmdb.org/t/p/w185/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
          "isNetwork": true,
          "description": "A placeholder movie to test network image loading."
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7030A0),
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              final items = section["items"] as List<dynamic>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section["title"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        items.length,
                            (i) {
                          final item = items[i];
                          final imageProvider = NetworkImage(item["image"]);

                          return GestureDetector(
                            onTap: () {
                              // Navigate to the new movie player screen
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => MoviePlayerScreen(movie: item as Map<String, dynamic>),
                              //   ),
                              // );

                              context.go(
                                '${AppRoutes.videoPage}/${AppRoutes.moviePlayer}',
                                extra: item,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[800],
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}