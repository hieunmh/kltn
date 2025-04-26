import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get serverhost => dotenv.env['SERVER_HOST'] ?? 'http://localhost:5000';
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get geminiModel => dotenv.env['GEMINI_MODEL'] ?? '';
  static String get openaiModel => dotenv.env['OPEN_AI_MODEL'] ?? '';
}