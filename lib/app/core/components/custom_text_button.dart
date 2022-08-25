import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final EdgeInsets? padding;
  final String label;
  final VoidCallback? onPressed;
  const CustomTextButton({
    required this.label,
    this.onPressed,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
