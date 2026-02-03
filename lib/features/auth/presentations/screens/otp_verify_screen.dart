import 'dart:async';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_request_model.dart';
import 'package:crafty_bay/features/auth/presentations/screens/reset_password_screen.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/email_verification_controller.dart';
import '../controllers/otp_verification_controller.dart';
import '../widgets/app_logo.dart';

class OtpVerifyScreen extends StatefulWidget {
  // FIX: Added fields to the constructor
  const OtpVerifyScreen({
    super.key,
    required this.email,
    this.isPasswordReset = false,
  });

  static const String routeName = '/otp-verify';

  final String email;
  final bool isPasswordReset;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Use Get.put to ensure controller is available if not already
  final OtpVerificationController _otpVerificationController = Get.put(
    OtpVerificationController(),
  );

  // Timer Variables
  int _secondsRemaining = 60;
  bool _enableResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // No need to fetch Get.arguments here anymore.
    // We use widget.email and widget.isPasswordReset directly.
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _enableResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _enableResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  const AppLogo(),
                  const SizedBox(height: 15),
                  Text(
                    context.localization.verifyOTP,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    context
                        .localization
                        .a6DigitCodeHasBeenSentToYourEmailAddress,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    appContext: context,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      selectedFillColor: Colors.transparent,
                      activeColor: primaryColor,
                      inactiveColor: Colors.grey,
                      selectedColor: primaryColor,
                    ),
                    validator: (value) => Validators.validateOTP(value),
                  ),

                  const SizedBox(height: 15),

                  GetBuilder<OtpVerificationController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CircularProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onVerifyButton,
                          child: Text(context.localization.verify),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  RichText(
                    text: TextSpan(
                      text: 'This code will expire in ',
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: '${_secondsRemaining}s',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  TextButton(
                    onPressed: _enableResend ? _onTapResendCode : null,
                    style: TextButton.styleFrom(
                      foregroundColor: _enableResend
                          ? primaryColor
                          : Colors.grey,
                    ),
                    child: const Text('Resend Code'),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _onTapBackToSignInButton,
                    child: Text(
                      context.localization.backToSignIn,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onVerifyButton() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final otp = _otpController.text;

      // 1. Use the widget.email property
      VerifyOtpRequestModel model = VerifyOtpRequestModel(
        email: widget.email,
        otp: otp,
      );

      final bool result = await _otpVerificationController.verifyOtp(model);

      if (result) {
        // 2. Use the widget.isPasswordReset property
        if (widget.isPasswordReset) {
          Get.toNamed(
            ResetPasswordScreen.routeName,
            // Pass arguments safely to the next screen
            arguments: {'email': widget.email, 'otp': otp},
          );
        } else {
          Get.offAllNamed(SignInScreen.routeName);
        }
      }
    }
  }

  Future<void> _onTapResendCode() async {
    _startTimer();
    final EmailVerificationController controller = Get.put(
      EmailVerificationController(),
    );
    await controller.verifyEmail(widget.email);
    _otpController.clear();
  }

  void _onTapBackToSignInButton() {
    FocusScope.of(context).unfocus();
    Get.offAllNamed(SignInScreen.routeName);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }
}
