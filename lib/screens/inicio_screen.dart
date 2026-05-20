import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import '../widgets/tarjeta_info.dart';
import 'video_screen.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 0,
      child: Column(
        children: [
          const SizedBox(height: 20),

          Image.asset(
            'assets/images/logo_unach.webp',
            height: 115,
          ),

          const SizedBox(height: 28),

          Text(
            'Video del Jueves',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: azulUnach,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Esta aplicación tiene como objetivo reforzar los contenidos relacionados con los proyectos de Vinculación con el Medio (VCM) de la Universidad Adventista de Chile.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 35),

          const TarjetaInfo(
            icono: Icons.play_circle_fill,
            texto: 'Prepárate para visualizar el contenido audiovisual académico del día.',
          ),

          const Spacer(),

          BotonPrincipal(
            texto: 'Comenzar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VideoScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}