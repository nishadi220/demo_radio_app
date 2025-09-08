import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/configs/assets/appImages.dart';
import 'dart:async';

import '../router/appRoutes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main app after 3 seconds
    Timer(const Duration(milliseconds: 1600), () {
      context.go(AppRoutes.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xFF7030A0), // Custom color
        //       Colors.black,      // Black
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.nadeoLogo, // Replace with your image URL
                width: 250,
                height: 350,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Colors.white,
                  ); // Fallback in case of an error
                },
              ),
              const SizedBox(height: 20),
              // const Text(
              //   'Nadeo Radio Services',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
