import 'package:flutter/material.dart';

// Function to build show tile
Widget BuildShowTile(String imagePath, String title) {
  return Container(
    width: 80,
    height: 80,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );
}