import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../configs/assets/appImages.dart';
import '../../router/appRoutes.dart';

class PodcastItemCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String picUrl;

  const PodcastItemCard({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.picUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          AppRoutes.podcastPage + AppRoutes.podcastsOpen,
          extra: {
            'id': id,
            'name': name,
            'description': description,
            'picUrl': picUrl,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(12),
              ),
              image: DecorationImage(
                image: picUrl.isNotEmpty
                    ? NetworkImage(picUrl)
                    : const AssetImage(AppImages.defaultImage) as ImageProvider,
                fit: BoxFit.cover,
                // No onError callback for DecorationImage; fallback is handled by the AssetImages
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
