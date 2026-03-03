import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/slider_controller.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
      builder: (sliderController) {
        // 1. Loading State
        if (sliderController.inProgress) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Error State
        if (sliderController.errorMessage != null) {
          return SizedBox(
            height: 180,
            child: Center(child: Text(sliderController.errorMessage!)),
          );
        }

        // 3. Empty State
        if (sliderController.sliderList.isEmpty) {
          return const SizedBox(
            height: 180,
            child: Center(child: Text("No banners available")),
          );
        }

        // 4. Success State (Show Data)
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1,
                onPageChanged: (index, _) {
                  _selectedSlider.value = index;
                },
              ),
              items: sliderController.sliderList.map((sliderData) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        // Display the image from API
                        image: DecorationImage(
                          image: NetworkImage(sliderData.photoUrl ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _selectedSlider,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Make the dots match the number of sliders from API
                    for (int i = 0; i < sliderController.sliderList.length; i++)
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: value == i
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
