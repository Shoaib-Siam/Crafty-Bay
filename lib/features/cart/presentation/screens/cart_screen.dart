import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../products/presentation/widgets/price_and_add_to_cart_section.dart'; // Import reusable widget
import '../../../shared/presentation/controller/main_nav_controller.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          onPressed: () {
            // FIX: Check if we can pop first
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } _backToHome();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          // 1. List of Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Dummy count
              itemBuilder: (context, index) {
                return CartItemWidget(
                  title: 'Nike Shoe 12K Air',
                  color: 'Red',
                  size: 'XL',
                  price: '1200',
                  quantity: 1,
                  onQuantityChanged: (newQty) {
                    // TODO: Update logic
                  },
                  onDelete: () {
                    // TODO: Delete logic
                  },
                );
              },
            ),
          ),

          // 2. Reused Bottom Section for Checkout
          PriceAndAddToCartSection(
            price: '4800', // Total Price
            buttonText: 'Checkout', // Changed text from "Add to Cart"
            onAddToCart: () {
              // Navigate to Checkout Screen
            },
          ),
        ],
      ),
    );
  }
  void _backToHome() {
    Get.find<MainNavController>().backToHome();
    // Note: If 'backToHome' inside the controller already changes the tab index,
    // you might not need Get.back() if this screen is just a tab view.
    // But if this screen was PUSHED on top (Navigator.push), then Get.back() is correct.
    Get.back();
  }
}