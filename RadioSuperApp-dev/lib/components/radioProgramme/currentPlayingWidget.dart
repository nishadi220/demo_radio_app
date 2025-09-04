import 'package:flutter/material.dart';
import 'package:radio_super_app/configs/assets/appImages.dart';

class CurrentPlayingWidget extends StatefulWidget {
  final double screenWidth;
  final String imagePath; // Prop for image
  final String stationName; // Prop for station name
  final String statusText; // Prop for status text (e.g., "LIVE")
  final Color iconColor; // Prop for icon color
  final BorderRadius borderRadius; // Prop for border radius of the image

  const CurrentPlayingWidget({
    Key? key,
    required this.screenWidth,
    required this.imagePath,
    required this.stationName,
    required this.statusText,
    required this.iconColor,
    required this.borderRadius,
  }) : super(key: key);

  @override
  _CurrentPlayingWidgetState createState() => _CurrentPlayingWidgetState();
}

class _CurrentPlayingWidgetState extends State<CurrentPlayingWidget> {
  bool isPlaying = false;
  bool isFavorite = false;

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying; // Toggle play/stop state
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate 34% of the screen width
    double currentPlayingWidth = widget.screenWidth * 0.34;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image with customizable properties
          SizedBox(
            width: currentPlayingWidth,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: AspectRatio(
                aspectRatio: 1,
                child:
                    Image.network(
                      widget.imagePath, // Network URL
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child; // If loaded, show image
                        return const CircularProgressIndicator(); // Show loader while loading
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.defaultImage, // Asset fallback image
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        );
                      },
                    )
                ),
              ),
            ),
          const SizedBox(width: 16),
          // Radio Station Details and Buttons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.stationName, // Use the station name prop
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.statusText, // Use the status text prop
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8.0), // Gap between "LIVE" text and buttons
                Row(
                  children: [
                    // Stop button with toggle functionality
                    GestureDetector(
                      onTap: togglePlayStop,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            isPlaying ? Icons.play_arrow : Icons.pause, // Switch between play and stop icons
                            color: widget.iconColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_downward, // Use the play icon prop
                          color: widget.iconColor, // Use the icon color prop
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
