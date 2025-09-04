import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/podcast/entities/categoryGridEntity.dart';
import '../../router/appRoutes.dart';

class PodcastCategoryButton extends StatelessWidget {
  final CategoryEntity category;
  final Gradient gradient;

  const PodcastCategoryButton({
    Key? key,
    required this.category,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.podcastPage + AppRoutes.categories, extra: category);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF2C2C2C),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)
                ),
              ),
            ),
            const SizedBox(width: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                category.description.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}