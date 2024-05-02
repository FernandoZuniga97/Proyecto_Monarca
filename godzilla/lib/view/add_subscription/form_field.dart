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
    return SingleChildScrollView(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(13.0)),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        initialValue: initialValue,
      ),
    );
  }
}