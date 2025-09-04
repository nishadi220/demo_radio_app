import 'package:flutter/material.dart';

class CategoryEntity {
  final String id; // Changed from name to Id of type int
  final String description; // Changed to match the new description field
  final String picUrl; // Added picUrl field

  CategoryEntity({
    required this.id,
    required this.description,
    required this.picUrl,
  });

  // Factory constructor to create CategoryEntity from JSON
  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'] as String, // Mapping Id field
      description: json['description'] as String, // Mapping description field
      picUrl: json['picUrl'] as String, // Mapping picUrl field
    );
  }

  // Method to convert CategoryEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description, // Serializing description as string
      'picUrl': picUrl, // Serializing picUrl as string
    };
  }
}
