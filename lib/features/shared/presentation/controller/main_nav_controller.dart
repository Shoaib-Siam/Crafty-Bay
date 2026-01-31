import 'package:get/get.dart';

class MainNavController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  // CHANGED: Removed the underscore '_' to make it public
  void changeIndex(int index) {
    if (_selectedIndex == index) {
      return;
    }
    _selectedIndex = index;
    update(); // This notifies the UI to redraw
  }

  // A helper to go back to Home (Index 0)
  void backToHome() {
    changeIndex(0);
  }

  void backToCategory() {
    changeIndex(1);
  }

  void backToCart() {
    changeIndex(2);
  }

  void backToWishlist() {
    changeIndex(3);
  }
}
