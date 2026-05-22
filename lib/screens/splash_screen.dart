import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_unach.webp',
              height: 140,
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(
              color: azulUnach,
            ),

            const SizedBox(height: 25),

            const Text(
              'Proyecto VCM',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: azulUnach,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Universidad Adventista de Chile',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Video del Jueves',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}