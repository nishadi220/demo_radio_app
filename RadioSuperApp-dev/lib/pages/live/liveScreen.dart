import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample video data
    final videos = [
      {
        "thumbnail": "https://i.ytimg.com/vi/VfNRd5Rk0cM/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDq6ySYhVMulDs2ZdBUQ4tfvPIqdg",
        "title": "This app made over 1M dollors",
        "channel": "Starter Story",
        "time": "Updated today",
        "duration": null,
      },
      {
        "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDz3vfD_8fahXclB1N8K3HuhU5BCA",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
      },
      {
        "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDz3vfD_8fahXclB1N8K3HuhU5BCA",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
      },
      {
        "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDz3vfD_8fahXclB1N8K3HuhU5BCA",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
      },
      {
        "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDz3vfD_8fahXclB1N8K3HuhU5BCA",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
      },
      {
        "thumbnail": "https://i.ytimg.com/vi/o6Z0MxWCbrc/hq720.jpg?sqp=-oaymwEnCNAFEJQDSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLDz3vfD_8fahXclB1N8K3HuhU5BCA",
        "title": "We built our very own hobbit house!",
        "channel": "DIY Perks",
        "time": "459K views · 5 days ago",
        "duration": "20:19",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Live',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Padding(
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
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  video['time']!,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
