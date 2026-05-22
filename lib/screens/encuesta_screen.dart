import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/encuesta_service.dart';
import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import 'final_screen.dart';

class EncuestaScreen extends StatefulWidget {
  const EncuestaScreen({super.key});

  @override
  State<EncuestaScreen> createState() => _EncuestaScreenState();
}

class _EncuestaScreenState extends State<EncuestaScreen> {
  String? respuesta1;
  String? respuesta2;
  String? respuesta3;

  bool cargando = false;

  Future<void> enviarEncuesta() async {
    if (respuesta1 == null || respuesta2 == null || respuesta3 == null) {
      mostrarMensaje('Debes responder todas las preguntas');
      return;
    }

    setState(() => cargando = true);

    try {
      await EncuestaService().guardarEncuesta(
        respuesta1: respuesta1!,
        respuesta2: respuesta2!,
        respuesta3: respuesta3!,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const FinalScreen(),
        ),
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
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Encuesta VCM',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: azulUnach,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              'Selecciona una respuesta para cada pregunta.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 25),

          preguntaOpciones(
            titulo: '1. ¿Qué tan útil te pareció el video?',
            valorActual: respuesta1,
            opciones: const [
              'Muy útil',
              'Útil',
              'Poco útil',
              'Nada útil',
            ],
            onChanged: (valor) {
              setState(() => respuesta1 = valor);
            },
          ),

          preguntaOpciones(
            titulo: '2. ¿El contenido fue claro?',
            valorActual: respuesta2,
            opciones: const [
              'Muy claro',
              'Claro',
              'Confuso',
            ],
            onChanged: (valor) {
              setState(() => respuesta2 = valor);
            },
          ),

          preguntaOpciones(
            titulo: '3. ¿Te gustaría ver más videos como este?',
            valorActual: respuesta3,
            opciones: const [
              'Sí',
              'No',
            ],
            onChanged: (valor) {
              setState(() => respuesta3 = valor);
            },
          ),

          const Spacer(),

          cargando
              ? const Center(
            child: CircularProgressIndicator(color: azulUnach),
          )
              : BotonPrincipal(
            texto: 'Enviar respuestas',
            onPressed: enviarEncuesta,
          ),
        ],
      ),
    );
  }

  Widget preguntaOpciones({
    required String titulo,
    required String? valorActual,
    required List<String> opciones,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fondoSuave,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: azulUnach,
            ),
          ),

          const SizedBox(height: 8),

          ...opciones.map(
                (opcion) => RadioListTile<String>(
              value: opcion,
              groupValue: valorActual,
              activeColor: azulUnach,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(opcion),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}