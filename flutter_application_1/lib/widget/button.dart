import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String titulo;
  final VoidCallback? onPressed;

  const Button({super.key, required this.titulo, this.onPressed});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,

      child: TextButton(
        onPressed: () {
          setState(() {
            _isActive = !_isActive;
          });
          widget.onPressed?.call();
        },

        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _isActive
              ? const Color(0xFF00FF00)
              : const Color(0xFFADFF2F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: Text(
          widget.titulo,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
