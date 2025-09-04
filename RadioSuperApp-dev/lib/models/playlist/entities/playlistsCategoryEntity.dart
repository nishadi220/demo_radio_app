import 'package:flutter/material.dart';

class PlaylistsCategoryEntity {
  final String id; // Changed from name to Id of type int
  final String type; // Changed to match the new description field
  // final String picUrl; // Added picUrl field

  PlaylistsCategoryEntity({
    required this.id,
    required this.type,
    // required this.picUrl,
  });

  // Factory constructor to create CategoryEntity from JSON
  factory PlaylistsCategoryEntity.fromJson(Map<String, dynamic> json) {
    return PlaylistsCategoryEntity(
      id: json['id'] as String, // Mapping Id field
      type: json['type'] as String, // Mapping description field
      // picUrl: json['picUrl'] as String, // Mapping picUrl field
    );
  }

  // Method to convert CategoryEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type, // Serializing description as string
      // 'picUrl': picUrl, // Serializing picUrl as string
    };
  }
}
