import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../screens/inicio_screen.dart';
import '../screens/video_screen.dart';
import '../screens/encuesta_screen.dart';
import '../screens/final_screen.dart';

class BasePantalla extends StatelessWidget {
  final Widget child;
  final int indexActual;

  const BasePantalla({
    super.key,
    required this.child,
    required this.indexActual,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto VCM'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: azulUnach,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexActual,
        selectedItemColor: azulUnach,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == indexActual) return;

          Widget destino = const InicioScreen();

          if (index == 1) destino = const VideoScreen();
          if (index == 2) destino = const EncuestaScreen();
          if (index == 3) destino = const FinalScreen();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destino),
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Encuesta'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Final'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: child,
        ),
      ),
    );
  }
}