import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomUserSpecificationsTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const CustomUserSpecificationsTextFormField({
    super.key,
    required this.controller,
    required this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 90,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        textInputAction: TextInputAction.next,
        style: Theme.of(context).textTheme.headlineMedium,
        keyboardType: keyboardType,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        inputFormatters: inputFormatters,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return 'Fill it!';
          }

          return null;
        },
      ),
    );
  }
}
