import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/presentation/controller/category_controller.dart';
import '../../../products/presentation/screens/product_list_screen.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap with GetBuilder to listen for API data
    return GetBuilder<CategoryController>(
      builder: (categoryController) {

        // 1. Loading State
        if (categoryController.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Error State
        if (categoryController.errorMessage != null) {
          return SizedBox(
            height: 100,
            child: Center(child: Text(categoryController.errorMessage!)),
          );
        }

        // 3. Empty State
        if (categoryController.categoryList.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(child: Text("No categories found")),
          );
        }

        // 4. Success State (The Horizontal List)
        return SizedBox(
          height: 100, // Adjusted slightly to fit the image and text nicely
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categoryController.categoryList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categoryController.categoryList[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductListScreen(
                    categoryName: category.title ?? 'Unknown',
                    categoryId: category.sId ?? '',
                  ));
                },
                child: Column(
                  children: [
                    // Network Image Container
                    Container(
                      height: 65,
                      width: 65,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        category.icon ?? '',
                        fit: BoxFit.scaleDown,
                        // Show a fallback icon if the URL is broken
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Category Title
                    Text(
                      category.title ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}