import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/presentation/controller/main_nav_controller.dart';
// TODO: Update this import to match your project structure
import '../../../shared/presentation/widgets/product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String routeName = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,

            // FIX: Change this value to 220 or higher
            // (It was likely around 170-180 before, which caused the crash)
            mainAxisExtent: 220,

            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return const ProductCardWidget();
          },
        ),
      ),
    );
  }

  void _backToHome() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // If used as a Tab, switch back to Home Tab
      Get.find<MainNavController>().backToHome();
    }
  }
}
