import 'package:flutter/material.dart';

import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import '../widgets/campo_texto.dart';
import 'final_screen.dart';

class EncuestaScreen extends StatelessWidget {
  const EncuestaScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final respuesta1 = TextEditingController();
    final respuesta2 = TextEditingController();
    final respuesta3 = TextEditingController();

    return BasePantalla(

      indexActual: 2,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const SizedBox(height: 10),

          const Center(
            child: Text(
              'Encuesta VCM',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Responde las siguientes preguntas sobre el contenido visualizado.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          CampoTexto(
            label: '¿Qué es un proyecto VCM?',
            controller: respuesta1,
          ),

          CampoTexto(
            label: '¿Cuál es el mejor proyecto?',
            controller: respuesta2,
          ),

          CampoTexto(
            label: '¿Qué proyecto es más complejo?',
            controller: respuesta3,
          ),

          const Spacer(),

          BotonPrincipal(

            texto: 'Enviar respuestas',

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FinalScreen(),
                ),
              );

            },

          ),

        ],
      ),
    );
  }
}