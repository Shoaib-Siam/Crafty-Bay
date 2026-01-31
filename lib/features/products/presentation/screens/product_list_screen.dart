import 'package:flutter/material.dart';
// TODO: Update this import to match your project structure
import '../../../shared/presentation/widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryName});

  static const String routeName = '/product-list';

  final String categoryName; // Pass the category name (e.g., "Electronics")

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName), // Dynamic title
        leading: IconButton(
          onPressed: () {
            // Standard generic back navigation
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      // ... inside build method
      // ... inside build method
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,

          // FIX: Match the height here too
          mainAxisExtent: 220,

          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return const ProductCardWidget();
        },
      ),
    );
  }
}
