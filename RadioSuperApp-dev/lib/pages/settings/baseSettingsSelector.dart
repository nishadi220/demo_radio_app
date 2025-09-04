import 'package:flutter/material.dart';

import '../../components/Settings/notificationToggle.dart';

class BaseSettingsSelector extends StatefulWidget {
  final String? selectedOption;
  final void Function(String quality) onSave;
  final void Function(String quality) onQualityChange;
  final String title;
  final String subtitle;
  final List<String> settingOptions;
  final bool showNotificationToggle; // New boolean parameter


  const BaseSettingsSelector({
    super.key,
    required this.selectedOption,
    required this.onSave,
    required this.onQualityChange,
    required this.title,
    required this.subtitle,
    this.settingOptions = const ['High', 'Normal', 'Low'],
    this.showNotificationToggle = false, // Default value is false
  });

  @override
  State<BaseSettingsSelector> createState() =>
      _BaseSettingsSelectorState();
}

class _BaseSettingsSelectorState extends State<BaseSettingsSelector> {
  late String? selectedQuality;
  bool isHovered = false; // Hover state for Save button
  bool isSaved = false; // Save state for Save button

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedQuality = widget.selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            ...widget.settingOptions.map((quality) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildQualityButton(quality),
            )),
            if (widget.showNotificationToggle) ...[
              const SizedBox(height: 16), // Spacing before toggle
              NotificationToggle(
                title: 'Playback over Mobile Data',
                subtitle: 'Enable Low Data Mode',
                initialValue: true,
                onChanged: (value) {
                  // Handle toggle changes
                  print('Notification Toggle Changed: $value');
                },
              ),
            ],
            const Spacer(),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }


  Widget _buildQualityButton(String quality) {
    return GestureDetector(
      onTap: () {
        if (selectedQuality == quality) {
          return; // Disable the button if no changes
        }
        setState(() {
          selectedQuality = quality; // Update the selected quality
          isSaved = false; // Reset save state when a new quality is selected
        });
        widget.onQualityChange(quality);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: selectedQuality == quality ? Colors.cyan[800] : Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            quality,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
        onTap: () {
          if (!isSaved && selectedQuality != null) {
            setState(() {
              isSaved = true; // Mark as saved
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.title} saved: $selectedQuality'),
              ),
            );

            // Reset Save button to default state after 2 seconds
            // Future.delayed(const Duration(milliseconds: 100), () {
            //   if (mounted) {
            //     setState(() {
            //       isSaved = false;
            //     });
            //   }
            // });

            widget.onSave(selectedQuality!);
          } else {
            // Show a message if no quality is selected
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select a ${widget.title}!'),
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSaved
                ? Colors.blue[800]
                : (selectedQuality != null
                ? Colors.cyan[600]
                : Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              isSaved ? 'Saved' : 'Save',
              style: const TextStyle(
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