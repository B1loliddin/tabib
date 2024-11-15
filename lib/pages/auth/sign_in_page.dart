import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
                child: Column(
                  children: [
                    CustomAuthTextFormField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),
                    CustomAuthTextFormField(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              /// #
              ElevatedButton(
                onPressed: () {},
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
