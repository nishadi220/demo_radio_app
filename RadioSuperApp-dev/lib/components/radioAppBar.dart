import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget RadioAppBar(BuildContext context, Color backgroundColor) => AppBar(
  backgroundColor: backgroundColor,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      GoRouter.of(context).pop();
    },
  ),
);
