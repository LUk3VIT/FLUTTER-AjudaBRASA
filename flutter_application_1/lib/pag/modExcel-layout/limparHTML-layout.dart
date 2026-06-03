import 'package:flutter/material.dart';

class ModExcelLayout extends StatefulWidget {
  const ModExcelLayout({super.key});

  @override
  State<ModExcelLayout> createState() => _ModExcelLayoutState();
}

class _ModExcelLayoutState extends State<ModExcelLayout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Text('Limpar HTML'),
      content: SizedBox(
        width: 500,
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              'Escolha o arquivo para limpar HTML',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: 'Selecione o arquivo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(Icons.attach_file),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Selecionar Arquivo'),
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
          child: const Text('Limpar'),
        ),
      ],
    );
  }
}
