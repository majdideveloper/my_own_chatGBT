import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/chat_services.dart';

class ChatProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ChatModel> _messages = [];
  List<ChatModel> get messages => _messages;

  Future<void> getMessages(
      {required String model, required String message}) async {
    isLoading = true;
    notifyListeners();

    final response = await ChatServices.sendMessageAndReceiveMessage(
        model: model, message: message);

    _messages.addAll(response);
    isLoading = false;
    notifyListeners();
  }

  clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
