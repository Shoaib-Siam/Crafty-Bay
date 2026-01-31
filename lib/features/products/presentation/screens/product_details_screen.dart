import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import '../../../reviews/presentation/screens/review_screen.dart';
import '../../../shared/presentation/widgets/inc_dec_counter.dart';
import '../../../shared/presentation/widgets/wishlist_button.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String routeName = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<int> _currentSlideIndex = ValueNotifier(0);

  // Track quantity here if you need to send it to the cart
  int _quantity = 1;

  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.brown,
    Colors.white,
    Colors.blueGrey,
  ];
  List<String> sizes = ['M', 'X', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [_buildProductImageSlider(), _buildProductDetails()],
              ),
            ),
          ),
          PriceAndAddToCartSection(
            price: '1,000',
            onAddToCart: () {
              // Add your cart logic here
              print('Adding $_quantity item(s) to cart');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductImageSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,

            viewportFraction: 1.0, // Full width

            enableInfiniteScroll: false, // Stop at the end

            onPageChanged: (index, reason) {
              _currentSlideIndex.value = index;
            },
          ),

          // Fake Images: Replace [1,2,3] with your real image URLs later
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2C2C2C)
                        : Colors.grey.shade200,
                  ),

                  child: Center(
                    child: Text(
                      'Image $i', // Placeholder content

                      style: TextStyle(
                        fontSize: 24,

                        color: Colors.grey.shade500,
                      ),
                    ),

                    // Use Image.network() here in the real app

                    // child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        ),

        // 3. Dot Indicator
        const SizedBox(height: 10),

        ValueListenableBuilder(
          valueListenable: _currentSlideIndex,

          builder: (context, currentPage, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    width: 12,

                    height: 12,

                    margin: const EdgeInsets.symmetric(horizontal: 4),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: i == currentPage
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.withOpacity(0.5),

                      // Add border for better visibility on white backgrounds
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

  Widget _buildProductDetails() {
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
                  'Nike Court Vision Low Next Nature',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // FIX: Use the new Reusable Widget here
              IncDecCounter(
                initialValue: 1,
                onChange: (newValue) {
                  setState(() {
                    _quantity = newValue;
                  });
                  print("Selected Quantity: $_quantity");
                },
              ),
            ],
          ),
          // ... (Rest of the method remains exactly the same)
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const Text(' 4.8', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  // FIX: Navigate to the Review Screen
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
                isSelected: true, // Example: This item is already in wishlist
                onTap: () {
                  print('Added to wishlist!');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Color', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ColorPickerWidget(colors: colors, onColorSelected: (color) {}),
          const SizedBox(height: 16),
          Text('Size', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SizePickerWidget(sizes: sizes, onSizeSelected: (size) {}),
          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Reference site about Lorem Ipsum...',
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
