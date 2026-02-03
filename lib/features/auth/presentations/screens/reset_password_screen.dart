import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/reset_password_request_model.dart';
import '../controllers/reset_password_controller.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ResetPasswordController _controller = Get.put(ResetPasswordController());

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // Arguments
  late String _email;
  late String _otp;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map;
    _email = args['email'];
    _otp = args['otp'];
  }

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
                const SizedBox(height: 24),
                Text('Set Password', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'Minimum length password 8 character with Letter and number combination',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Password Field
                TextFormField(
                  controller: _passwordController,
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
                  obscureText: !_confirmPasswordVisible,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
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
                    if (value?.isEmpty ?? true) return 'Confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                GetBuilder<ResetPasswordController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CircularProgressIndicator(),
                        child: FilledButton(
                          onPressed: _onTapConfirmButton,
                          child: const Text('Confirm'),
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

  Future<void> _onTapConfirmButton() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      ResetPasswordRequestModel model = ResetPasswordRequestModel(
        email: _email,
        otp: _otp,
        password: _passwordController.text,
      );

      final bool result = await _controller.resetPassword(model);

      if (result) {
        Get.snackbar('Success', 'Password has been reset successfully');
        Get.offAllNamed(SignInScreen.routeName);
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}