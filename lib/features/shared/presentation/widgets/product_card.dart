import 'package:crafty_bay/features/shared/presentation/widgets/wishlist_button.dart';
import 'package:flutter/material.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../products/presentation/screens/product_details_screen.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        // 1. Defined Shape (Radius 8)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.transparent
            : Theme.of(context).primaryColor.withOpacity(0.2),
        // 2. IMPORTANT: Clip the ripple to the card's shape
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName);
          },
          // FIX: Don't force a different radius here. Let the Card clip it.
          // borderRadius: BorderRadius.circular(16), <--- REMOVED

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. FIX: Use 'Ink' instead of 'Container' so ripple shows ON TOP
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
                  child: Image.asset(
                    AssetPaths.dummyImageSvg, 
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 2. Details Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Nike Shoe 12K Air ',
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
                                Text(
                                  '${takaSign}1200',
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
                                      '4.8',
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

                          // Wishlist Button
                          WishlistButtonWidget(
                            isSelected: false,
                            onTap: () {
                              print('Heart clicked!');
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