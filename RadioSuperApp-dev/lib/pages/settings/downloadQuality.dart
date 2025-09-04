import 'package:flutter/material.dart';
import '../../components/radioAppBar.dart';
import '../../managers/sharedPreferencesManager.dart';
import 'baseSettingsSelector.dart';

class DownloadQualityScreen extends StatelessWidget {
  const DownloadQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SharedPreferencesManager().getDownloadQuality(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: RadioAppBar(context, Colors.black),
          body: BaseSettingsSelector(
            selectedOption: snapshot.data,
            onSave: (quality) {
              SharedPreferencesManager().setDownloadQuality(quality);
            },
            onQualityChange: (quality) {
              debugPrint('Selected Quality: $quality');
            },
            title: 'Download Quality',
            subtitle: 'Choose download quality to control the clarity and size of audio files',
            settingOptions: const ['High', 'Normal', 'Low'],
            showNotificationToggle: false,
          ),
        );
      },
    );
  }
}
