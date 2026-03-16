import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/constants.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/wishlist_button.dart';
import '../../data/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  // 1. ADD THIS LINE (Declare the type)
  final ProductModel product;

  // 2. FIX THE CONSTRUCTOR (Use 'this.product')
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.transparent
            : Theme.of(context).primaryColor.withOpacity(0.2),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // This is much cleaner than Navigator.pushNamed!
            Get.to(() => ProductDetailsScreen(productId: product.sId!));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2C2C2C)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    // 4. DYNAMIC IMAGE
                    (product.photos != null && product.photos!.isNotEmpty)
                        ? product.photos!.first
                        : 'https://via.placeholder.com/150',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 5. DYNAMIC TITLE
                      Text(
                        product.title ?? 'Unknown',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5,
                              children: [
                                // 6. DYNAMIC PRICE
                                Text(
                                  '$takaSign${product.currentPrice ?? 0}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 13,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    Text(
                                      '4.8', // Update if API adds ratings later
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.grey.shade400
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 7. DYNAMIC WISHLIST STATE
                          WishlistButtonWidget(
                            isSelected: product.inWishlist ?? false,
                            onTap: () {
                              print('${product.title} wishlist clicked!');
                            },
                          ),
                        ],
                      ),
                    ],
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