import 'package:flutter/material.dart';

class NotificationToggle extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const NotificationToggle({
    Key? key,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NotificationToggleState createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.initialValue;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isEnabled = value;
    });
    widget.onChanged(value); // Trigger the callback with the new value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Switch(
            value: isEnabled,
            onChanged: _toggleSwitch, // Toggle button works with this handler
            activeColor: Colors.cyan,  // Cyan color for active state
          ),
        ],
      ),
    );
  }
}
