import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool hideText;
  final String labelText;
  String validatorString;
   CustomTextField(
      {super.key,
      this.hideText = false,
      required this.validatorString,
    
      this.textInputType = TextInputType.text,
      required this.controller,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return '$validatorString can\'t be empty';
        }
        return null;
      },
      controller: controller,
      obscureText: hideText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
