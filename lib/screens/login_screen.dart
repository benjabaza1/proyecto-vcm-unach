import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/boton_principal.dart';
import 'inicio_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  void iniciarSesion() {

    String correo = correoController.text.trim();

    if (!correo.endsWith('@alu.unach.cl')) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Debes ingresar un correo institucional @alu.unach.cl',
          ),
        ),

      );

      return;
    }

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) => const InicioScreen(),
      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(25),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(
                'assets/images/logo_unach.webp',
                height: 120,
              ),

              const SizedBox(height: 30),

              const Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: azulUnach,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Accede con tu correo institucional UNACH',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              TextField(

                controller: correoController,

                decoration: InputDecoration(

                  labelText: 'Correo institucional',

                  prefixIcon: const Icon(Icons.email),

                  filled: true,

                  fillColor: fondoSuave,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                ),

              ),

              const SizedBox(height: 20),

              TextField(

                controller: passwordController,

                obscureText: true,

                decoration: InputDecoration(

                  labelText: 'Contraseña',

                  prefixIcon: const Icon(Icons.lock),

                  filled: true,

                  fillColor: fondoSuave,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                ),

              ),

              const SizedBox(height: 35),

              BotonPrincipal(
                texto: 'Ingresar',
                onPressed: iniciarSesion,
              ),

            ],
          ),
        ),
      ),
    );
  }
}