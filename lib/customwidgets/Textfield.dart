import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    this.prefixicon,
    this.labelText,
    this.controller,
    this.validator,
    this.obscureText, 
    this.suffixIcon,
  });
  final prefixicon;
  final labelText;
  final controller;
  final validator;
  final obscureText;
  final suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: prefixicon,
          labelText: labelText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey[700])),
    );
  }
}
