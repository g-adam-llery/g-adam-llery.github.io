import 'package:flutter/material.dart';
import 'package:newui/src/presentation/screens/main_screen.dart';

class g_adam_llery_website extends StatelessWidget {
  const g_adam_llery_website({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@g.adam.llery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: const MainScreen(),
    );
  }
}