import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with LifecycleMixin {
  @override
  void onCreate() {
    super.onCreate();
    log('onCreate');
    // Initialize resources
  }

  @override
  void onResume() {
    super.onResume();
    log('onResume');
    // Start animations, subscribe to streams
  }

  @override
  void onPause() {
    super.onPause();
    log('onPause');
    // Pause animations, unsubscribe from streams
  }

  @override
  void onStart() {
    super.onStart();
    log('onStart');
  }

  @override
  void onStop() {
    super.onStop();
    log('onStop');
  }

  @override
  void onDestroy() {
    super.onDestroy();
    log('onDestroy');
  }

  @override
  void onRestart() {
    super.onRestart();
    log('onRestart');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Hello World!",
        ),
      ),
    ); // Your widget UI
  }
}
