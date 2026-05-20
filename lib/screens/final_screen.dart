import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import 'inicio_screen.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 3,
      child: Column(
        children: [
          const SizedBox(height: 30),

          const Icon(
            Icons.celebration,
            size: 90,
            color: azulUnach,
          ),

          const SizedBox(height: 20),

          const Text(
            '¡Felicitaciones!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: azulUnach,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Has completado correctamente el Video del Jueves y participaste en la actividad VCM de la Universidad Adventista de Chile.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 35),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: fondoSuave,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: azulUnach,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.workspace_premium,
                  size: 90,
                  color: azulUnach,
                ),

                const SizedBox(height: 15),

                Text(
                  'Insignia del Jueves',
                  style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: azulUnach,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Compromiso, aprendizaje y participación académica.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          BotonPrincipal(
            texto: 'Volver al inicio',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const InicioScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}