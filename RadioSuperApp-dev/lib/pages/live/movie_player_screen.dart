import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:radio_super_app/router/appRoutes.dart'; // Import appRoutes

class MoviePlayerScreen extends StatefulWidget {
  final Map<String, dynamic> movie;
  final String? videoUrl; // Add videoUrl parameter

  const MoviePlayerScreen({super.key, required this.movie, this.videoUrl});

  @override
  State<MoviePlayerScreen> createState() => _MoviePlayerScreenState();
}

class _MoviePlayerScreenState extends State<MoviePlayerScreen> {
  late VideoPlayerController _controller;

  static const List<Map<String, dynamic>> sections = [
    {
      "title": "Hot Movie Releases",
      "type": "movie",
      "items": [
        {
          "title": "The Conjuring: Last Rites",
          "image": "https://image.tmdb.org/t/p/w185/8XfIKOPmuCZLh5ooK13SPKeybWF.jpg",
          "isNetwork": true,
          "description": "An Eastern European tourist is trapped in an airport terminal after a political coup in his country.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        },
        {
          "title": "Highest 2 Lowest",
          "image": "https://image.tmdb.org/t/p/w185/kOzwIr0R7WhaFgoYUZFLPZA2RBZ.jpg",
          "isNetwork": true,
          "description": "A man's struggle to protect his family from an alien invasion.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
        },
        {
          "title": "Superman",
          "image": "https://image.tmdb.org/t/p/w185/ombsmhYUqR4qqOLOxAyr5V8hbyv.jpg",
          "isNetwork": true,
          "description": "A man's struggle to protect his family from an alien invasion.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
        },
      ]
    },
    {
      "title": "Hot TV Show Releases",
      "type": "tv_show",
      "items": [
        {
          "title": "Stranger Things",
          "image": "https://image.tmdb.org/t/p/w185/uOOtwVbSr4QDjAGIifLDwpb2Pdl.jpg",
          "isNetwork": true,
          "description": "A low-level cabinet member becomes President of the United States after a catastrophic attack.",
          "episodes": [
            { "title": "Episode 1: The Vanishing of Will Byers", "description": "The pilot episode of Stranger Things.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" },
            { "title": "Episode 2: The Weirdo on Maple Street", "description": "The strange girl is found.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" },
            { "title": "Episode 3: Holly, Jolly", "description": "The search for Will continues.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4" },
          ]
        },
        {
          "title": "Two Graves",
          "image": "https://image.tmdb.org/t/p/w185/bnERtXWzPaTRZfa0iEtvygiOrPP.jpg",
          "isNetwork": true,
          "description": "A high school chemistry teacher diagnosed with lung cancer turns to a life of crime.",
          "episodes": [
            { "title": "Episode 1: Pilot", "description": "Breaking Bad pilot episode.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4" },
            { "title": "Episode 2: Cat's in the Bag...", "description": "Dealing with the aftermath.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4" },
          ]
        },
        {
          "title": "The Summer I Turned Pretty",
          "image": "https://image.tmdb.org/t/p/w185/bnERtXWzPaTRZfa0iEtvygiOrPP.jpg",
          "isNetwork": true,
          "description": "A high school chemistry teacher diagnosed with lung cancer turns to a life of crime.",
          "episodes": [
            { "title": "Episode 1: Pilot", "description": "Breaking Bad pilot episode.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" },
            { "title": "Episode 2: Cat's in the Bag...", "description": "Dealing with the aftermath.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" },
          ]
        },
        {
          "title": "PeaceMaker",
          "image": "https://image.tmdb.org/t/p/w185/bnERtXWzPaTRZfa0iEtvygiOrPP.jpg",
          "isNetwork": true,
          "description": "A high school chemistry teacher diagnosed with lung cancer turns to a life of crime.",
          "episodes": [
            { "title": "Episode 1: Pilot", "description": "Breaking Bad pilot episode.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4" },
            { "title": "Episode 2: Cat's in the Bag...", "description": "Dealing with the aftermath.", "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4" },
          ]
        },
      ]
    },
    {
      "title": "Top Rated",
      "type": "movie",
      "items": [
        {
          "title": "The Shawshank Redemption",
          "image": "https://image.tmdb.org/t/p/w185/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
          "isNetwork": true,
          "description": "A high school biology teacher becomes a mixed martial arts fighter to save his school's music program.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
        },
        {
          "title": "Interstellar",
          "image": "https://image.tmdb.org/t/p/w185/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
          "isNetwork": true,
          "description": "Five childhood friends reunite after 30 years for a reunion.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        },
        {
          "title": "The Dark Knight",
          "image": "https://image.tmdb.org/t/p/w185/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
          "isNetwork": true,
          "description": "A grumpy widower's life changes when a lively young family moves in next door.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        },
        {
          "title": "The Lord of the Rings: The Return of the King",
          "image": "https://image.tmdb.org/t/p/w185/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
          "isNetwork": true,
          "description": "A placeholder movie to test network image loading.",
          "videoUrl": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
        },
      ]
    },
  ];

  List<Map<String, dynamic>> getRelatedMovies() {
    List<Map<String, dynamic>> allMovies = [];
    for (var section in sections) {
      if (section["type"] == "movie") {
        allMovies.addAll(List<Map<String, dynamic>>.from(section["items"]));
      }
    }
    return allMovies
        .where((movie) => movie["title"] != widget.movie["title"])
        .toList();
  }

  // Find the list of episodes for the current TV show
  List<Map<String, dynamic>> getEpisodes() {
    for (var section in sections) {
      if (section["type"] == "tv_show") {
        for (var tvShow in section["items"]) {
          if (tvShow["title"] == widget.movie["title"]) {
            return List<Map<String, dynamic>>.from(tvShow["episodes"]);
          }
        }
      }
    }
    return []; // Return an empty list if no episodes are found
  }

  void _initializeVideoPlayer() {
    final videoUrl = widget.videoUrl ?? 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(MoviePlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.movie["title"] != oldWidget.movie["title"]) {
      _controller.dispose();
      _initializeVideoPlayer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTvShow = false;
    // Find the section type for the current movie/show
    for (var section in sections) {
      for (var item in section["items"]) {
        if (item["title"] == widget.movie["title"]) {
          isTvShow = (section["type"] == "tv_show");
          break;
        }
      }
      if (isTvShow) break;
    }

    final relatedContent = isTvShow ? getEpisodes() : getRelatedMovies();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.movie["title"],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                          color: Colors.white,
                          size: 70.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying ? _controller.pause() : _controller.play();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                height: 200,
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie["title"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie["description"],
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Conditional Section based on movie type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Text(
                isTvShow ? 'Episodes' : 'Related Movies',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Conditional List View
            if (isTvShow)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: relatedContent.length,
                itemBuilder: (context, index) {
                  final episode = relatedContent[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    leading: Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
                    title: Text(
                      episode["title"],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      episode["description"],
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      context.go(
                        '${AppRoutes.videoPage}/${AppRoutes.moviePlayer}',
                        extra: episode,
                      );
                    },
                  );
                },
              )
            else
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: relatedContent.length,
                  itemBuilder: (context, index) {
                    final relatedMovie = relatedContent[index];
                    return GestureDetector(
                      onTap: () {
                        context.go(
                          '${AppRoutes.videoPage}/${AppRoutes.moviePlayer}',
                          extra: relatedMovie,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(relatedMovie["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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