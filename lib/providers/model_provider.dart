import 'package:flutter/material.dart';
import 'package:my_own_chatgpt/models/model_models.dart';
import 'package:my_own_chatgpt/services/model_services.dart';

class ModelProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ModelModels> _models = [];
  List<ModelModels> get models => _models;

  Future<void> getModels() async {
    isLoading = true;
    notifyListeners();

    final response = await ModelServices.getALlModels();

    _models = response;
    isLoading = false;
    notifyListeners();
  }
}
