import 'package:flutter/material.dart';
import '../../../../app/asset_paths.dart'; // Make sure you have your dummy image path here
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/inc_dec_counter.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.title,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  final String title;
  final String color;
  final String size;
  final String price;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          // 1. Image Section
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(8),
            // Replace with Image.network in real app
            child: Image.asset(AssetPaths.dummyImageSvg, fit: BoxFit.scaleDown),
          ),

          const SizedBox(width: 10),

          // 2. Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Delete Icon Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    )
                  ],
                ),

                // Color and Size
                Text(
                  'Color: $color  |  Size: $size',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 12),

                // Price & Counter Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$takaSign$price',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    // REUSING YOUR WIDGET
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IncDecCounter(
                        initialValue: quantity,
                        onChange: onQuantityChanged,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}