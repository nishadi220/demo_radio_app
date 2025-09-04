import 'package:flutter/material.dart';

import '../../components/radioAppBar.dart';

///
/// Steps
/// 1. Parse title and content from as params to make this widget reusable (Refer to baseSettingsSelector.dart)
/// 2. Replace title and content from widget.params
/// 3. Implement termsAndConditionsScreen and PrivacyPolicyScreen by reusing this widget
/// 4. update termsAndConditionsScreen and PrivacyPolicyScreen
/// 5. Define navigation routes for termsAndConditionsScreen and PrivacyPolicyScreen
/// 6. Set navigation routes from the setting screen


class LegalInfoScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalInfoScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RadioAppBar(context, Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
