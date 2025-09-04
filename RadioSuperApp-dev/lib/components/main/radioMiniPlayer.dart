import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/radioChannelProvider.dart';

class RadioMiniPlayer extends StatelessWidget {
  final LinearGradient gradient;
  final bool isPlaying;
  final VoidCallback playOrStopCallback;

  const RadioMiniPlayer({
    super.key,
    required this.gradient,
    required this.isPlaying, required this.playOrStopCallback
  });

  @override
  Widget build(BuildContext context) {

    final radioProvider = Provider.of<RadioChannelProvider>(context);
    final currentChannel = radioProvider.currentRadioChannel;
    return Container(
      height: currentChannel != null ? 80 : 0,
      decoration: BoxDecoration(
        color: Colors.red,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  currentChannel?.picUrl ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentChannel?.name ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    "LIVE",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: Icon(
                isPlaying ? Icons.stop  : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: playOrStopCallback,
            ),
          ],
        ),
      ),
    );
  }
}

