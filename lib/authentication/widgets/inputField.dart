import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;

  final Widget? suffixIcon;

  final void Function(String)? onChanged;

  const InputField(
      {this.hintText,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.autofocus = false,
      this.suffixIcon,
      this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: Theme.of(context).accentColor,
      autofocus: autofocus,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey.shade800,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: borderRadius),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: borderRadius),
      ),
    );
  }
}
