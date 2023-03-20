import 'package:flutter_config/flutter_config.dart';

class TestUtil {
  static void initDependencies() {
    FlutterConfig.loadValueForTesting({
      'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
      'CLIENT_ID': 'CLIENT_ID',
      'CLIENT_SECRET': 'CLIENT_SECRET',
    });
  }
}
