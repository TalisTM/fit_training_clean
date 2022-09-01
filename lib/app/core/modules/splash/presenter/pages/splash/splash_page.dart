import 'package:fit_training_clean/app/core/components/animated_logo.dart';
import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  SplashStore store = Modular.get<SplashStore>();

  late final AnimationController _animationController;

  Future<void> getUser() async {
    await store.checkLogin();
  }

  @override
  void initState() {
    super.initState();

    getUser();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(child: AnimatedLogo(controller: _animationController)),
    );
  }
}
