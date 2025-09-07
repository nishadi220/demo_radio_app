import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/appRoutes.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = [
      {
        "thumbnail":
        "https://i.ytimg.com/vi/VfNRd5Rk0cM/hq720.jpg",
        "title": "This app made over 1M dollars",
        "channel": "Starter Story",
        "time": "56K views · 8 days ago",
        "duration": "4:08",
        "videoUrl": "https://www.youtube.com/watch?v=VfNRd5Rk0cM"
      },
      {
        "thumbnail":
        "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
        "videoUrl": "https://www.youtube.com/watch?v=o6Z0MxWCbrc"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF660000),
              Color(0xFF1C1C1C),
              Colors.black,
            ],
            stops: [0.0, 0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 40, 16, 16),
              child: Text(
                "All Video On Demand Content",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to YouTube player screen
                      context.push(
                        AppRoutes.videoPage + AppRoutes.individualVideo,
                        extra: video,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  video['thumbnail']!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (video['duration'] != null)
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    color: Colors.black.withOpacity(0.7),
                                    child: Text(
                                      video['duration']!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video['title']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            video['channel']!,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            video['time']!,
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 12),
                          ),
                        ],
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