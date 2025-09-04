import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText; // Parameter for the button text

  const Button({
    Key? key,
    required this.onPressed,
    required this.buttonText, // Make buttonText required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button width take the full screen width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text( // Use the buttonText parameter
          buttonText,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black),
        ),
      ),
    );
  }
}
