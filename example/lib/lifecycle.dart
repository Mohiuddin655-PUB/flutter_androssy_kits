import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/utils.dart';

int savedInstance = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LifecycleDemo(),
    );
  }
}

class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({super.key});

  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> with LifecycleMixin {
  late int _counter;
  late ValueNotifier<int> _counterNotifier;

  StreamSubscription? _dataSubscription;

  void _log(String event) {
    log(event, name: "LIFE_CYCLE");
  }

  @override
  Future<void> onCreate() async {
    super.onCreate();
    _log('onCreate');

    // Initialize controllers and resources
    _counter = 0;
    _counterNotifier = ValueNotifier(0);
  }

  void _loadInitialData() {
    // Simulate loading data
    Future.delayed(const Duration(seconds: 1), () {
      _counter = savedInstance;
      if (mounted) setState(() {});
    });
  }

  void _setupEventListeners() {
    _counterNotifier.addListener(() {
      _counter = _counterNotifier.value;
      setState(() {});
    });
  }

  @override
  void onReady() {
    super.onReady();
    _log('onReady -> INITIALIZED_TIME: ${initializedTime.inMilliseconds} ms');
  }

  @override
  void onStart() {
    super.onStart();
    _log('onStart');

    // Load initial data and set up listeners
    _loadInitialData();
    _setupEventListeners();
  }

  void _subscribeToDataStream() {
    _dataSubscription = Stream.periodic(
      const Duration(seconds: 1),
    ).listen((_) {
      _counterNotifier.value = _counter + 1;
    });
  }

  @override
  void onResume() {
    super.onResume();
    _log('onResume');

    // Start real-time updates and subscriptions
    _subscribeToDataStream();
  }

  void _saveCurrentState() {
    savedInstance = _counter;
  }

  @override
  void onPause() {
    super.onPause();
    _log('onPause');

    // Pause updates and save state
    _dataSubscription?.pause();
    _saveCurrentState();
  }

  void _removeEventListeners() {
    _counterNotifier.removeListener(() {
      _counter = _counterNotifier.value;
      setState(() {});
    });
  }

  @override
  void onStop() {
    super.onStop();
    _log('onStop');

    // Clean up subscriptions and listeners
    _dataSubscription?.cancel();
    _removeEventListeners();
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _log('onDestroy -> DISPLAY_TIME: ${endTime.inMilliseconds} ms');

    // Dispose all controllers and resources
    _counterNotifier.dispose();
  }

  void _restoreSavedState() {
    _counter = savedInstance;
  }

  @override
  void onRestart() {
    super.onRestart();
    _log('onRestart');

    // Restore state and refresh data
    _restoreSavedState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LifecycleDemo();
              },
            ),
          );
        },
        child: const Text("Go"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _counter.toString(),
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Hello World!"),
          ],
        ),
      ),
    );
  }
}
