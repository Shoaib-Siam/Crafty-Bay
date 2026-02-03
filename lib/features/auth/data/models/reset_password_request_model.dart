class ResetPasswordRequestModel {
  final String email;
  final String otp;
  final String password;

  ResetPasswordRequestModel({
    required this.email,
    required this.otp,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "OTP": otp, // Note: API often expects "OTP" capitalized
      "password": password,
    };
  }
}