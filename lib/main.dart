import 'package:flutter/material.dart';
import 'package:my_own_chatgpt/providers/app_provider.dart';
import 'package:my_own_chatgpt/providers/model_provider.dart';
import 'package:my_own_chatgpt/ui/home/home_screen.dart';
import 'package:my_own_chatgpt/ui/splash/splash_screen.dart';
import 'package:my_own_chatgpt/utils/constants.dart';
import 'package:provider/provider.dart';

import 'providers/chat_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppProvider>(create: (_) => AppProvider()..initData()),
        ChangeNotifierProvider<ModelProvider>(create: (_) => ModelProvider()),
        ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            color: cardColor,
            titleTextStyle: TextStyle(
              fontSize: 30,
              letterSpacing: 5.0,
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
