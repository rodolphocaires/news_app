import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get newsApiKey => _getString('NEWS_API_KEY');
  static int get backgroundFetchInterval =>
      _getInt('BACKGROUND_FETCH_INTERVAL_SECONDS');

  static String _getString(String name) => dotenv.env[name] ?? '';
  static int _getInt(String name) => int.parse(dotenv.env[name] ?? '0');
}
