import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/base/injection/injection.dart';

class Bootstrap {
  static Future<void> start() async {
    await _loadEnvironmentConfigs();
    _loadInjection();
  }

  static Future<void> _loadEnvironmentConfigs() async {
    await dotenv.load(fileName: '.env');
  }

  static void _loadInjection() {
    try {
      RegisterFeatureClient.instance.registerFeatures();
    } catch (error) {
      Exception('Error loading injection: $error');
    }
  }
}
