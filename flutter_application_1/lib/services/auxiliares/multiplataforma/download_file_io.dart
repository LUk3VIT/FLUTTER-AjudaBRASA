import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> saveFileImpl(Uint8List bytes, String fileName) async {
  final downloadsDirectory = await getDownloadsDirectory();
  final directory = downloadsDirectory ?? await getApplicationDocumentsDirectory();
  final file = File('${directory.path}${Platform.pathSeparator}$fileName');
  await file.writeAsBytes(bytes);
  return 'Arquivo salvo em: ${file.path}';
}
