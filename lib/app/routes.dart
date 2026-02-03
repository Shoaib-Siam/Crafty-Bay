import 'package:flutter/material.dart';

import '../features/auth/presentations/screens/email_verification_screen.dart';
import '../features/auth/presentations/screens/otp_verify_screen.dart';
import '../features/auth/presentations/screens/reset_password_screen.dart';
import '../features/auth/presentations/screens/sign_in_screen.dart';
import '../features/auth/presentations/screens/sign_up_screen.dart';
import '../features/auth/presentations/screens/splash_screen.dart';
import '../features/cart/presentation/screens/cart_screen.dart';
import '../features/category/presentation/screens/category_list_screen.dart';
import '../features/notifications/presentation/screens/notification_screen.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/product_list_screen.dart';
import '../features/reviews/presentation/screens/create_review_screen.dart';
import '../features/reviews/presentation/screens/review_screen.dart';
import '../features/settings/presentation/screens/account_settings_screen.dart';
import '../features/settings/presentation/screens/change_password_screen.dart';
import '../features/settings/presentation/screens/edit_profile_screen.dart';
import '../features/shared/presentation/screens/bottom_nav_screen.dart';
import '../features/wishlist/presentation/screens/wishlist_screen.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;
  if (settings.name == SplashScreen.routeName) {
    screen = SplashScreen();
  } else if (settings.name == SignInScreen.routeName) {
    screen = SignInScreen();
  } else if (settings.name == EmailVerificationScreen.routeName) {
    screen = EmailVerificationScreen();
  } else if (settings.name == ResetPasswordScreen.routeName) {
    screen = const ResetPasswordScreen();
  } else if (settings.name == SignUpScreen.routeName) {
    screen = SignUpScreen();
  }
  else if (settings.name == OtpVerifyScreen.routeName) {
    final args = settings.arguments as Map<String, dynamic>;
    screen = OtpVerifyScreen(
      email: args['email'],
      isPasswordReset: args['isPasswordReset'] ?? false,
    );
  } else if (settings.name == MainBottomNavScreen.routeName) {
    screen = MainBottomNavScreen();
  } else if (settings.name == ProductDetailsScreen.routeName) {
    screen = ProductDetailsScreen();
  } else if (settings.name == CategoryListScreen.routeName) {
    screen = CategoryListScreen();
  } else if (settings.name == ProductListScreen.routeName) {
    final String categoryName = settings.arguments as String;
    screen = ProductListScreen(categoryName: categoryName);
  } else if (settings.name == ReviewScreen.routeName) {
    screen = const ReviewScreen();
  } else if (settings.name == CreateReviewScreen.routeName) {
    screen = const CreateReviewScreen();
  } else if (settings.name == CartScreen.routeName) {
    screen = const CartScreen();
  } else if (settings.name == WishlistScreen.routeName) {
    screen = const WishlistScreen();
  } else if (settings.name == NotificationScreen.routeName) {
    screen = const NotificationScreen();
  } else if (settings.name == AccountSettingsScreen.routeName) {
    screen = const AccountSettingsScreen();
  } else if (settings.name == EditProfileScreen.routeName) {
    screen = const EditProfileScreen();
  } else if (settings.name == ChangePasswordScreen.routeName) {
    screen = const ChangePasswordScreen();
  } else {
    screen = SplashScreen();
  }

  return MaterialPageRoute(builder: (context) => screen);
}
