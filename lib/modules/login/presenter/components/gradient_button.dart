import 'package:cartao_acessorios/global_styles_config/styles_global.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF6A8),
              Color(0xFF8D7B18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(
              135 * (3.1415926535897932 / 180),
            ),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            // constraints: const BoxConstraints(minWidth: 100, minHeight: 50),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: fontGlobal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
