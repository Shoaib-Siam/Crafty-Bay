import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/presentation/controller/product_controller.dart';
import '../../../shared/presentation/widgets/product_card.dart';

// 1. Create a simple enum to identify which list we want
enum ProductListType { popular, special, newArrivals }

class ProductListView extends StatelessWidget {
  // 2. Require the type when creating the widget
  final ProductListType listType;

  const ProductListView({super.key, required this.listType});

  @override
  Widget build(BuildContext context) {
    // 3. Wrap in GetBuilder to listen to the API data dynamically
    return GetBuilder<ProductController>(
      builder: (productController) {
        bool inProgress = false;
        String? errorMessage;
        List<dynamic> productList = []; // Holds the ProductModel items

        // 4. Check which list this specific widget is supposed to render
        if (listType == ProductListType.popular) {
          inProgress = productController.popularInProgress;
          errorMessage = productController.popularErrorMessage;
          productList = productController.popularProductList;
        } else if (listType == ProductListType.special) {
          inProgress = productController.specialInProgress;
          errorMessage = productController.specialErrorMessage;
          productList = productController.specialProductList;
        } else if (listType == ProductListType.newArrivals) {
          inProgress = productController.newInProgress;
          errorMessage = productController.newErrorMessage;
          productList = productController.newProductList;
        }

        // Loading State
        if (inProgress) {
          return const SizedBox(
            height: 190,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // Error State
        if (errorMessage != null) {
          return SizedBox(
            height: 190,
            child: Center(child: Text(errorMessage)),
          );
        }

        // Empty State
        if (productList.isEmpty) {
          return const SizedBox(
            height: 190,
            child: Center(child: Text('No products found.')),
          );
        }

        // Success State
        return SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              // 5. Pass the actual product data to your card widget!
              return ProductCardWidget(product: productList[index]);
            },
          ),
        );
      },
    );
  }
}
