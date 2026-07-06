import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/file_upload_service.dart';
import '../services/http_upload_service.dart';

class LimparHTML extends StatefulWidget {
  const LimparHTML({super.key});

  @override
  State<LimparHTML> createState() => _ModExcelLayoutState();
}

class _ModExcelLayoutState extends State<LimparHTML> {
  final TextEditingController _fileController = TextEditingController(
    text: 'Nenhum arquivo selecionado',
  );
  String? _selectedFileName;
  Uint8List? _selectedFileBytes;
  bool _isUploading = false;
  String? _statusMessage;

  @override
  void dispose() {
    _fileController.dispose();
    super.dispose();
  }

  Future<void> _selectFile() async {
    setState(() {
      _statusMessage = null;
      _isUploading = true;
    });

    final result = await FileUploadService().pickXlsxFile();

    setState(() {
      _isUploading = false;
      if (result.cancelled) {
        _statusMessage = 'Seleção cancelada.';
      } else if (!result.success) {
        _statusMessage = result.message;
      } else {
        _selectedFileName = result.fileName;
        _selectedFileBytes = result.fileBytes;
        _fileController.text = result.fileName ?? 'Nenhum arquivo selecionado';
        _statusMessage = result.message;
      }
    });
  }

  Future<void> _cleanSelectedFile() async {
    if (_selectedFileBytes == null || _selectedFileName == null) {
      setState(() {
        _statusMessage = 'Selecione um arquivo antes de limpar.';
      });
      return;
    }

    setState(() {
      _statusMessage = null;
      _isUploading = true;
    });

    final result = await HttpUploadService().cleanAndDownloadXlsxFile(
      'http://192.168.0.210:3000/api/planilha/formatar',
      _selectedFileName!,
      _selectedFileBytes!,
    );

    setState(() {
      _isUploading = false;
      _statusMessage = result.message;
    });
  }

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
              readOnly: true,
              controller: _fileController,
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
              onPressed: _isUploading ? null : _selectFile,
              child: _isUploading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Selecionar Arquivo'),
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
              ),
            ],
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),

        ElevatedButton(
          onPressed: _isUploading ? null : _cleanSelectedFile,
          child: _isUploading
            ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text('Limpar'),
        ),
      ],
    );
  }
}
