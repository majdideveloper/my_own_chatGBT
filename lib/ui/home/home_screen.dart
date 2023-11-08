import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:my_own_chatgpt/providers/app_provider.dart';
import 'package:my_own_chatgpt/providers/chat_provider.dart';
import 'package:my_own_chatgpt/utils/constants.dart';
import 'package:my_own_chatgpt/utils/helper_methods.dart';

import 'package:my_own_chatgpt/widgets/text_fields.dart';
import 'package:provider/provider.dart';

import '../../providers/model_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ModelProvider>(context, listen: false).getModels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final chatProvider = context.read<ChatProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatGPT"),
        actions: [
          TextButton(
            child: const Text(
              'model',
            ),
            onPressed: () {
              showLoadingDialog(context);
            },
          ),
          IconButton(
            onPressed: () {
              chatProvider.clearMessages();
            },
            icon: const Icon(
              Icons.restart_alt,
            ),
          )
        ],
      ),
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: appProvider.scrollListController,
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: provider.messages[index].index == 0
                          ? IconButton(
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: provider.messages[index].text));
                                // copied successfully
                              },
                              icon: const Icon(
                                Icons.copy,
                                color: Colors.white,
                              ))
                          : null,
                      tileColor: provider.messages[index].index == 1
                          ? cardColor
                          : scaffoldBackgroundColor,
                      title: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Bobbers',
                        ),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          stopPauseOnTap: true,
                          repeatForever: false,
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(provider.messages[index].text),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: provider.isLoading,
                child: const SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const CustomTextFields()
            ],
          );
        },
      ),
    );
  }
}
