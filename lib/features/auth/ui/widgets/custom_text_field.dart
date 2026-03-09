import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isObscure;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure = false,
    this.controller,
    this.validator,
    this.onChanged
  });
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    );
    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.red),
    );
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        fillColor: AppColors.softBlack,
        filled: true,
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
