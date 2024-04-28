// form_field.dart
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.labelText,
    this.validator,
    this.onSaved,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.initialValue,
  });

  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool readOnly;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: onSaved,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      initialValue: initialValue,
    );
  }
}