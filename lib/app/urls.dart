class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String verifyEmailUrl = '$_baseUrl/auth/verify-email';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String forgotPasswordUrl = '$_baseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  static const String readProfileUrl = '$_baseUrl/auth/profile';
  static const String updateProfileUrl = '$_baseUrl/auth/profile';

  // Home Screen APIs
  static const String slideListUrl = '$_baseUrl/slides';
  static const String categoryListUrl = '$_baseUrl/category-list';
  static const String productListUrl = '$_baseUrl/product-list';
  static const String brandListUrl = '$_baseUrl/brand-list';



}
