import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/file_upload_service.dart';
import '../services/http_upload_service.dart';


class UnirHTML extends StatefulWidget {
  const UnirHTML({super.key});

  @override
  State<UnirHTML> createState() => _ModExcelLayoutState();
}

class _ModExcelLayoutState extends State<UnirHTML> {
  final TextEditingController _baseFileController = TextEditingController(text: 'Nenhum arquivo selecionado');
  final TextEditingController _compareFileController = TextEditingController(text: 'Nenhum arquivo selecionado');

  String? _baseFileName;
  Uint8List? _baseFileBytes;

  String? _compareFileName;
  Uint8List? _compareFileBytes;

  bool _isUploading = false;
  String? _statusMessage;

  @override
  void dispose() {
    _baseFileController.dispose();
    _compareFileController.dispose();
    super.dispose();
  }

  Future<void> _selectBaseFile() async {
    setState(() {
      _statusMessage = null;
      _isUploading = true;
    });

    final result = await FileUploadService().pickXlsxFile();

    setState(() {
      _isUploading = false;
      if (!result.success) {
        _statusMessage = result.message;
      }else{
        _baseFileName = result.fileName;
        _baseFileBytes = result.fileBytes;
        _baseFileController.text = result.fileName ?? 'Nenhum arquivo selecionado';
      }
    });
  }

  Future<void> _selectCompareFile() async {
    setState(() {
      _statusMessage = null;
      _isUploading = true;
    });

    final result = await FileUploadService().pickXlsxFile();

    setState(() {
      _isUploading = false;
      if (!result.success){
        _statusMessage = result.message;
      }else{
        _compareFileName = result.fileName;
        _compareFileBytes = result.fileBytes;
        _compareFileController.text = result.fileName ?? 'Nenhum arquivo selecionado';
      }
    });
  }  

  Future<void> _unirSelectedFile() async {
    if (_baseFileBytes == null || _baseFileName == null && _compareFileBytes == null || _compareFileName == null) {
      setState(() {
        _statusMessage = 'Selecione um arquivo antes de limpar.';
      });
      return;
    }

    setState(() {
      _statusMessage = null;
      _isUploading = true;
    });

    final result = await HttpUploadService().mergeAndDownloadXlsxFile(
      'http://192.168.0.210:3000/api/planilha/unir',
      _baseFileName!,
      _baseFileBytes!,
      _compareFileName!,
      _compareFileBytes!,
    );

    setState(() {
      _isUploading = false;
      _statusMessage = result.message;
    });
  }


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
                        controller: _baseFileController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_file),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _isUploading ? null : _selectBaseFile,
                      child: _isUploading
                        ?const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text('Selecionar Arquivo'),
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
                        controller: _compareFileController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_file),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _isUploading ? null : _selectCompareFile,
                      child: _isUploading
                      ?const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text('Selecionar Arquivo'),
                    ),
                  ],
                ),
              ],
            ),
            if (_statusMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _statusMessage!,
                style: TextStyle(
                color: _statusMessage!.contains('sucesso')
                    ? Colors.green
                    : Colors.red,
                ),
              )
            ]
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),

        ElevatedButton(
          onPressed: _isUploading ? null : _unirSelectedFile,
          child: _isUploading
            ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              )
            )
          :const Text('Unir')
        ),
      ],
    );
  }
}
