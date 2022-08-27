import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final AnimationController controller;

  AnimatedLogo({required this.controller, Key? key})
      : size = Tween(begin: 0.3, end: 0.8).animate(
          CurvedAnimation(parent: controller, curve: const Interval(0.0, 1.0)),
        ),
        rotation = Tween(begin: 0.0, end: 0.5).animate(
          CurvedAnimation(parent: controller, curve: const Interval(0.0, 1.0)),
        ),
        super(key: key);

  final Animation<double> rotation;
  final Animation<double> size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return RotationTransition(
          turns: rotation,
          child: Container(
            height: MediaQuery.of(context).size.width * size.value,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}