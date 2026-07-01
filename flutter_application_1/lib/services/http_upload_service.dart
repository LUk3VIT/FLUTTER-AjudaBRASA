import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'auxiliares/download_file.dart';

class HttpUploadResult {
  final bool success;
  final String message;
  final Uint8List? fileBytes;

  HttpUploadResult({
    required this.success,
    required this.message,
    this.fileBytes,
  });

  factory HttpUploadResult.success(String message, {Uint8List? fileBytes}) =>
      HttpUploadResult(success: true, message: message, fileBytes: fileBytes);

  factory HttpUploadResult.failure(String message) =>
      HttpUploadResult(success: false, message: message);
}

class HttpUploadService {
  final Dio _dio;

  HttpUploadService([Dio? dio]) : _dio = dio ?? Dio();

  /** 
  Future<HttpUploadResult> uploadXlsxFile(String uploadUrl, String fileName, Uint8List fileBytes,) async {
    final formData = FormData.fromMap({
      'planilha': MultipartFile.fromBytes(fileBytes, filename: fileName),
    });

    try {
      final response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpUploadResult.success(
          'Arquivo enviado para limpeza com sucesso!',
        );
      }

      return HttpUploadResult.failure(
        'Falha ao enviar para limpeza: ${response.statusCode}',
      );
    } catch (e) {
      return HttpUploadResult.failure('Erro ao enviar para API: $e');
    }
  }
  */

  Future<HttpUploadResult> cleanAndDownloadXlsxFile(String uploadUrl, String fileName, Uint8List fileBytes) async {
    if (!uploadUrl.startsWith(RegExp(r'https?://'))) {
      uploadUrl = 'http://$uploadUrl';
    }
    final formData = FormData.fromMap({
      'planilha': MultipartFile.fromBytes(fileBytes, filename: fileName),
    });

    try {
      final response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Em web a resposta pode ser List<int>
        final data = response.data;
        final Uint8List processedBytes = data is Uint8List
            ? data
            : Uint8List.fromList(List<int>.from(data));

        final saveMessage = await saveFile(processedBytes, fileName);

        return HttpUploadResult.success(
          'Arquivo processado com sucesso! $saveMessage',
          fileBytes: processedBytes,
        );
      }

      return HttpUploadResult.failure(
        'Falha ao processar arquivo: ${response.statusCode}',
      );
    } on DioException catch (e) {
      // Mensagens mais descritivas para problemas de rede/CORS
      final type = e.type;
      final message = e.message;
      return HttpUploadResult.failure('DioException [$type]: $message');
    } catch (e) {
      return HttpUploadResult.failure('Erro ao processar arquivo: $e');
    }
  }

  Future<HttpUploadResult> MergeAndDownloadXlsxFile(String uploadUrl, String baseName, Uint8List baseBytes, String compareName, Uint8List compareBytes) async {
    if (!uploadUrl.startsWith(RegExp(r'https?://'))){
      uploadUrl = 'http://$uploadUrl';
    }

    final formData = FormData.fromMap({
      'base': MultipartFile.fromBytes(baseBytes, filename: baseName),
      'comparacao': MultipartFile.fromBytes(compareBytes, filename: compareName),
    });

    try{
      final response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201){
        final data = response.data;
        final Uint8List processedBytes = data is Uint8List ? data : Uint8List.fromList(List<int>.from(data));
        
        final saveMessage = await saveFile(processedBytes, 'planilha_unida.xlsx');

        return HttpUploadResult.success(
          'Planilhas unidas com sucesso! $saveMessage',
          fileBytes: processedBytes,
        );
      }
      
      return HttpUploadResult.failure('Falha ao unir planilhas: ${response.statusCode}');
    } catch (e) {
      return HttpUploadResult.failure('Erro ao conectar com a API: $e');
    }
  }

}
