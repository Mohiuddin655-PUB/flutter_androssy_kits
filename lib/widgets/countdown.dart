import 'dart:async';

import 'package:flutter/material.dart';

typedef AndrossyCountdownBuilder = Widget Function(
  BuildContext context,
  Duration duration,
);
typedef AndrossyCountdownRemainingListener = void Function(Duration duration);
typedef AndrossyCountdownCompleteListener = void Function(bool complete);

class AndrossyCountdown extends StatefulWidget {
  final bool initialStartMode;
  final Duration target;
  final Duration decrement;
  final Duration periodic;

  final AndrossyCountdownBuilder builder;
  final AndrossyCountdownCompleteListener? onComplete;
  final AndrossyCountdownRemainingListener? onRemaining;

  const AndrossyCountdown({
    super.key,
    this.initialStartMode = true,
    this.target = const Duration(minutes: 2),
    this.decrement = const Duration(seconds: 1),
    this.periodic = const Duration(seconds: 1),
    required this.builder,
    this.onComplete,
    this.onRemaining,
  });

  @override
  State<AndrossyCountdown> createState() => AndrossyCountdownState();
}

class AndrossyCountdownState extends State<AndrossyCountdown> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialStartMode) start();
    });
  }

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _rt);
  }

  late Duration _rt = widget.target;
  Timer? _timer;
  bool _isRunning = false;

  void _cancel() {
    if (_timer != null) _timer!.cancel();
    _isRunning = false;
  }

  void clear() {
    _cancel();
    _rt = const Duration();
    _notify();
  }

  void _continue() {
    if (!_isRunning) {
      if (widget.onComplete != null) widget.onComplete?.call(false);
      _timer = Timer.periodic(widget.periodic, (ticker) {
        if (_rt.inSeconds <= 0) {
          _complete(ticker);
        } else {
          _rt = _rt - widget.decrement;
          _remaining(_rt);
        }
        _notify();
      });
    }
    _isRunning = true;
  }

  void _complete(Timer? ticker) {
    if (ticker != null) ticker.cancel();
    if (_timer != null) _timer?.cancel();
    if (widget.onComplete != null) widget.onComplete?.call(true);
  }

  void _remaining(Duration value) {
    if (widget.onRemaining != null) widget.onRemaining?.call(value);
  }

  void restart() {
    _cancel();
    _rt = widget.target;
    _notify();
    _continue();
  }

  void start() => _continue();

  void stop() => _cancel();

  void _notify() => setState(() {});
}
