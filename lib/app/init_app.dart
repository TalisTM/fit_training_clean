import 'package:firebase_core/firebase_core.dart';
import 'package:fit_training_clean/app/app_module.dart';
import 'package:fit_training_clean/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitApp {
  static void init() async {
    //await _dependencies();
    _initializeApp();
  }

  static void _initializeApp() {
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  }

  static Future<void> _dependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}