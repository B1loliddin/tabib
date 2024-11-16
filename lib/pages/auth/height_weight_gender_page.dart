import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabib/models/user_model.dart';
import 'package:tabib/providers/current_user_provider.dart';
import 'package:tabib/widgets/custom_user_specifications_text_form_field.dart';

class HeightWeightGenderPage extends StatefulWidget {
  const HeightWeightGenderPage({super.key});

  @override
  State<HeightWeightGenderPage> createState() => _HeightWeightGenderPageState();
}

class _HeightWeightGenderPageState extends State<HeightWeightGenderPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  Gender _selectedGender = Gender.male;
  DateTime _selectedDate = DateTime(1900);

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
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  void _disposeAllControllers() {
    _heightController.dispose();
    _weightController.dispose();
  }

  /// #main functions
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitButtonOnPressed() {
    if (formKey.currentState!.validate()) {
      final int height = int.parse(_heightController.text.trim());
      final double weight = double.parse(_weightController.text.trim());

      context.read<CurrentUserProvider>().changeHeightWeightGender(
            _selectedDate,
            height,
            weight,
            _selectedGender,
          );

      Navigator.pushNamedAndRemoveUntil(context, '', (route) => false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height Weight Gender'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// #
            Form(
              key: formKey,
              child: Column(
                children: [
                  /// #
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// #
                      CustomUserSpecificationsTextFormField(
                        controller: _heightController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(width: 20),

                      /// #
                      const Text(
                        'cm',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  /// #
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// #
                      CustomUserSpecificationsTextFormField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),

                      /// #
                      const Text(
                        'kg',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            /// #
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                /// #
                const Text(
                  'birthday',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// #
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Radio<Gender>(
                      value: Gender.male,
                      groupValue: _selectedGender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _selectedGender = value ?? Gender.male;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Radio<Gender>(
                      value: Gender.female,
                      groupValue: _selectedGender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _selectedGender = value ?? Gender.female;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// #
            ElevatedButton(
              onPressed: _submitButtonOnPressed,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
