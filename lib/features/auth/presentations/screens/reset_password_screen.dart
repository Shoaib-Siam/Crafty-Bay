import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/password_visibility_icon.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

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
                const SizedBox(height: 24),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum length password 8 character with Letter and number combination',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Password Field
                TextFormField(
                  controller: _passwordController, // Fixed Name
                  textInputAction: TextInputAction.next,
                  obscureText: !_passwordVisible,
                  obscuringCharacter: '•',
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: context.localization.password,
                    hintText: context.localization.enterYourPassword,
                    errorMaxLines: 2,
                    // Reusing your custom widget
                    suffixIcon: PasswordVisibilityIcon(
                      isVisible: _passwordVisible,
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: !_confirmPasswordVisible, // Fixed Logic
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    // Reusing your custom widget for consistency
                    suffixIcon: PasswordVisibilityIcon(
                      isVisible: _confirmPasswordVisible,
                      onTap: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Confirm your password';
                    }
                    // Fixed: Now comparing correctly against the first controller
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _onTapConfirmButton,
                  child: const Text('Confirm'),
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

  void _onTapConfirmButton() {
    if (_formKey.currentState!.validate()) {
      // TODO: Call API to Reset Password

      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.routeName,
        (route) => false,
      );
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
    // Fixed: Disposing correct variable names
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
