import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/product_card.dart'; // Ensure this imports the file above

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Keep this fixed height.
      // Since we use Expanded in the card, this height controls the card's total size.
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return const ProductCardWidget();
        },
      ),
    );
  }
}