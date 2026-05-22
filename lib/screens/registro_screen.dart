import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/boton_principal.dart';
import 'inicio_screen.dart';
import 'login_screen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarPasswordController = TextEditingController();

  bool cargando = false;

  Future<void> registrarUsuario() async {
    final correo = correoController.text.trim().toLowerCase();
    final password = passwordController.text.trim();
    final confirmarPassword = confirmarPasswordController.text.trim();

    if (!correo.endsWith('@alu.unach.cl')) {
      mostrarMensaje('Debes usar un correo institucional @alu.unach.cl');
      return;
    }

    if (password.length < 6) {
      mostrarMensaje('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    if (password != confirmarPassword) {
      mostrarMensaje('Las contraseñas no coinciden');
      return;
    }

    setState(() => cargando = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correo,
        password: password,
      );

      await AuthService().registrarIngreso(correo);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioScreen()),
      );
    } on FirebaseAuthException catch (e) {

      print('ERROR FIREBASE: ${e.code}');
      print('MENSAJE: ${e.message}');

      if (e.code == 'email-already-in-use') {

        mostrarMensaje('Este correo ya está registrado. Inicia sesión.');

      } else {

        mostrarMensaje('No se pudo registrar el usuario.');

      }

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
    correoController.dispose();
    passwordController.dispose();
    confirmarPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 25),

              Image.asset(
                'assets/images/logo_unach.webp',
                height: 105,
              ),

              const SizedBox(height: 25),

              const Text(
                'Registro de Usuario',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: azulUnach,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Crea tu cuenta usando tu correo institucional UNACH.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 35),

              campoLogin(
                controller: correoController,
                label: 'Correo institucional',
                icono: Icons.email,
              ),

              const SizedBox(height: 18),

              campoLogin(
                controller: passwordController,
                label: 'Contraseña',
                icono: Icons.lock,
                oculto: true,
              ),

              const SizedBox(height: 18),

              campoLogin(
                controller: confirmarPasswordController,
                label: 'Confirmar contraseña',
                icono: Icons.lock_outline,
                oculto: true,
              ),

              const SizedBox(height: 30),

              cargando
                  ? const CircularProgressIndicator(color: azulUnach)
                  : BotonPrincipal(
                texto: 'Crear cuenta',
                onPressed: registrarUsuario,
              ),

              const SizedBox(height: 18),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Ya tengo cuenta',
                  style: TextStyle(color: azulUnach),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoLogin({
    required TextEditingController controller,
    required String label,
    required IconData icono,
    bool oculto = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: oculto,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono),
        filled: true,
        fillColor: fondoSuave,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}