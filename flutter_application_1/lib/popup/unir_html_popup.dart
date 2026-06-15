import 'package:flutter/material.dart';

class UnirHTML extends StatefulWidget {
  const UnirHTML({super.key});

  @override
  State<UnirHTML> createState() => _ModExcelLayoutState();
}

class _ModExcelLayoutState extends State<UnirHTML> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unir HTML'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Escolha os arquivos para unir',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),

            const Text(
              'OBS: A etapa de união consolida os dados e as tabelas de comparação na planilha base, gerando um novo arquivo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Base', style: TextStyle(fontSize: 16)),

                    SizedBox(
                      width: 200,
                      child: TextField(
                        readOnly: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_file),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Selecionar Arquivo'),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                Column(
                  children: [
                    Text('Comparação', style: TextStyle(fontSize: 16)),

                    SizedBox(
                      width: 200,
                      child: TextField(
                        readOnly: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_file),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Selecionar Arquivo'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),

        ElevatedButton(
          onPressed: () {
            // Conexão com a API
            Navigator.pop(context);
          },
          child: const Text('Unir'),
        ),
      ],
    );
  }
}
