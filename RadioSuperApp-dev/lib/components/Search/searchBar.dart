import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;

  const SearchBar({
    Key? key,
    this.hintText = 'What do you want to listen to?',
    this.onChanged,
    this.onSubmitted,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted, // Triggered when Enter is pressed
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            if (controller != null && onSubmitted != null) {
              onSubmitted!(controller!.text); // Trigger onSubmitted with the input text
            }
          },
        ),
      ),
    );
  }
}
