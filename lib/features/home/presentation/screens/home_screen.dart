import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/presentation/controller/main_nav_controller.dart';
import '../widgets/home_banner_slider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/category_list_view.dart';
import '../widgets/product_list_view.dart';
import '../widgets/search_text_field.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SearchTextField(textEditingController: null),
              const SizedBox(height: 16),
              const HomeBannerSlider(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'All Categories',
                onTap: () {
                  Get.find<MainNavController>().backToCategory();
                },
              ),
              const SizedBox(height: 8),
              const CategoryListView(),
              const SizedBox(height: 16),

              SectionHeader(title: 'Popular', onTap: _onTapPopular),
              const SizedBox(height: 8),
              // Pass the 'popular' enum!
              const ProductListView(listType: ProductListType.popular),

              const SizedBox(height: 16),
              SectionHeader(title: 'Special', onTap: _onTapSpecial),
              const SizedBox(height: 8),
              // Pass the 'special' enum!
              const ProductListView(listType: ProductListType.special),

              const SizedBox(height: 16),
              SectionHeader(title: 'New', onTap: _onTapNew),
              const SizedBox(height: 8),
              // Pass the 'newArrivals' enum!
              const ProductListView(listType: ProductListType.newArrivals),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapPopular() {}
  void _onTapSpecial() {}
  void _onTapNew() {}
}