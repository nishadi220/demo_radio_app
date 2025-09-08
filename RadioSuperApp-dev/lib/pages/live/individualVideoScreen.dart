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
  ];

  @override
  void initState() {
    super.initState();
    final videoId =
        YoutubePlayer.convertUrlToId(widget.videoData['videoUrl']) ?? '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.videoData;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player
              YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
              ),

              // Title
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  video['title'] ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),

              // Views + hashtags row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "${video['views'] ?? '138K views'}  •  ${video['time'] ?? '3 months ago'}  #Azure",
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ),

              const SizedBox(height: 8),

              // Channel info row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        video['channel'] ?? 'Channel Name',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Action buttons row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.thumb_up_alt_outlined, "5.9K"),
                    _buildActionButton(Icons.thumb_down_alt_outlined, "Dislike"),
                    _buildActionButton(Icons.share, "Share"),
                  ],
                ),
              ),

              const Divider(color: Colors.white24, thickness: 0.5),

              // Related Videos Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  "Related Videos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: relatedVideos.length,
                itemBuilder: (context, index) {
                  final related = relatedVideos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            related['thumbnail']!,
                            width: 120,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded( // ✅ Prevents overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                related['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // ✅ tidy long titles
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${related['channel']} • ${related['views']} • ${related['time']}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // ✅ tidy metadata
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
