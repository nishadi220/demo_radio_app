import 'package:flutter/services.dart';

class AppMinimizer {
  static const MethodChannel _channel = MethodChannel('com.sirasa.radio_super_app/minimize');

  static Future<void> minimizeApp() async {
    try {
      await _channel.invokeMethod('minimizeApp');
    } on PlatformException catch (e) {
      print("Failed to minimize the app: '${e.message}'.");
    }
  }
}