import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

  Future<void> setFavoriteStationId(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stationId', stationId);
  }

  Future<String?> getFavoriteStationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('stationId');
  }

  Future<void> setDeviceId(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', stationId);
  }

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceId') ?? '';
  }

  Future<void> setDeviceIdIUpdated(bool updated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('deviceIdUpdated', updated);
  }

  Future<bool> getDeviceIdIUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('deviceIdUpdated') ?? false;
  }

  Future<void> setUserId(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', stationId);
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

  // Playback quality preferences
  Future<void> setPlaybackQuality(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('playbackQuality', stationId);
  }

  Future<String> getPlaybackQuality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('playbackQuality') ?? 'Low';
  }

  // Playback quality preferences
  Future<void> setDownloadQuality(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('downloadQuality', stationId);
  }

  Future<String> getDownloadQuality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('downloadQuality') ?? 'Low';
  }

  // Recent search
  Future<void> addRecentKeyword(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keywords = prefs.getStringList('recent_keywords') ?? [];
    Set<String> uniqueKeywords = Set<String>.from(keywords);
    await prefs.setStringList('recent_keywords', uniqueKeywords.toList()..insert(0, keyword));
  }

  Future<List<String>> getRecentKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recent_keywords') ?? [];
  }

}