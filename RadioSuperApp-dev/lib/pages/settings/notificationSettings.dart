import 'package:flutter/material.dart';
import 'package:radio_super_app/components/Settings/notificationToggle.dart';
import 'package:radio_super_app/components/common/futureBuilderWidget.dart';
import '../../components/radioAppBar.dart';
import '../../managers/sharedPreferencesManager.dart';
import '../../models/notification/entities/updateNotificationEntity.dart';
import '../../models/settings/requests/getNotificationSettingsResponse.dart';
import '../../services/settingsService.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late Future<GetNotificationSettingsResponse> _notificationSettings;

  Map<int, bool> updatedStates = {}; // Track updated toggle states
  bool isHovered = false; // Hover state for Save button
  bool isSaved = false; // Save state for Save button

  @override
  void initState() {
    super.initState();
    _notificationSettings = SettingsService().fetchNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RadioAppBar(context, Colors.black),
      backgroundColor: Colors.black,
      body: FutureBuilderWidget<GetNotificationSettingsResponse>(
        future: _notificationSettings,
        onSuccess: (settingsResponse) {
          // Map the API response into a list of notification settings
          final notificationList = settingsResponse.notificationList;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notification Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      final notification = notificationList[index];
                      return NotificationToggle(
                        title: notification.notification,
                        subtitle: notification.status ? 'Enabled' : 'Disabled',
                        initialValue: notification.status,
                        onChanged: (value) {
                          setState(() {
                            // Update the toggle state and track unsaved changes
                            updatedStates[notification.id] = value;
                            isSaved = false; // Reset save state
                          });
                        },
                      );
                    },
                  ),
                ),
                _buildSaveButton(context),
              ],
            ),
          );
        },
        onError: (error) {
          return const Center(
            child: Text(
              'Failed to load notification settings. Please try again.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true; // Enable hover state
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false; // Disable hover state
        });
      },
      child: GestureDetector(
        onTap: updatedStates.isEmpty
            ? null // Disable the button if no changes
            : () {
          final updates = updatedStates.entries.map((entry) {
            return UpdateNotificationEntity(
              guestId: SharedPreferencesManager().getDeviceId(), // Replace with actual guestId
              notificationSettingId: entry.key,
              isActive: entry.value,
            );
          }).toList();

          // Update settings via API
          Future.wait(
            updates.map((updateEntity) =>
                SettingsService().updateNotificationSettings(updateNotificationEntity: updateEntity)),
          ).then((results) {
            final failed = results.where((result) => result == null).toList();
            if (failed.isEmpty) {
              setState(() {
                isSaved = true; // Mark as saved
                updatedStates.clear(); // Clear the updates
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications updated successfully')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Some notifications failed to update')),
              );
            }
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error updating notifications: $error')),
            );
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: updatedStates.isEmpty
                ? Colors.grey // Disabled state
                : (isSaved ? Colors.green : Colors.cyan[800]), // Dynamic color
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
