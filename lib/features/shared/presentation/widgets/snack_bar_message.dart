import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(String title, String message, {bool isError = false}) {
  final context = Get.context!;
  final colorScheme = Theme.of(context).colorScheme;

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING, // Makes it float above UI

    // Background Color logic:
    // In Dark Mode, we use darker containers. In Light Mode, we use standard colors.
    backgroundColor: isError
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer,

    // Text Colors:
    // Using 'onContainer' ensures text is always readable against the background
    colorText: isError
        ? colorScheme.onErrorContainer
        : colorScheme.onPrimaryContainer,

    margin: const EdgeInsets.all(16),
    borderRadius: 12, // Slightly rounder for modern look
    duration: const Duration(seconds: 3),

    // Icon Logic
    icon: Icon(
      isError ? Icons.error_outline : Icons.check_circle_outline,
      color: isError
          ? colorScheme.onErrorContainer
          : colorScheme.onPrimaryContainer,
    ),

    // Smooth Animation
    forwardAnimationCurve: Curves.easeOutBack,
  );
}