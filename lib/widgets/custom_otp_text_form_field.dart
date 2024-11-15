import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? leftFocusNode;
  final FocusNode rightFocusNode;

  const CustomOtpTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.rightFocusNode,
    this.leftFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 60,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headlineMedium,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            rightFocusNode.requestFocus();
          } else {
            leftFocusNode?.requestFocus();
          }
        },
      ),
    );
  }
}
