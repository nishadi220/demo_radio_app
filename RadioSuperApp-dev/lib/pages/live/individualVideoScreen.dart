import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IndividualLiveScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;

  const IndividualLiveScreen({super.key, required this.videoData});

  @override
  State<IndividualLiveScreen> createState() => _IndividualLiveScreenState();
}

class _IndividualLiveScreenState extends State<IndividualLiveScreen> {
  late YoutubePlayerController _youtubeController;

  final List<Map<String, dynamic>> relatedVideos = [
    {
      "thumbnail": "https://i.ytimg.com/vi/VfNRd5Rk0cM/hq720.jpg",
      "title": "This app made over 1M dollars",
      "channel": "Starter Story",
      "time": "56K views · 8 days ago",
      "videoUrl": "https://www.youtube.com/watch?v=VfNRd5Rk0cM"
    },
    {
      "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg",
      "title": "We built our very own hobbit house!",
      "channel": "DIY Perks",
      "time": "459K views · 5 days ago",
      "videoUrl": "https://www.youtube.com/watch?v=o6Z0MxWCbrc"
    },
    {
      "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg",
      "title": "We built our very own hobbit house!",
      "channel": "DIY Perks",
      "time": "459K views · 5 days ago",
      "videoUrl": "https://www.youtube.com/watch?v=o6Z0MxWCbrc"
    },
  ];

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoData['videoUrl']) ?? '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.videoData;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      video['title'] ?? 'Video',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // YouTube Video Player
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
            ),

            // Video Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(video['channel'] ?? '', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      const Spacer(),
                      Text(video['time'] ?? '', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24),

            // Related Videos
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: relatedVideos.length,
                itemBuilder: (context, index) {
                  final related = relatedVideos[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/video/individual', extra: related);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              related['thumbnail'] ?? '',
                              width: 120,
                              height: 68,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  related['title'] ?? '',
                                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  related['channel'] ?? '',
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                                Text(
                                  related['time'] ?? '',
                                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                                ),
                              ],
                            ),
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