import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_own_chatgpt/models/model_models.dart';

import '../api_key.dart';
import '../models/chat_model.dart';

class ChatServices {
  static Future<List<ChatModel>> sendMessageAndReceiveMessage(
      {required String model, required String message}) async {
    final response = await http.post(
        Uri.parse(
          "$BASE_URL/chat/completions",
        ),
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": message}
            ]
          },
        ),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body)['choices'] as List;
      final message = json.map((e) {
        return ChatModel(
          index: e['index'],
          text: (e['message']['content']).toString().substring(2),
        );
      }).toList();

      return message;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Models');
    }
  }
}
