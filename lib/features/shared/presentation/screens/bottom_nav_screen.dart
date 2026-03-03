import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../../features/category/presentation/screens/category_list_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../controller/category_controller.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../controller/main_nav_controller.dart';
import '../../../home/controller/slider_controller.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String routeName = '/main-bottom-nav';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  // The screens list moves inside the State class
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishlistScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch data as soon as the main navigation loads
    Get.find<SliderController>().getSliders();
    Get.find<CategoryController>().getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavController>(
      builder: (controller) {
        return Scaffold(
          body: _screens[controller.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: (int index) {
              controller.changeIndex(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.category),
                label: 'Categories',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}
