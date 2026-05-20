import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CampoTexto extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CampoTexto({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
}