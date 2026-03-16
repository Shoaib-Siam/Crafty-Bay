import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/presentation/controller/product_list_by_category_controller.dart';
import '../../../shared/presentation/widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  // 1. ADD categoryId here!
  const ProductListScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  static const String routeName = '/product-list';

  final String categoryName;
  final String categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // 2. Fetch the specific products the moment this screen opens!
    Get.find<ProductListByCategoryController>().getProductListByCategory(
      widget.categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      // 3. Wrap the body in GetBuilder to listen to the new controller
      body: GetBuilder<ProductListByCategoryController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.productList.isEmpty) {
            return const Center(
              child: Text('No products found in this category.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.productList.length, // DYNAMIC COUNT
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 220,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              // 4. Pass the REAL product to your card!
              return ProductCardWidget(product: controller.productList[index]);
            },
          );
        },
      ),
    );
  }
}
