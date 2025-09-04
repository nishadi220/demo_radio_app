import 'package:flutter/material.dart';

class RadioStationTile extends StatefulWidget {
  final String imagePath;
  final String stationName;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const RadioStationTile({
    required this.imagePath,
    required this.stationName,
    required this.isFavorite,
    required this.onFavoriteToggle
  });

  @override
  State<RadioStationTile> createState() => _RadioStationTileState();
}

class _RadioStationTileState extends State<RadioStationTile> {
  // bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.imagePath,
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
                    widget.stationName,
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
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing icon
            IconButton(
              iconSize: 28,
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.white : Colors.white,
              ),
              onPressed: widget.onFavoriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
