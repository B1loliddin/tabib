import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabib/services/auth_service.dart';
import 'package:tabib/widgets/custom_auth_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
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
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _disposeAllControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  /// #main functions
  void _navigateToSignUpPage() {
    Navigator.pushReplacementNamed(context, 'sign_up_page');
  }

  void _textFieldUnFocus() => FocusScope.of(context).unfocus();

  void _signInButtonOnPressed() {
    if (formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      authService.signIn(
        email: email,
        password: password,
      );
    } else {
      // showShackBar(context, 'Form is invalid!');
    }
  }

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
          title: Text('Sign In Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// #
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                onPressed: _signInButtonOnPressed,
                child: Text('Sign In'),
              ),
              SizedBox(height: 20),

              /// #
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _navigateToSignUpPage,
                    ),
                  ],
                ),
              ),

              SizedBox(height: keyboardHeight),
            ],
          ),
        ),
      ),
    );
  }
}
