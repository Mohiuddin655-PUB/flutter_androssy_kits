import 'package:example/gesture.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Androssy Kits',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.only(
            left: 24,
            right: 20,
            top: 12,
            bottom: 12,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue,
            secondary: Colors.blue.withOpacity(0.1),
            tertiary: Colors.grey.shade200,
            onPrimary: Colors.white,
            onSecondary: Colors.blue,
            onTertiary: Colors.black38,
          ),
        ),
      ),
      home: const GestureExample(),
    );
  }
}
