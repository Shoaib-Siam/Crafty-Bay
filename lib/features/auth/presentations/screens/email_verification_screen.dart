import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import 'otp_verify_screen.dart'; // We will navigate here next

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String routeName = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                FilledButton(
                  onPressed: _onTapNextButton,
                  child: const Text('Next'),
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

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      // TODO: Call API to send OTP to this email

      // Navigate to OTP Screen
      Navigator.pushNamed(context, OtpVerifyScreen.routeName);
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
    _emailTEController.dispose();
    super.dispose();
  }
}