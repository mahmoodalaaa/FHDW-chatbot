import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> getChatResponse(
    String message,
    List<Map<String, String>> history,
  ) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty || apiKey == 'your_api_key_here') {
      return "⚠️ OpenAI API Key is missing or invalid. Please add your key to the .env file and restart the app.";
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final messages = [
      {
        "role": "system",
        "content":
            "You are a helpful, encouraging, and knowledgeable AI Career Assistant for high school and university students. Answer concisely and provide clear, actionable career advice. "
            "IMPORTANT: If the user provides their interests (e.g., 'I like math and programming') or explicitly asks for a job recommendation, you MUST respond ONLY with a strict JSON object matching this exact structure: "
            "{\"jobTitle\": \"...\", \"description\": \"...\", \"matchPercentage\": 95, \"salary\": \"\$95k/yr\", \"growth\": \"+13%\", \"dailyTasks\": [{\"time\": \"09:00 AM\", \"title\": \"...\", \"description\": \"...\"}]} "
            "Do NOT wrap the JSON in markdown blocks like ```json. Return ONLY the raw JSON object. If you are just chatting and not providing a specific job recommendation, you can reply as normal text.",
      },
      ...history,
      {"role": "user", "content": message},
    ];

    final body = jsonEncode({
      "model": "gpt-4o-mini",
      "messages": messages,
      "max_tokens": 300,
    });

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        print(response.body);
        return "Sorry, I ran into an error connecting to my brain. (Status: ${response.statusCode})";
      }
    } catch (e) {
      return "Error connecting to AI service: $e";
    }
  }
}
