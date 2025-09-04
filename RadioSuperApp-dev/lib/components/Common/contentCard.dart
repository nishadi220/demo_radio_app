import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../contentModal.dart';

class ContentCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String title;
  final String description;
  final String? startTime;
  final String? endTime;
  final String? routingPath;

  // Constructor to receive podcast data
  const ContentCard({
    Key? key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    this.routingPath,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (routingPath != null) {
          // Only navigate if the routingPath is not null
          context.go(
            routingPath!,
            extra: {
              'id': id,
              'name': title,
              'description': description,
              'picUrl': imagePath,
            },
          );
        } else {
          // Show the modal when the routingPath is null
          showDialog(
            context: context,
            builder: (context) => ContentModal(
              title: title,
              description: description,
              imagePath: imagePath,
              startTime: startTime,
            ),
          );
        }
      },
      child: SizedBox(
        width: 133,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 133,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                  bottom: Radius.circular(8),
                ),
                image: DecorationImage(
                  image: NetworkImage(imagePath), // Use the dynamic imagePath
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (startTime != null)
                    Text(
                      startTime!,
                      style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
