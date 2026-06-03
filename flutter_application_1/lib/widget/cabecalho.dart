import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/routes.dart';

class Cabecalho extends StatelessWidget {
  final String nome;

  const Cabecalho({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, Routes.home);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Ajuda - Brasa | $nome',
            style: TextStyle(fontSize: 16),
          ),
        )
      )
    );
  }
}