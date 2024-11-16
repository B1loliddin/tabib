import 'package:flutter/material.dart';
import 'package:tabib/services/auth_service.dart';
import 'package:tabib/widgets/custom_otp_text_form_field.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNumberController;
  late final TextEditingController _secondNumberController;
  late final TextEditingController _thirdNumberController;
  late final TextEditingController _fourthNumberController;
  late final TextEditingController _fifthNumberController;
  late final TextEditingController _sixthNumberController;

  late final FocusNode _firstNumberFocusNode;
  late final FocusNode _secondNumberFocusNode;
  late final FocusNode _thirdNumberFocusNode;
  late final FocusNode _fourthNumberFocusNode;
  late final FocusNode _fifthNumberFocusNode;
  late final FocusNode _sixthNumberFocusNode;

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
    _firstNumberController = TextEditingController();
    _secondNumberController = TextEditingController();
    _thirdNumberController = TextEditingController();
    _fourthNumberController = TextEditingController();
    _fifthNumberController = TextEditingController();
    _sixthNumberController = TextEditingController();

    _firstNumberFocusNode = FocusNode();
    _secondNumberFocusNode = FocusNode();
    _thirdNumberFocusNode = FocusNode();
    _fourthNumberFocusNode = FocusNode();
    _fifthNumberFocusNode = FocusNode();
    _sixthNumberFocusNode = FocusNode();
  }

  void _disposeAllControllers() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    _thirdNumberController.dispose();
    _fourthNumberController.dispose();
    _fifthNumberController.dispose();
    _sixthNumberController.dispose();

    _firstNumberFocusNode.dispose();
    _secondNumberFocusNode.dispose();
    _thirdNumberFocusNode.dispose();
    _fourthNumberFocusNode.dispose();
    _fifthNumberFocusNode.dispose();
    _sixthNumberFocusNode.dispose();
  }

  /// #main functions
  void _submitButtonOnPressed() {
    if (formKey.currentState!.validate()) {
      final int firstNumber = int.parse(_firstNumberController.text.trim());
      final int secondNumber = int.parse(_secondNumberController.text.trim());
      final int thirdNumber = int.parse(_thirdNumberController.text.trim());
      final int fourthNumber = int.parse(_fourthNumberController.text.trim());
      final int fifthNumber = int.parse(_fifthNumberController.text.trim());
      final int sixthNumber = int.parse(_sixthNumberController.text.trim());
      final String activationCode =
          '$firstNumber$secondNumber$thirdNumber$fourthNumber$fifthNumber$sixthNumber';

      authService.verifyOtp(
        int.parse(activationCode),
        widget.email,
      );
    } else {
      // showShackBar(context, 'Form is invalid!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),

          /// #otp
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomOtpTextFormField(
                  controller: _firstNumberController,
                  focusNode: _firstNumberFocusNode,
                  rightFocusNode: _secondNumberFocusNode,
                ),
                CustomOtpTextFormField(
                  controller: _secondNumberController,
                  focusNode: _secondNumberFocusNode,
                  leftFocusNode: _firstNumberFocusNode,
                  rightFocusNode: _thirdNumberFocusNode,
                ),
                CustomOtpTextFormField(
                  controller: _thirdNumberController,
                  focusNode: _thirdNumberFocusNode,
                  leftFocusNode: _secondNumberFocusNode,
                  rightFocusNode: _fourthNumberFocusNode,
                ),
                CustomOtpTextFormField(
                  controller: _fourthNumberController,
                  focusNode: _fourthNumberFocusNode,
                  leftFocusNode: _thirdNumberFocusNode,
                  rightFocusNode: _fifthNumberFocusNode,
                ),
                CustomOtpTextFormField(
                  controller: _fifthNumberController,
                  focusNode: _fifthNumberFocusNode,
                  leftFocusNode: _fourthNumberFocusNode,
                  rightFocusNode: _sixthNumberFocusNode,
                ),
                CustomOtpTextFormField(
                  controller: _sixthNumberController,
                  focusNode: _sixthNumberFocusNode,
                  leftFocusNode: _fifthNumberFocusNode,
                  rightFocusNode: _firstNumberFocusNode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          /// #submit
          ElevatedButton(
            onPressed: _submitButtonOnPressed,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
