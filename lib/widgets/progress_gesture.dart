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

  bool get _hasUpperBound => widget.max != null;

  int get _upperBound => widget.max!;

  void _hold() {
    if (widget.onStatus != null && !_status) {
      _status = true;
      widget.onStatus!(_status);
    }
    if (widget.onChanged != null) {
      _x?.cancel();
      _y?.cancel();
      _x = Timer.periodic(widget.duration, (timer) {
        if (_hasUpperBound && _value >= _upperBound) {
          timer.cancel();
          return;
        }
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
      _value = widget.min;
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
    if (widget.min != oldWidget.min || widget.max != oldWidget.max) {
      _value = _clampValue(_value);
    }
    if (!enabled) _cancelTimers();
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  int _clampValue(int value) {
    final min = widget.min;
    final max = widget.max;
    if (max != null && max < min) return min;
    if (value < min) return min;
    if (max != null && value > max) return max;
    return value;
  }

  void _cancelTimers() {
    _x?.cancel();
    _x = null;
    _y?.cancel();
    _y = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => _hold() : null,
      onTapUp: enabled ? (_) => _cancel() : null,
      onTapCancel: enabled ? _cancel : null,
      child: widget.child,
    );
  }
}
