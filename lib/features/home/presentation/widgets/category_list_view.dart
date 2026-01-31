import 'package:flutter/material.dart';
// Adjust this import path if needed to match where you put the widget
import '../../../products/presentation/screens/product_list_screen.dart';
import '../../../shared/presentation/widgets/category_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  // Sample Data for the Home Screen Horizontal List
  final List<Map<String, dynamic>> categories = const [
    {'title': 'Electronics', 'icon': Icons.computer},
    {'title': 'Fashion', 'icon': Icons.checkroom},
    {'title': 'Food', 'icon': Icons.fastfood},
    {'title': 'Mobiles', 'icon': Icons.smartphone},
    {'title': 'Furniture', 'icon': Icons.chair},
    {'title': 'Sports', 'icon': Icons.sports_soccer},
    {'title': 'Books', 'icon': Icons.menu_book},
    {'title': 'Toys', 'icon': Icons.toys},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ), // Add padding for better look
        itemCount: categories.length, // Use actual list length
        separatorBuilder: (_, __) =>
            const SizedBox(width: 16), // Wider spacing looks cleaner
        itemBuilder: (context, index) {
          return CategoryItemWidget(
            title: categories[index]['title'],
            icon: categories[index]['icon'],
            // inside your horizontal list builder...
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductListScreen.routeName,
                arguments: categories[index]['title'],
              );
            },
          );
        },
      ),
    );
  }
}
