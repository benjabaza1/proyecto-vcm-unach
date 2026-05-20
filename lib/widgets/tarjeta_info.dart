import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class TarjetaInfo extends StatelessWidget {
  final IconData icono;
  final String texto;

  const TarjetaInfo({
    super.key,
    required this.icono,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: fondoSuave,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icono, color: azulUnach, size: 68),
          const SizedBox(height: 15),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 15),
          ),
        ],
      ),
    );
  }
}