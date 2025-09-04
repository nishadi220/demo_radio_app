import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/components/Settings/notificationToggle.dart';
import 'package:radio_super_app/components/Settings/elevatedButtonTile.dart';
import 'package:radio_super_app/pages/mainScreen.dart';
import 'package:radio_super_app/router/appRoutes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32), // Spacing below the title
            ElevatedButtonTile(
              onTap: () {
                // Handle Language Preferences tap
                context.push(AppRoutes.languagePreferences);
              },
            ),
            ElevatedButtonTile(
              onTap: () {
                // Handle Playback Quality tap
                context.push(AppRoutes.playbackQuality);
              },
              title: 'Playback Quality',
              subtitle: 'Choose your quality settings',
            ),
            ElevatedButtonTile(
              onTap: () {
                // Handle Download Quality tap
                context.push(AppRoutes.downloadQuality);
              },
              title: 'Download Quality',
              subtitle: 'Choose your quality settings',
            ),
            // NotificationToggle(
            //   title: 'Playback over Mobile Data',
            //   subtitle: 'Low Data Mode',
            //   initialValue: true,
            //   onChanged: (value) {
            //     // Handle switch toggle
            //   },
            // ),
            ElevatedButtonTile(
              onTap: () {
                // Handle Notification Settings tap
                context.push(AppRoutes.notificationsSettings);
              },
              title: 'Notification Settings',
              subtitle: 'Edit your notification settings',
            ),
            ElevatedButtonTile(
              onTap: () {
                // Handle Privacy Settings tap
                context.push(AppRoutes.privacyPolicy);
              },
              title: 'Privacy Policy',
              subtitle: 'Refer the privacy policy settings',
            ),
            ElevatedButtonTile(
              onTap: () {
                // Handle Terms and Conditions tap
                context.push(AppRoutes.termsAndConditions);
              },
              title: 'Terms and Conditions',
              subtitle: 'Refer the Terms and Conditions',
            ),
          ],
        ),
    );
  }
}


