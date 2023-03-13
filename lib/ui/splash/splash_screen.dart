import 'package:flutter/material.dart';
import 'package:my_own_chatgpt/providers/app_provider.dart';
import 'package:my_own_chatgpt/providers/model_provider.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'ChatGPT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            letterSpacing: 5.0,
          ),
        ),
      ),
    );
  }
}
