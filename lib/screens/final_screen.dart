import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'inicio_screen.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: FadeTransition(

          opacity: fadeAnimation,

          child: ScaleTransition(

            scale: scaleAnimation,

            child: Padding(

              padding: const EdgeInsets.all(25),

              child: Container(

                width: double.infinity,

                padding: const EdgeInsets.all(30),

                decoration: BoxDecoration(

                  color: fondoSuave,

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),

                  ],
                ),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Container(

                      padding: const EdgeInsets.all(22),

                      decoration: const BoxDecoration(
                        color: azulUnach,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 65,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      '¡Encuesta enviada!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: azulUnach,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Gracias por participar en el proyecto VCM de la Universidad Adventista de Chile.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Tu opinión fue registrada exitosamente en Firebase.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 35),

                    ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: azulUnach,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InicioScreen(),
                          ),
                              (route) => false,
                        );

                      },

                      icon: const Icon(Icons.home),

                      label: const Text(
                        'Volver al inicio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}