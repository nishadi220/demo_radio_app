import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/radioAppBar.dart';
import '../../managers/sharedPreferencesManager.dart';
import 'baseSettingsSelector.dart';

class PlaybackQualityScreen extends StatelessWidget {
  const PlaybackQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SharedPreferencesManager().getPlaybackQuality(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: RadioAppBar(context, Colors.black),
          body: BaseSettingsSelector(
            selectedOption: snapshot.data,
            onSave: (quality) {
              SharedPreferencesManager().setPlaybackQuality(quality);
            },
            onQualityChange: (quality) {
              debugPrint('Selected Quality: $quality');
            },
            title: 'Playback Quality',
            subtitle: 'Choose playback quality to adjust audio clarity',
            settingOptions: const ['High', 'Normal', 'Low'],
            showNotificationToggle: true,
          ),

        );
      },
    );
  }
}