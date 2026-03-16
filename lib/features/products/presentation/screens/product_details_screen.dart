import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../reviews/presentation/screens/review_screen.dart';
import '../../../shared/presentation/widgets/inc_dec_counter.dart';
import '../../../shared/presentation/widgets/wishlist_button.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/size_picker.dart';
import '../controllers/product_details_controller.dart';
import '../../../shared/data/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  // 1. ADD THE PRODUCT ID TO THE CONSTRUCTOR
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  static const String routeName = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<int> _currentSlideIndex = ValueNotifier(0);
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    // 2. FETCH THE FRESH DATA WHEN SCREEN OPENS
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  // Quick helper to map API color strings ("Red", "Blue") to actual Flutter Colors
  Color _getColorFromString(String color) {
    color = color.toLowerCase();
    if (color.contains('red')) return Colors.red;
    if (color.contains('blue')) return Colors.blue;
    if (color.contains('green')) return Colors.green;
    if (color.contains('black')) return Colors.black;
    if (color.contains('white')) return Colors.white;
    if (color.contains('purple')) return Colors.purple;
    if (color.contains('gold') || color.contains('yellow')) return Colors.amber;
    if (color.contains('brown')) return Colors.brown;
    if (color.contains('grey') || color.contains('gray')) return Colors.grey;
    return Theme.of(context).primaryColor; // Fallback color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          onPressed: () => Get.back(), // GetX back navigation
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (controller) {
          // Loading State
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error State
          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          // Null Safety
          if (controller.product == null) {
            return const Center(child: Text('Product not found.'));
          }

          final product = controller.product!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Pass the product to the helper methods
                      _buildProductImageSlider(product),
                      _buildProductDetails(product),
                    ],
                  ),
                ),
              ),
              PriceAndAddToCartSection(
                // Dynamic Price
                price:'${product.currentPrice ?? 0}',
                onAddToCart: () {
                  print('Adding $_quantity of ${product.title} to cart');
                  // TODO: Call CartController here!
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductImageSlider(ProductModel product) {
    // Grab the photos, or use a dummy image if the array is empty
    final List<String> photos = (product.photos != null && product.photos!.isNotEmpty)
        ? product.photos!
        : ['https://via.placeholder.com/400'];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 1.0,
            enableInfiniteScroll: photos.length > 1,
            onPageChanged: (index, reason) {
              _currentSlideIndex.value = index;
            },
          ),
          items: photos.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2C2C2C)
                        : Colors.white, // White looks cleaner behind product photos
                  ),
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain, // Contain prevents cutting off the product
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        // Dot Indicator
        const SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: _currentSlideIndex,
          builder: (context, currentPage, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dynamically build dots based on photo count
                for (int i = 0; i < photos.length; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == currentPage
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.withOpacity(0.5),
                      border: i == currentPage
                          ? null
                          : Border.all(color: Colors.grey.shade400),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductDetails(ProductModel product) {
    // Safely map API color strings to Flutter Colors
    final List<Color> productColors = (product.colors ?? [])
        .map((c) => _getColorFromString(c))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title ?? 'Unknown Product', // Dynamic Title
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IncDecCounter(
                initialValue: 1,
                onChange: (newValue) {
                  setState(() {
                    _quantity = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const Text(' 4.8', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ReviewScreen.routeName);
                },
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              WishlistButtonWidget(
                isSelected: product.inWishlist ?? false, // Dynamic Wishlist
                onTap: () {
                  print('Toggled wishlist for ${product.title}');
                },
              ),
            ],
          ),

          // Only show Color section if the API actually returned colors
          if (productColors.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Color', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ColorPickerWidget(
                colors: productColors,
                onColorSelected: (color) {
                  print("Selected color: $color");
                }
            ),
          ],

          // Only show Size section if the API actually returned sizes
          if (product.sizes != null && product.sizes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Size', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SizePickerWidget(
                sizes: product.sizes!,
                onSizeSelected: (size) {
                  print("Selected size: $size");
                }
            ),
          ],

          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            product.description ?? 'No description available.', // Dynamic Description
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade400
                  : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}