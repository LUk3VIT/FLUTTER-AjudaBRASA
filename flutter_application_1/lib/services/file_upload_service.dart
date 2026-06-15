import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class FileSelectionResult {
  final bool success;
  final String message;
  final String? fileName;
  final Uint8List? fileBytes;
  final bool cancelled;

  FileSelectionResult({
    required this.success,
    required this.message,
    this.fileName,
    this.fileBytes,
    this.cancelled = false,
  });

  factory FileSelectionResult.cancelled() => FileSelectionResult(
    success: false,
    message: 'Seleção cancelada.',
    cancelled: true,
  );

  factory FileSelectionResult.failure(String message) =>
      FileSelectionResult(success: false, message: message);

  factory FileSelectionResult.success(
    String message, {
    required String fileName,
    required Uint8List fileBytes,
  }) => FileSelectionResult(
    success: true,
    message: message,
    fileName: fileName,
    fileBytes: fileBytes,
  );
}

class FileUploadService {
  Future<FileSelectionResult> pickXlsxFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return FileSelectionResult.cancelled();
    }

    final file = result.files.first;
    final fileBytes = file.bytes;

    if (fileBytes == null) {
      return FileSelectionResult.failure(
        'Não foi possível ler o arquivo selecionado.',
      );
    }

    return FileSelectionResult.success(
      'Arquivo selecionado com sucesso.',
      fileName: file.name,
      fileBytes: fileBytes,
    );
  }
}
