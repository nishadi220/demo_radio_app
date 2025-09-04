import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/appRoutes.dart';

class BottomBarItem extends StatelessWidget {
  final String appRoute;
  final IconData icon;

  const BottomBarItem({super.key, required this.appRoute, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.push(appRoute);
      },
      icon: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
