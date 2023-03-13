import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_own_chatgpt/models/model_models.dart';
import 'package:my_own_chatgpt/providers/model_provider.dart';
import 'package:my_own_chatgpt/services/model_services.dart';
import 'package:my_own_chatgpt/ui/home/home_screen.dart';

class AppProvider {
  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  // question controller
  TextEditingController? _questionController;

  TextEditingController get questionController {
    _questionController ??= TextEditingController();
    return _questionController!;
  }

  // wait to do it your work ///
  ValueNotifier<bool>? _isBusyNotifier;

  ValueNotifier<bool> get isBusyNotifier {
    _isBusyNotifier ??= ValueNotifier<bool>(false);
    return _isBusyNotifier!;
  }

  set isBusy(bool newValue) {
    isBusyNotifier.value = newValue;
  }

  bool get isBusy => isBusyNotifier.value;

  // INIT THE APP AND VALUE OF MODEL

  final modelProvider = ModelProvider();

  ValueNotifier<String>? _modelValueNotifier;

  ValueNotifier<String> get modelValueNotifier {
    _modelValueNotifier ??= ValueNotifier<String>("text-davinci-003");
    return _modelValueNotifier!;
  }

  set addValueToModel(String value) {
    _modelValueNotifier!.value = value;
  }

  initData() async {
    await modelProvider.getModels();
    modelValueNotifier;
    addValueToModel = modelProvider.models[0].id;
  }

  ScrollController? _scrollListController;
  ScrollController get scrollListController {
    _scrollListController ??= ScrollController();
    return _scrollListController!;
  }

  scrollToTHeEnd() {
    _scrollListController!.animateTo(
        _scrollListController!.position.maxScrollExtent,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut);
  }
}
