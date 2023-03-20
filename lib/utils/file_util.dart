import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FileUtil {
  FileUtil._();

  static Future<Map<String, dynamic>> loadFile(String filePath) {
    return rootBundle.loadString(filePath).then((json) => jsonDecode(json));
  }
}
