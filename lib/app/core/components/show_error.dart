import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ShowError extends StatelessWidget {
  final String title;
  final String? content;
  final String titleButton;
  final VoidCallback onPressed;
  const ShowError({
    required this.title,
    required this.onPressed,
    this.titleButton = "Ok",
    this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/warning.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  content ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            CustomElevatedButton.outlined(
              margin: const EdgeInsets.symmetric(vertical: 20),
              label: titleButton,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
