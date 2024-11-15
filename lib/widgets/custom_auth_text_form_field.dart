import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomAuthTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
