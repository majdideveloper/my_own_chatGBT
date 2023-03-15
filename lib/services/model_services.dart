import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_own_chatgpt/models/model_models.dart';

import '../api_key.dart';

class ModelServices {
  static Future<List<ModelModels>> getALlModels() async {
    final response = await http.get(
        Uri.parse(
          "$BASE_URL/models",
        ),
        headers: {'Authorization': 'Bearer $API_KEY'});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body)['data'] as List;
      final models = json.map((e) {
        return ModelModels(
          id: e['id'],
        );
      }).toList();

      return models;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Models');
    }
  }
}
