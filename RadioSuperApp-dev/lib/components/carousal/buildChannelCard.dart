import 'package:flutter/material.dart';

Widget buildChannelCard(BuildContext context, String imageAsset, String label) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),  // Rounded corners for the outer container
    child: Container(
      width: MediaQuery.of(context).size.width * 0.45,
      color: Colors.transparent,
      child: Center(  // Centers the Column within the Container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers items vertically
          crossAxisAlignment: CrossAxisAlignment.center,  // Centers items horizontally
          children: [
            Material(
              elevation: 6.0,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    imageAsset,
                    height: 124,
                    width: 124,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
