import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../../features/category/presentation/screens/category_list_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../controller/main_nav_controller.dart'; // Import your controller

class MainBottomNavScreen extends StatelessWidget {
  const MainBottomNavScreen({super.key});

  static const String routeName = '/main-bottom-nav';

  // We define the screens list as static or inside the build method
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // GetBuilder listens to the MainNavController we injected in ControllerBinder
    return GetBuilder<MainNavController>(
      builder: (controller) {
        return Scaffold(
          body: _screens[controller.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: (int index) {
              // Call the method from the controller
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
