import 'package:flutter/material.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({
    super.key,
    this.isSelected = false, // Default is empty heart
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Use Ink/InkWell to get the ripple effect on tap
    return Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            // Switch icon based on state
            isSelected ? Icons.favorite : Icons.favorite_border,
            size: 12, // Increased slightly from 10 for better visibility
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}