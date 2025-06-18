import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? onValidate;
  const CustomTextField({super.key, required this.controller, required this.hintText, required this.label, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidate,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 18.0),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.black
        ),
        filled: true,
        fillColor: CustomColors.fieldGrey,
        errorStyle: const TextStyle(fontSize: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: CustomColors.grey,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18.0),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
      ),
    );
  }
}
