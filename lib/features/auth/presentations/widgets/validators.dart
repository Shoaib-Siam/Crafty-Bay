class Validators {
  // Email: standard
  static final RegExp emailRegex =
  RegExp(r"^[\w+-.]+@([\w-]+\.)+[a-zA-Z]{2,}$");

  // Password: min 8 chars, at least 1 letter, 1 number
  static final RegExp passwordRegex =
  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // Name: letters (any language), space, hyphen, apostrophe, min 2 chars
  static final RegExp nameRegex =
  RegExp(r"^[\p{L}\s'-]{2,50}$", unicode: true);

  // Phone: optional +, digits only, 8–15 digits
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

  // Address: letters, numbers, spaces, common symbols
  static final RegExp addressRegex =
  RegExp(r"^[\p{L}0-9\s,.\-/#]{5,100}$", unicode: true);

  // OTP: exactly 6 digits
  static final RegExp otpRegex = RegExp(r'^\d{4}$');

  // REVIEW REGEX (New)
  // [\s\S] matches ANY character including newlines (Enter key).
  // {10,} means it must be at least 10 characters long.
  static final RegExp reviewRegex = RegExp(r'^[\s\S]{10,}$');

  // ------------------ Validators ------------------

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your first name';
    } else if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid first name';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your last name';
    } else if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid last name';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your mobile number';
    } else if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your address';
    } else if (!addressRegex.hasMatch(value.trim())) {
      return 'Enter a valid address';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must be 8+ chars with a letter and number';
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the OTP';
    } else if (!otpRegex.hasMatch(value)) {
      return 'OTP must be exactly 6 digits';
    }
    return null;
  }

  // REVIEW VALIDATOR (New)
  static String? validateReview(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please write your review';
    } else if (!reviewRegex.hasMatch(value)) {
      return 'Review must be at least 10 characters long';
    }
    return null;
  }
}