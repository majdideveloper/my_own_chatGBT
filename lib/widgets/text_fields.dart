import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_own_chatgpt/models/chat_model.dart';
import 'package:my_own_chatgpt/providers/app_provider.dart';
import 'package:my_own_chatgpt/providers/chat_provider.dart';
import 'package:my_own_chatgpt/services/model_services.dart';
import 'package:my_own_chatgpt/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = context.read<AppProvider>();
    final ChatProvider chatProvider = context.read<ChatProvider>();
    return Container(
      height: 100,
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: appProvider.questionController,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: 'How i can help you ....',
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: IconButton(
              onPressed: () async {
                String msg = appProvider.questionController.text;
                appProvider.questionController.clear();
                chatProvider.messages
                    .add(ChatModel(index: 1, text: msg.trim()));
                await chatProvider.getMessages(
                    model: appProvider.modelValueNotifier.value,
                    message: msg.trim());
                appProvider.scrollToTHeEnd();
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
