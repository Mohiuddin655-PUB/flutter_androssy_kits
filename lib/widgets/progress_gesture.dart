import 'dart:async';

import 'package:flutter/material.dart';

class AndrossyProgressGesture extends StatefulWidget {
  final Duration duration;
  final Duration? reverseDuration;
  final Function(double) onChanged;
  final Widget child;

  const AndrossyProgressGesture({
    super.key,
    this.duration = const Duration(seconds: 2),
    this.reverseDuration,
    required this.onChanged,
    required this.child,
  });

  @override
  State<AndrossyProgressGesture> createState() {
    return _AndrossyProgressGestureState();
  }
}

class _AndrossyProgressGestureState extends State<AndrossyProgressGesture>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  double _percentage = 0;
  DateTime _startTime = DateTime.now();
  bool _canceled = false;
  Timer? _timer;

  void _start([LongPressStartDetails? details]) {
    if (_controller == null) return;
    _canceled = false;
    _animation = Tween(begin: _percentage, end: 1.0).animate(_controller!);
    _controller!.forward(from: 0.0);
    _startTime = DateTime.now();
    _update();
  }

  void _update() {
    _timer?.cancel();
    if (_canceled) return;
    setState(() {
      final elapsed = DateTime.now().difference(_startTime).inMilliseconds;
      _percentage = (elapsed / widget.duration.inMilliseconds).clamp(0.0, 1.0);
      widget.onChanged(_percentage);
      if (_percentage < 1.0) {
        _timer = Timer(const Duration(milliseconds: 16), _update);
      }
    });
  }

  void _end([LongPressEndDetails? details]) {
    if (_controller == null) return;
    _canceled = true;
    _animation = Tween(begin: _percentage, end: 0.0).animate(_controller!);
    _controller!.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration ?? widget.duration,
    );

    _animation = Tween(begin: 0.0, end: 0.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          _percentage = _animation!.value;
          widget.onChanged(_percentage);
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _start,
      onLongPressEnd: _end,
      onLongPressUp: _end,
      child: widget.child,
    );
  }
}
