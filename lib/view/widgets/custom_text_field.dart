import 'package:flutter/material.dart';
import 'package:moive_app/utils/app_colors.dart';


typedef OnChanged = void Function(String?)?;
typedef Validator = String? Function(String?)?;


class CustomTextField extends StatelessWidget {
  final Color borderColor ;


  const CustomTextField({
    super.key,
    required this.borderColor,
    this.fillColor,
    this.filled,
    this.hintText,
    this.lableText,
    this.hintStyle,
    this.lableStyle,
    this.preIcon,
    this.sufIcon,
    this.maxLines,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false,
  });


  final Color? fillColor;
  final bool? filled;
  final String? hintText;
  final String? lableText;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final Widget? preIcon;
  final Widget? sufIcon;
  final int? maxLines;
  final OnChanged onChanged;
  final Validator validator;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.yellowColor,

      style: TextStyle(
        color: Colors.white,
      ),
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: _buildDecorationBorder(
            radius: 16,
            borderColor: borderColor),
        focusedBorder: _buildDecorationBorder(
            radius: 16,
            borderColor: borderColor),
        errorBorder: _buildDecorationBorder(
            radius: 16,
            borderColor: AppColors.redColor),
        focusedErrorBorder: _buildDecorationBorder(
            radius: 16,
            borderColor: AppColors.redColor),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: lableText,
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
      ),
      maxLines: obscureText ? 1 : maxLines,
      obscureText:obscureText,
    );
  }

  OutlineInputBorder _buildDecorationBorder({
    required double radius,
    required Color borderColor
  }){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
    );
  }
}
