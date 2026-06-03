import 'package:flutter/material.dart';
import '../main.dart';
import '../pag/modExcel.dart';

class Routes {
  static const String home = '/';
  static const String modExcel = '/modExcel';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const MainApp(),
      modExcel: (context) => const ModExcel(),
    };
  }
}