import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get serverhost => dotenv.env['SERVER_HOST'] ?? 'http://localhost:5000';
}