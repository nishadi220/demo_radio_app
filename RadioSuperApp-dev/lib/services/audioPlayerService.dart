import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

import '../managers/sharedPreferencesManager.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Get the local file path for a podcast
  Future<String> _getLocalFilePath(String podcastId) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$podcastId.mp3";
  }

  /// Check if the podcast file is already downloaded
  Future<bool> isPodcastDownloaded(String podcastId) async {
    final filePath = await _getLocalFilePath(podcastId);
    return File(filePath).exists();
  }

  /// Download the podcast file
  Future<void> downloadPodcast(String podcastUrl, String podcastId, Function(int, int) onProgress) async {
    try {
      final filePath = await _getLocalFilePath(podcastId);
      final dio = Dio();
      String newPodcastUrl = await getThePodcastUrl(podcastUrl);

      await dio.download(
          newPodcastUrl,
          filePath,
          onReceiveProgress: (received, total) {
            if (onProgress != null) {
              onProgress(received, total);
            }
          },
      );
      print("Podcast downloaded: $filePath");
    } catch (e) {
      print("Error downloading podcast: $e");
    }
  }

  Future<String> getThePodcastUrl(String podcastUrl) async {
    // Default type
    String downloadQuality = 'Low';

    try {
      downloadQuality = await SharedPreferencesManager().getDownloadQuality();
    } catch (e) {
      print("Error getting downloadQuality: $e");
    }

    if (downloadQuality != 'Low') {
      podcastUrl.replaceAll('Low', downloadQuality);
    }

    return podcastUrl;
  }

  /// Play the podcast
  Future<void> playPodcast(String podcastUrl, String podcastId) async {
    final isDownloaded = await isPodcastDownloaded(podcastId);
    final filePath = await _getLocalFilePath(podcastId);

    if (isDownloaded) {
      // Play from local file
      await _audioPlayer.setFilePath(filePath);
    } else {
      // Play from URL
      await _audioPlayer.setUrl(podcastUrl);
    }
    _audioPlayer.play();
  }

  /// Stop the podcast
  Future<void> stopPodcast() async {
    await _audioPlayer.stop();
  }
}