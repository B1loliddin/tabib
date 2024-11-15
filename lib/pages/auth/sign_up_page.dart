import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
                    child: Column(
                      children: [
                        CustomAuthTextFormField(
                          hintText: 'First Name',
                          controller: _firstNameController,
                        ),
                        SizedBox(height: 20),
                        CustomAuthTextFormField(
                          hintText: 'Last Name',
                          controller: _lastNameController,
                        ),
                        SizedBox(height: 20),
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
