import 'package:flutter/material.dart';

// TrendingPodcasts Component with FutureBuilderWidget
class ContentSlider extends StatelessWidget {
  final String headerText;
  final Widget Function() futureWidgetBuilder; // Prop for the future widget builder

  const ContentSlider({
    super.key,
    required this.headerText,
    required this.futureWidgetBuilder
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            headerText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 200, // Fixed height for horizontal scroll section
          child: futureWidgetBuilder(), // Use the provided future widget builder
          ),
      ],
    );
  }
}
