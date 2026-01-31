import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        // FIX: Smart Fill Color
        // Light Mode: Grey (so it stands out on white bg)
        // Dark Mode: Dark Grey (so it matches the dark theme)
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2C2C2C)
            : Colors.grey.shade100,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),

        // Keep borders none for Search Bar style
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}