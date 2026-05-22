import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EncuestaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> guardarEncuesta({
    required String respuesta1,
    required String respuesta2,
    required String respuesta3,
  }) async {
    final deviceInfo = DeviceInfoPlugin();

    String modeloDispositivo = 'Desconocido';
    String sistemaOperativo = Platform.operatingSystem;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;

      modeloDispositivo =
      '${androidInfo.manufacturer} ${androidInfo.model}';

      sistemaOperativo =
      'Android ${androidInfo.version.release}';
    }

    await _db.collection('encuestas').add({
      'correo': _auth.currentUser?.email ?? 'Sin correo',
      'respuesta_1': respuesta1,
      'respuesta_2': respuesta2,
      'respuesta_3': respuesta3,
      'modeloDispositivo': modeloDispositivo,
      'sistemaOperativo': sistemaOperativo,
      'fechaHoraEnvio': FieldValue.serverTimestamp(),
    });
  }
}