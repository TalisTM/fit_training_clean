import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String? content;
  final String? textPrimaryButton;
  final VoidCallback? onPressedPrimaryButton;
  final String? textSecundaryButton;
  final VoidCallback? onPressedSecundaryButton;
  const CustomDialogWidget({
    Key? key,
    required this.title,
    this.content,
    this.textPrimaryButton,
    this.onPressedPrimaryButton,
    this.textSecundaryButton,
    this.onPressedSecundaryButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      buttonPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        content ?? "",
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        if (textSecundaryButton != null)
          TextButton(
            child: Text(
              textSecundaryButton!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: onPressedSecundaryButton ?? () => Modular.to.pop(),
          ),
        if (textPrimaryButton != null)
          TextButton(
            child: Text(
              textPrimaryButton!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: onPressedPrimaryButton ?? () => Modular.to.pop(),
          ),
      ],
    );
  }
}
