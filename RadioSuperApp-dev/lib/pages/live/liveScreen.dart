import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove default background color
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF660000), // Dark red (deep wine)
              Color(0xFF1C1C1C), // Dark gray
              Colors.black,      // Pure black
            ],
            stops: [0.0, 0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar replacement
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                color: Colors.transparent,
              ),

              // Body content
              const Expanded(
                child: Center(
                  child: Text(
                    'Live Screen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
