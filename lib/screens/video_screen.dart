import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/base_pantalla.dart';
import '../widgets/boton_principal.dart';
import '../widgets/tarjeta_info.dart';
import 'encuesta_screen.dart';
import '../constants/app_colors.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController controller;

  bool cargandoVideo = true;
  bool videoTerminado = false;

  int segundos = 10;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (t) {

        if (segundos > 1) {

          setState(() {
            segundos--;
          });

        } else {

          t.cancel();
          iniciarVideo();

        }

      },
    );
  }

  Future<void> iniciarVideo() async {

    controller = VideoPlayerController.asset(
      'assets/videos/video_jueves.mp4',
    );

    await controller.initialize();

    controller.addListener(() {

      final posicion = controller.value.position;
      final duracion = controller.value.duration;

      if (
      duracion.inSeconds > 0 &&
          posicion.inSeconds >= duracion.inSeconds - 1
      ) {

        if (!videoTerminado) {

          setState(() {
            videoTerminado = true;
          });

        }

      }

    });

    setState(() {
      cargandoVideo = false;
    });

    controller.play();

  }

  @override
  void dispose() {

    timer?.cancel();

    if (!cargandoVideo) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BasePantalla(

      indexActual: 1,

      child: Column(

        children: [

          const SizedBox(height: 10),

          const Text(
            'Contenido Audiovisual',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: azulUnach,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            cargandoVideo
                ? 'El video se cargará automáticamente en $segundos segundos.'
                : 'Visualiza el contenido completo para desbloquear la encuesta.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: Center(

              child: cargandoVideo

                  ? const TarjetaInfo(
                icono: Icons.hourglass_bottom,
                texto: 'Preparando el Video del Jueves...',
              )

                  : ClipRRect(

                borderRadius: BorderRadius.circular(20),

                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),

              ),

            ),
          ),

          if (!cargandoVideo)

            IconButton(

              iconSize: 65,
              color: azulUnach,

              icon: Icon(
                controller.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
              ),

              onPressed: () {

                setState(() {

                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();

                });

              },

            ),

          const SizedBox(height: 15),

          BotonPrincipal(

            texto: videoTerminado
                ? 'Ir a la encuesta'
                : 'Debes ver el video completo',

            activo: videoTerminado,

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EncuestaScreen(),
                ),
              );

            },

          ),

        ],
      ),
    );
  }
}