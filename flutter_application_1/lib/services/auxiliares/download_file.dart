import 'dart:typed_data';

import 'error/download_file_stub.dart'
    if (dart.library.html) 'web/download_file_web.dart'
    if (dart.library.io) 'multiplataforma/download_file_io.dart';

Future<String> saveFile(Uint8List bytes, String fileName) =>
    saveFileImpl(bytes, fileName);
