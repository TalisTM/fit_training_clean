import 'package:fit_training_clean/app/core/components/animated_logo.dart';
import 'package:flutter/material.dart';

class ShowLoading extends StatefulWidget {
  const ShowLoading({Key? key}) : super(key: key);

  @override
  State<ShowLoading> createState() => _ShowLoadingState();
}

class _ShowLoadingState extends State<ShowLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;

      _animationController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(controller: _animationController),
    );
  }
}
