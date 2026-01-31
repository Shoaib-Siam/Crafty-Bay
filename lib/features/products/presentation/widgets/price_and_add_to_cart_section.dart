import 'package:flutter/material.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/bottom_section_container.dart'; // Import it

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({
    super.key,
    required this.price,
    required this.onAddToCart,
    this.buttonText = 'Add To Cart',
  });

  final String price;
  final VoidCallback onAddToCart;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // USE THE GENERIC CONTAINER
    return BottomSectionContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                '$takaSign$price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(
              onPressed: onAddToCart,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}