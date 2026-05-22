import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserCredential> loginORegistro({
    required String correo,
    required String password,
  }) async {

    try {

      final credencial = await _auth.signInWithEmailAndPassword(
        email: correo,
        password: password,
      );

      await registrarIngreso(correo);

      return credencial;

    } on FirebaseAuthException {

      final credencial = await _auth.createUserWithEmailAndPassword(
        email: correo,
        password: password,
      );

      await registrarIngreso(correo);

      return credencial;
    }
  }

  Future<void> registrarIngreso(String correo) async {

    await _db.collection('ingresos').add({

      'correo': correo,
      'fechaHoraIngreso': FieldValue.serverTimestamp(),

    });
  }
}