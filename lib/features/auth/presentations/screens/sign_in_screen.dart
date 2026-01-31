import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/password_visibility_icon.dart';
import 'package:crafty_bay/features/auth/presentations/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../shared/presentation/screens/bottom_nav_screen.dart';
import '../widgets/app_logo.dart';
import 'email_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _signInInProgress = false;

  bool _passwordVisible = false;

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
                  AppLogo(),
                  SizedBox(height: 15),
                  Text(
                    context.localization.welcomeBack,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    context.localization.enterYourEmailAndPassword,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: context.localization.email,
                      hintText: context.localization.enterYourEmail,
                    ),
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
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

                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Text(context.localization.signIn),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text(
                            context.localization.forgotPassword,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.localization.dontHaveAccount,
                            // FIX: Inherit from Theme to get the Global Font
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                            children: [
                              TextSpan(
                                text: context.localization.signUp,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.4,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignUpButton,
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      // FIX: Close keyboard before navigating
      FocusScope.of(context).unfocus();
    }
    Navigator.pushReplacementNamed(context, MainBottomNavScreen.routeName);
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, EmailVerificationScreen.routeName);
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
