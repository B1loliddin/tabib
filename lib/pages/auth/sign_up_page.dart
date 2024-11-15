import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabib/services/auth_service.dart';
import 'package:tabib/widgets/custom_auth_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initAllControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeAllControllers();
  }

  /// #initializations
  void _initAllControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _disposeAllControllers() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  /// #main functions
  void _navigateToSignInPage() {
    Navigator.pushReplacementNamed(context, 'sign_in_page');
  }

  void _textFieldUnFocus() => FocusScope.of(context).unfocus();

  void _signUpButtonOnPressed() {
    if (formKey.currentState!.validate()) {
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      authService.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      Navigator.pushNamed(context, 'otp_verification_page');
    } else {
      // showShackBar(context, 'Form is invalid!');
    }
  }

  // String? _firstNameValidator(String? value) {
  //   final bool isCorrect = value?.isEmpty ?? true;
  //
  //   if (isCorrect) return 'First name needs to be filled!';
  //
  //   return null;
  // }
  //
  // String? _lastNameValidator(String? value) {
  //   final bool isCorrect = value?.isEmpty ?? true;
  //
  //   if (isCorrect) return 'Last name needs to be filled!';
  //
  //   return null;
  // }
  //
  // String? _emailValidator(String? value) {
  //   final regExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   final bool isCorrect = value?.contains(regExp) ?? false;
  //
  //   if (!isCorrect) return 'Correct your email!';
  //
  //   return null;
  // }
  //
  // String? _passwordValidator(String? value) {
  //   final bool isCorrect = value?.isEmpty ?? true;
  //
  //   if (isCorrect) return 'Password needs to be filled!';
  //
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: _textFieldUnFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sign Up Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// #
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomAuthTextFormField(
                          hintText: 'First Name',
                          controller: _firstNameController,
                          // validator: _firstNameValidator,
                        ),
                        SizedBox(height: 20),
                        CustomAuthTextFormField(
                          hintText: 'Last Name',
                          controller: _lastNameController,
                          // validator: _lastNameValidator,
                        ),
                        SizedBox(height: 20),
                        CustomAuthTextFormField(
                          hintText: 'Email',
                          controller: _emailController,
                          // validator: _emailValidator,
                        ),
                        SizedBox(height: 20),
                        CustomAuthTextFormField(
                          hintText: 'Password',
                          controller: _passwordController,
                          // validator: _passwordValidator,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  /// #
                  ElevatedButton(
                    onPressed: _signUpButtonOnPressed,
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 20),

                  /// #
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _navigateToSignInPage,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: keyboardHeight),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
