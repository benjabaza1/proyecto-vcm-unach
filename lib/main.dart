import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const ProyectoVCMApp());
}

class ProyectoVCMApp extends StatelessWidget {
  const ProyectoVCMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto VCM',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003B73)),
      ),
      home: const InicioScreen(),
    );
  }
}

const Color azulUnach = Color(0xFF003B73);
const Color fondoSuave = Color(0xFFF3F7FB);

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 0,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/logo_unach.webp', height: 115),
          const SizedBox(height: 28),
          titulo('Video del Jueves'),
          const SizedBox(height: 18),
          textoCentro(
            'Esta aplicación tiene como objetivo reforzar los contenidos relacionados con los proyectos de Vinculación con el Medio (VCM) de la Universidad Adventista de Chile.',
          ),
          const SizedBox(height: 35),
          tarjetaInfo(
            icono: Icons.play_circle_fill,
            texto: 'Prepárate para visualizar el contenido audiovisual académico del día.',
          ),
          const Spacer(),
          botonPrincipal(
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

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool cargandoVideo = true;
  bool videoTerminado = false;
  int segundos = 10;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (segundos > 1) {
        setState(() => segundos--);
      } else {
        t.cancel();
        iniciarVideo();
      }
    });
  }

  Future<void> iniciarVideo() async {
    _controller = VideoPlayerController.asset('assets/videos/video_jueves.mp4');

    await _controller.initialize();

    _controller.addListener(() {
      final posicion = _controller.value.position;
      final duracion = _controller.value.duration;

      if (duracion.inSeconds > 0 &&
          posicion.inSeconds >= duracion.inSeconds - 1 &&
          !videoTerminado) {
        setState(() {
          videoTerminado = true;
        });
      }
    });

    setState(() {
      cargandoVideo = false;
    });

    _controller.play();
  }

  @override
  void dispose() {
    timer?.cancel();
    if (!cargandoVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 1,
      child: Column(
        children: [
          titulo('Contenido audiovisual'),
          const SizedBox(height: 12),
          textoCentro(
            cargandoVideo
                ? 'El video se cargará automáticamente en $segundos segundos.'
                : 'Visualiza el contenido completo para desbloquear la encuesta.',
          ),
          const SizedBox(height: 25),

          Expanded(
            child: Center(
              child: cargandoVideo
                  ? tarjetaInfo(
                icono: Icons.hourglass_bottom,
                texto: 'Preparando el Video del Jueves...',
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),

          if (!cargandoVideo)
            IconButton(
              iconSize: 60,
              color: azulUnach,
              icon: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),

          botonPrincipal(
            texto: videoTerminado ? 'Ir a la encuesta' : 'Debes ver el video completo',
            activo: videoTerminado,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EncuestaScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

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
          titulo('Encuesta VCM'),
          const SizedBox(height: 10),
          textoCentro('Responde las siguientes preguntas sobre el contenido visualizado.'),
          const SizedBox(height: 25),

          campoTexto('¿Qué es un proyecto VCM?', respuesta1),
          campoTexto('¿Cuál es el mejor proyecto?', respuesta2),
          campoTexto('¿Qué proyecto es más complejo?', respuesta3),

          const Spacer(),

          botonPrincipal(
            texto: 'Enviar respuestas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FinalScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      indexActual: 3,
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Icon(Icons.celebration, size: 90, color: azulUnach),
          const SizedBox(height: 20),
          titulo('¡Felicitaciones!'),
          const SizedBox(height: 15),
          textoCentro(
            'Has completado correctamente el Video del Jueves y ganaste una insignia VCM.',
          ),
          const SizedBox(height: 35),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: fondoSuave,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: azulUnach, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.workspace_premium, size: 85, color: azulUnach),
                const SizedBox(height: 12),
                Text(
                  'Insignia del Jueves',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: azulUnach,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          botonPrincipal(
            texto: 'Volver al inicio',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const InicioScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Proyecto VCM',
          style: TextStyle(
            color: azulUnach,
            fontWeight: FontWeight.bold,
          ),
        ),
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

Widget titulo(String texto) {
  return Center(
    child: Text(
      texto,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: azulUnach,
      ),
    ),
  );
}

Widget textoCentro(String texto) {
  return Text(
    texto,
    textAlign: TextAlign.center,
    style: GoogleFonts.montserrat(
      fontSize: 15,
      height: 1.6,
      color: Colors.black87,
    ),
  );
}

Widget tarjetaInfo({required IconData icono, required String texto}) {
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

Widget botonPrincipal({
  required String texto,
  required VoidCallback onPressed,
  bool activo = true,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: activo ? azulUnach : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: activo ? onPressed : null,
      child: Text(
        texto,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );
}

Widget campoTexto(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: TextField(
      controller: controller,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fondoSuave,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}