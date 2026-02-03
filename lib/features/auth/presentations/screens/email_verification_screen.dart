import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/email_verification_controller.dart';
import '../widgets/app_logo.dart';
import 'otp_verify_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String routeName = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EmailVerificationController _controller = Get.put(EmailVerificationController());

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const AppLogo(),
                const SizedBox(height: 20),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your email address',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email Address'),
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 20),

                GetBuilder<EmailVerificationController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CircularProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onTapNextButton,
                          child: const Text('Next'),
                        ),
                      );
                    }
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
    );
  }

  Future<void> _onTapNextButton() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      String email = _emailTEController.text.trim();
      final bool result = await _controller.verifyEmail(email);

      if (result) {
        // Navigate and pass data: Email & Flag
        Get.toNamed(
            OtpVerifyScreen.routeName,
            arguments: {
              'email': email,
              'isPasswordReset': true // Because this screen is for Forgot Password
            }
        );
      }
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  void _onTapBackToSignInButton() {
    FocusScope.of(context).unfocus();
    Get.offAllNamed(SignInScreen.routeName);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}