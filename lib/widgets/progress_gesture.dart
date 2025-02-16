import 'dart:async';

import 'package:flutter/material.dart';

class AndrossyHoldGesture extends StatefulWidget {
  final bool enabled;
  final int min;
  final int? max;
  final bool useSmoothRelease;
  final Duration duration;
  final Duration? reverseDuration;
  final ValueChanged<int>? onChanged;
  final ValueChanged<bool>? onStatus;
  final Widget child;

  const AndrossyHoldGesture({
    super.key,
    this.enabled = true,
    this.min = 0,
    this.max,
    this.useSmoothRelease = false,
    this.duration = const Duration(milliseconds: 1),
    this.reverseDuration,
    this.onChanged,
    this.onStatus,
    required this.child,
  });

  @override
  State<AndrossyHoldGesture> createState() {
    return _AndrossyHoldGestureState();
  }
}

class _AndrossyHoldGestureState extends State<AndrossyHoldGesture> {
  Timer? _x;
  Timer? _y;
  int _value = 0;
  bool _status = false;

  bool get enabled {
    return widget.enabled &&
        (widget.onStatus != null || widget.onChanged != null);
  }

  void _hold() {
    if (widget.onStatus != null && !_status) {
      _status = true;
      widget.onStatus!(_status);
    }
    if (widget.onChanged != null) {
      _x?.cancel();
      _y?.cancel();
      _x = Timer.periodic(widget.duration, (timer) {
        if (_value >= (widget.max ?? 0)) return timer.cancel();
        _value++;
        widget.onChanged!(_value);
      });
    }
  }

  void _cancel() {
    if (widget.onStatus != null && _status) {
      _status = false;
      widget.onStatus!(_status);
    }
    if (widget.onChanged != null) {
      _x?.cancel();
      _y?.cancel();
      if (widget.useSmoothRelease) return _reset();
      _value = 0;
      widget.onChanged!(_value);
    }
  }

  void _reset() {
    if (widget.onChanged != null) {
      _x?.cancel();
      _y?.cancel();
      _y = Timer.periodic(widget.reverseDuration ?? widget.duration, (timer) {
        if (_value <= widget.min) return timer.cancel();
        _value--;
        widget.onChanged!(_value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _value = widget.min;
  }

  @override
  void didUpdateWidget(covariant AndrossyHoldGesture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.min != oldWidget.min) {
      _value = widget.min;
    }
  }

  @override
  void dispose() {
    _x?.cancel();
    _y?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: enabled ? (_) => _hold() : null,
      onTapUp: enabled ? (_) => _cancel() : null,
      onTapCancel: enabled ? _cancel : null,
      child: widget.child,
    );
  }
}
