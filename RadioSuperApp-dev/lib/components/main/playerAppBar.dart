import 'package:flutter/material.dart';

AppBar PlayerAppBar(VoidCallback onMinimizeCallback, VoidCallback onCloseCallback ,{required Color backgroundColor}) => AppBar(
  backgroundColor: backgroundColor,
  actions: [
    IconButton(
      icon: const Icon(
        Icons.close_fullscreen,
        color: Colors.white,
        size: 24,
      ),
      onPressed: onMinimizeCallback,
    ),
    IconButton(
      icon: const Icon(
        Icons.close,
        color: Colors.white,
        size: 32,
      ),
      onPressed: onCloseCallback,
    ),
  ],
);