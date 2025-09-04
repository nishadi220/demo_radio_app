import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/components/Carousal/buildShowTile.dart';
import 'package:radio_super_app/configs/assets/appImages.dart';
import '../../router/appRoutes.dart';

class ShowsSection extends StatelessWidget {
  final String headerText; // Declare the headerText prop
  final List<Map<String, String>> shows; // Declare the shows prop as a list of maps

  const ShowsSection({
    Key? key,
    required this.headerText,
    required this.shows, // Accept shows as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText, // Use the passed headerText prop
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: shows.map((show) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: InkWell(
                      onTap: () {
                        context.push(AppRoutes.radioPage + AppRoutes.radioProgramme);
                      },
                      child: BuildShowTile(
                        show['image'] ?? AppImages.yfm, // Use the passed image (default if null)
                        show['title'] ?? 'Untitled',    // Use the passed title (default if null)
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
