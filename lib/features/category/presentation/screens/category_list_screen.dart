import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../products/presentation/screens/product_list_screen.dart';
import '../../../shared/presentation/controller/category_controller.dart';
import '../../../shared/presentation/controller/main_nav_controller.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static const routeName = '/category-list';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  // 1. Create a ScrollController
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 2. Attach a listener to detect scrolling
    _scrollController.addListener(_onScroll);
  }

  // 3. This function checks if the user hit the bottom of the list
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final categoryController = Get.find<CategoryController>();

      // If we aren't already loading, fetch the next page!
      if (!categoryController.getCategoryInProgress) {
        categoryController.getCategoryList();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Always dispose controllers to save memory
    super.dispose();
  }

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
          title: const Text('Categories'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CategoryController>(
          builder: (categoryController) {

            // Initial Full-Screen Loading (Page 1)
            if (categoryController.isInitialLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (categoryController.errorMessage != null) {
              return Center(child: Text(categoryController.errorMessage!));
            }

            if (categoryController.categoryList.isEmpty) {
              return const Center(child: Text("No categories found."));
            }

            // Wrap in a Column to show a loader at the very bottom
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController, // 4. Attach the controller here
                    padding: const EdgeInsets.all(12),
                    itemCount: categoryController.categoryList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.82,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                    ),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                category.icon ?? '',
                                fit: BoxFit.scaleDown,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.title ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 5. Show a small loading spinner at the bottom when fetching page 2, 3, etc.
                if (categoryController.getCategoryInProgress)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainNavController>().backToHome();
  }
}