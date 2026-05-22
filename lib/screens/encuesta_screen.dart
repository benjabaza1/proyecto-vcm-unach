import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/encuesta_service.dart';
import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import '../widgets/campo_texto.dart';
import 'final_screen.dart';

class EncuestaScreen extends StatefulWidget {
  const EncuestaScreen({super.key});

  @override
  State<EncuestaScreen> createState() => _EncuestaScreenState();
}

class _EncuestaScreenState extends State<EncuestaScreen> {
  final respuesta1 = TextEditingController();
  final respuesta2 = TextEditingController();
  final respuesta3 = TextEditingController();

  bool cargando = false;

  Future<void> enviarEncuesta() async {
    if (respuesta1.text.trim().isEmpty ||
        respuesta2.text.trim().isEmpty ||
        respuesta3.text.trim().isEmpty) {
      mostrarMensaje('Debes responder todas las preguntas');
      return;
    }

    setState(() => cargando = true);

    try {
      await EncuestaService().guardarEncuesta(
        respuesta1: respuesta1.text.trim(),
        respuesta2: respuesta2.text.trim(),
        respuesta3: respuesta3.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FinalScreen()),
      );
    } catch (e) {
      mostrarMensaje('No se pudieron guardar las respuestas.');
    } finally {
      if (mounted) {
        setState(() => cargando = false);
      }
    }
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  void dispose() {
    respuesta1.dispose();
    respuesta2.dispose();
    respuesta3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Encuesta VCM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: azulUnach,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Responde las siguientes preguntas sobre el proyecto VCM.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
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

            const SizedBox(height: 25),

            cargando
                ? const CircularProgressIndicator(color: azulUnach)
                : BotonPrincipal(
              texto: 'Enviar respuestas',
              onPressed: enviarEncuesta,
            ),
          ],
        ),
      ),
    );
  }
}