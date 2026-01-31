import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/screens/reset_password_screen.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/app_logo.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  static const String routeName = '/otp-verify';

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                    context.localization.a6DigitCodeHasBeenSentToYourEmailAddress,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // FIX STARTS HERE
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    appContext: context,
                    controller: _otpController,
                    keyboardType: TextInputType.number,

                    // 1. REMOVE THE SHADOW (Grey Box)
                    backgroundColor: Colors.transparent,

                    // 2. Enable fill so we can control the inside color
                    enableActiveFill: true,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,

                      // 3. FIX COLORS FOR DARK MODE
                      // Instead of Colors.white, use transparent.
                      // This ensures no white blocks appear in Dark Mode.
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      selectedFillColor: Colors.transparent,

                      // Borders
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Colors.grey, // Grey border when not focused
                      selectedColor: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) => Validators.validateOTP(value),
                  ),
                  // FIX ENDS HERE

                  const SizedBox(height: 15),

                  FilledButton(
                    onPressed: _onVerifyButton,
                    child: Text(context.localization.verify),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: _onTapBackToSignInButton,
                    child: Text(
                      context.localization.backToSignIn,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
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

  void _onVerifyButton() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, ResetPasswordScreen.routeName);
    }
  }

  void _onTapBackToSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
          (route) => false,
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}