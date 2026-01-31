import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/app_logo.dart';
import '../widgets/password_visibility_icon.dart';
import '../widgets/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  String? _completePhoneNumber;

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
                  const SizedBox(height: 30),
                  AppLogo(),
                  SizedBox(height: 10),
                  Text(
                    context.localization.createNewAccount,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    context.localization.pleaseEnterYourDetails,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email
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

                  // First Name
                  TextFormField(
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: context.localization.firstName,
                      hintText: context.localization.enterYourFirstName,
                    ),
                    validator: Validators.validateFirstName,
                  ),
                  SizedBox(height: 15),

                  // Last Name
                  TextFormField(
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: context.localization.lastName,
                      hintText: context.localization.enterYourLastName,
                    ),
                    validator: Validators.validateLastName,
                  ),
                  SizedBox(height: 15),

                  //Mobile Number
                  IntlPhoneField(
                    initialCountryCode: 'BD',
                    decoration: InputDecoration(
                      labelText: context.localization.mobileNumber,
                      hintText: context.localization.enterYourMobileNumber,
                    ),
                    onChanged: (phone) {
                      _completePhoneNumber = phone.completeNumber;
                    },
                    validator: (phone) =>
                        Validators.validatePhone(phone?.completeNumber),
                  ),

                  SizedBox(height: 15),

                  // Address
                  TextFormField(
                    controller: _addressController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: context.localization.address,
                      hintText: context.localization.enterYourAddress,
                    ),
                    validator: Validators.validateAddress,
                  ),
                  SizedBox(height: 15),

                  // Password
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

                  // Sign Up Button
                  FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Text(context.localization.signUp),
                  ),
                  SizedBox(height: 10),

                  // Back to Sign In Button
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

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      // FIX: Close keyboard before navigating
      FocusScope.of(context).unfocus();
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.routeName,
            (route) => false,
      );
    }
  }

  void _onTapBackToSignInButton() {
    // FIX: Close keyboard before navigating
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
