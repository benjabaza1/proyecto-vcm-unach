import '../models/pregunta_model.dart';

final List<PreguntaModel> preguntas = [

  PreguntaModel(
    pregunta: '¿Qué tan útil te pareció el video?',
    opciones: [
      'Muy útil',
      'Útil',
      'Poco útil',
      'Nada útil',
    ],
  ),

  PreguntaModel(
    pregunta: '¿El contenido fue claro?',
    opciones: [
      'Muy claro',
      'Claro',
      'Confuso',
    ],
  ),

  PreguntaModel(
    pregunta: '¿Te gustaría ver más videos como este?',
    opciones: [
      'Sí',
      'No',
    ],
  ),

];