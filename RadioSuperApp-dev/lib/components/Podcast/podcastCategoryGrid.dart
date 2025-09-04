import 'package:flutter/material.dart';
import 'package:radio_super_app/components/Podcast/podcastCategoryButton.dart';
import '../../models/podcast/responses/getCategoryListResponse.dart';
import '../../services/podcastService.dart';
import '../common/futureBuilderWidget.dart';

class PodcastCategoryGrid extends StatelessWidget {

  final List<Gradient> categoryGradients = [
    const LinearGradient(
      colors: [Color(0xFFD55790), Color(0xFFD55790)], // Lifestyle
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.19, 1.0],
    ),
    const LinearGradient(
      colors: [Color(0xFFFDC661), Color(0xFFFDC661)], // Comedy
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFF1087AE), Color(0xFF1087AE)], // Society & Culture
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFFFD5656), Color(0xFFFD5656)], // Entertainment
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFF7A05DA), Color(0xFF7A05DA)], // Religion & Spirituality
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFFD3A9FF), Color(0xFFD3A9FF)], // Business & Financial
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFFFD6C40), Color(0xFFFD6C40)], // Education
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFFFF416C), Color(0xFFFF416C)], // News
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFF586CE5), Color(0xFF586CE5)], // Astrology
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFFFEFEFE), Color(0xFFFEFEFE)], // Health
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xFF602A8E), Color(0xFF602A8E)], // Technology
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWidget<GetCategoryGridResponse>(
      future: PodcastService().fetchCategories(), // This will call your API to get categories
      onSuccess: (data) {
        // If categories are fetched successfully
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3, // Adjust height for the buttons
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
          ),
          itemCount: data.categories.length, // Using categories from the response data
          itemBuilder: (context, index) {
            return PodcastCategoryButton(
              category: data.categories[index],
              gradient: categoryGradients[index % categoryGradients.length], // Use the gradient from the list based on index
            );
          },
        );
      },
      onError: (error) {
        // If there's an error fetching categories
        return const Center(
          child: Text('Failed to load categories, please try again.'),
        );
      },
    );
  }
}