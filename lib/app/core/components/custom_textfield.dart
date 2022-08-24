import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final EdgeInsets? padding;
  final bool obscureText;
  final bool autofocus;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final IconData? suffixIcon;
  final VoidCallback? suffixPressed;

  const CustomTextfield({
    this.padding,
    this.controller,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.suffixIcon,
    this.suffixPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(
          color: Colors.white,
        ),
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: Theme.of(context).primaryColor),
            onPressed: suffixPressed,
          ),
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
