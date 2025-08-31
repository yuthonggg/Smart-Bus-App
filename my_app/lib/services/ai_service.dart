import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  // Replace with your own backend URL which mediates calls to the AI provider
  static const backendUrl = 'https://your-backend.example.com/ai/chat';

  static Future<String> sendMessage(String message) async {
    final resp = await http.post(
      Uri.parse(backendUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      return data['reply'] ?? 'No reply';
    } else {
      throw Exception('AI service error: ${resp.statusCode}');
    }
  }
}
