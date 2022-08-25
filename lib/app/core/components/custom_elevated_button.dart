import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final Color labelColor;
  const CustomElevatedButton({
    required this.label,
    this.onPressed,
    this.margin,
    this.backgroundColor = const Color(0xFFFCEE57),
    this.labelColor = Colors.black,
    Key? key,
  }) : super(key: key);

  const CustomElevatedButton.outlined({
    required this.label,
    this.onPressed,
    this.margin,
    this.backgroundColor = Colors.transparent,
    this.labelColor = const Color(0xFFFCEE57),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 50,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
