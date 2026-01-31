import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../products/presentation/screens/product_list_screen.dart';
import '../../../shared/presentation/controller/main_nav_controller.dart';
import '../../../shared/presentation/widgets/category_item.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static const routeName = '/category-list';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final List<Map<String, dynamic>> categoryList = [
    {'title': 'Electronics', 'icon': Icons.computer},
    {'title': 'Fashion', 'icon': Icons.checkroom},
    {'title': 'Food', 'icon': Icons.fastfood},
    {'title': 'Furniture', 'icon': Icons.chair},
    {'title': 'Mobiles', 'icon': Icons.smartphone},
    {'title': 'Sports', 'icon': Icons.sports_soccer},
    {'title': 'Books', 'icon': Icons.menu_book},
    {'title': 'Toys', 'icon': Icons.toys},
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // FIX: Use onPopInvokedWithResult instead of onPopInvoked
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: categoryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            // inside itemBuilder...
            return CategoryItemWidget(
              title: categoryList[index]['title'],
              icon: categoryList[index]['icon'],
              onTap: () {
                // Navigate to ProductList and pass the Category Name as the argument
                Navigator.pushNamed(
                  context,
                  ProductListScreen.routeName,
                  arguments:
                      categoryList[index]['title'], // <--- Passing the String
                );
              },
            );
          },
        ),
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
