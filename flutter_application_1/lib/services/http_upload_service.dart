import 'dart:typed_data';
import 'package:dio/dio.dart';

class HttpUploadResult {
  final bool success;
  final String message;

  HttpUploadResult({
    required this.success,
    required this.message,
  });

  factory HttpUploadResult.success(String message) => HttpUploadResult(
        success: true,
        message: message,
      );

  factory HttpUploadResult.failure(String message) => HttpUploadResult(
        success: false,
        message: message,
      );
}

class HttpUploadService {
  final Dio _dio;

  HttpUploadService([Dio? dio]) : _dio = dio ?? Dio();

  Future<HttpUploadResult> uploadXlsxFile(
    String uploadUrl,
    String fileName,
    Uint8List fileBytes,
  ) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      ),
    });

    try {
      final response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpUploadResult.success('Arquivo enviado para limpeza com sucesso!');
      }

      return HttpUploadResult.failure('Falha ao enviar para limpeza: ${response.statusCode}');
    } catch (e) {
      return HttpUploadResult.failure('Erro ao enviar para API: $e');
    }
  }
}
