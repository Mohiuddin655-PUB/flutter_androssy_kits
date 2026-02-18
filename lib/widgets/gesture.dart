import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef GestureAnimationBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget child,
);

class AndrossyGesture extends StatefulWidget {
  final double elevation;
  final Color? elevationColor;
  final bool enableFeedback;
  final Color? highlightColor;
  final Color? hoverColor;
  final MaterialType? materialType;
  final MouseCursor? mouseCursor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final WidgetStateProperty<Color?>? overlayColor;

  final bool visibility;

  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clipBehavior;
  final ShapeBorder? shape;

  final bool enabled;

  final List<GestureAnimation>? effects;
  final GestureTapCallback? onTap;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final GestureDoubleTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressCancelCallback? onLongPressCancel;
  final ValueChanged<bool>? onHover;

  final Widget child;

  const AndrossyGesture({
    super.key,
    this.visibility = true,
    this.elevation = 0,
    this.elevationColor,
    this.borderRadius,
    this.backgroundColor,
    this.clipBehavior,
    this.enabled = true,
    this.enableFeedback = true,
    this.materialType,
    this.mouseCursor,
    this.overlayColor,
    this.shape,
    this.splashColor,
    this.splashFactory,
    this.hoverColor,
    this.highlightColor,
    this.effects,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressCancel,
    this.onHover,
    required this.child,
  });

  @override
  State<AndrossyGesture> createState() => _AndrossyGestureState();
}

class _AndrossyGestureState extends State<AndrossyGesture>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  Timer? _timer;

  bool _called = false;

  bool get _hasAnimations => _controllers.isNotEmpty;

  bool get _isRepeatMode {
    return _effects.any((effect) => effect.repeat);
  }

  bool get _inkwell {
    return widget.enableFeedback ||
        widget.splashColor != null ||
        widget.highlightColor != null ||
        widget.onHover != null;
  }

  bool get _isHoldMode {
    if (_isRepeatMode) return false;
    if (!_hasAnimations) return false;
    if (widget.onDoubleTap != null) return false;
    if (widget.onTap != null) return true;
    if (widget.onTapDown != null) return true;
    return false;
  }

  bool get _isLongPressHoldMode {
    if (_isRepeatMode) return false;
    if (!_hasAnimations) return false;
    return widget.onLongPress != null;
  }

  List<GestureAnimation> get _effects => widget.effects ?? [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AndrossyGesture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.effects != oldWidget.effects) {
      _disposeControllers();
      _init();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
    _animations.clear();
  }

  void _init() {
    for (var effect in _effects) {
      if (effect.isActivated) {
        final controller = AnimationController(
          vsync: this,
          animationBehavior: effect.behavior,
          debugLabel: effect.debugLabel,
          duration: effect.duration,
          reverseDuration: effect.reverseDuration,
          value: effect.value,
          upperBound: effect.upperBound,
          lowerBound: effect.lowerBound,
        );

        if (effect.repeat) {
          controller.repeat(reverse: true);
        }

        final curve = effect.curve;
        final animation = CurvedAnimation(
          parent: controller,
          curve: curve,
          reverseCurve: effect.reverseCurve ?? curve,
        );

        _controllers.add(controller);
        _animations.add(animation);
      }
    }
  }

  void _caller(VoidCallback callback) {
    if (_called) return;
    _called = true;
    callback();
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: 1500), () {
      _called = false;
      _timer?.cancel();
    });
  }

  void _animate(VoidCallback? callback) {
    if (callback == null) return;
    callback();
    if (_isRepeatMode) return;

    for (var controller in _controllers) {
      controller.reverse().whenComplete(controller.forward);
    }
  }

  void _animateEnd() {
    if (_isRepeatMode) return;
    for (var controller in _controllers) {
      controller.forward();
    }
  }

  void _animateStart() {
    if (_isRepeatMode) return;
    for (var controller in _controllers) {
      controller.reverse();
    }
  }

  void _onHover(bool status) async {
    if (status) {
      _animateStart();
      widget.onHover?.call(true);
    } else {
      _animateEnd();
      widget.onHover?.call(false);
    }
  }

  void _onTap() async {
    if (widget.onTap != null) {
      _caller(() => _animate(widget.onTap));
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animateEnd();
    widget.onTapUp?.call(details);
  }

  void _onTapDown(TapDownDetails details) {
    _animateStart();
    if (widget.onTapDown != null) {
      _caller(() => widget.onTapDown!(details));
    }
  }

  void _onTapCancel() {
    _animateEnd();
    widget.onTapCancel?.call();
  }

  void _onDoubleTap() async => _animate(widget.onDoubleTap);

  void _onLongPressStart(LongPressStartDetails details) {
    widget.onLongPressStart?.call(details);
    widget.onLongPress?.call();
    _animateStart();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    _animateEnd();
    widget.onLongPressEnd?.call(details);
  }

  void _onLongPressCancel() {
    _animateEnd();
    widget.onLongPressCancel?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visibility) return const SizedBox.shrink();
    Widget child = widget.child;

    if (widget.enabled) {
      if (_inkwell && widget.onLongPress == null) {
        child = Stack(
          children: [
            child,
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: InkWell(
                  mouseCursor: widget.mouseCursor,
                  enableFeedback: widget.enableFeedback,
                  overlayColor: widget.overlayColor,
                  splashFactory: widget.splashFactory,
                  splashColor: widget.splashColor ?? Colors.transparent,
                  hoverColor: widget.hoverColor ?? Colors.transparent,
                  highlightColor: widget.highlightColor ?? Colors.transparent,
                  onHover: widget.onHover != null ? _onHover : null,
                  onTap: widget.onTap != null ? _onTap : null,
                  onDoubleTap: widget.onDoubleTap != null ? _onDoubleTap : null,
                  onTapUp: _isHoldMode ? _onTapUp : null,
                  onTapDown: _isHoldMode ? _onTapDown : null,
                  onTapCancel: _isHoldMode ? _onTapCancel : null,
                ),
              ),
            ),
          ],
        );
      } else {
        child = GestureDetector(
          onTap: widget.onTap != null ? _onTap : null,
          onDoubleTap: widget.onDoubleTap != null ? _onDoubleTap : null,
          onLongPress: !_isLongPressHoldMode ? widget.onLongPress : null,
          onLongPressStart: _isLongPressHoldMode ? _onLongPressStart : null,
          onLongPressEnd: _isLongPressHoldMode ? _onLongPressEnd : null,
          onLongPressCancel: _isLongPressHoldMode ? _onLongPressCancel : null,
          onTapUp: _isHoldMode ? _onTapUp : null,
          onTapDown: _isHoldMode ? _onTapDown : null,
          onTapCancel: _isHoldMode ? _onTapCancel : null,
          child: child,
        );
      }

      if (kIsWeb) {
        child = RepaintBoundary(
          child: MouseRegion(cursor: SystemMouseCursors.click, child: child),
        );
      }
    }

    if (widget.elevation > 0 ||
        widget.backgroundColor != null ||
        widget.shape != null ||
        widget.borderRadius != null) {
      child = Material(
        elevation: widget.elevation,
        shadowColor: widget.elevationColor,
        borderRadius: widget.borderRadius,
        color: widget.backgroundColor,
        surfaceTintColor: Colors.transparent,
        clipBehavior: widget.clipBehavior ?? Clip.antiAlias,
        shape: widget.shape,
        type: widget.materialType ?? MaterialType.canvas,
        child: child,
      );
    }

    for (int i = 0; i < _effects.length; i++) {
      if (_effects[i].isActivated && i < _animations.length) {
        child = _effects[i]._build(context, _animations[i], child);
      }
    }

    return child;
  }
}

class GestureAnimation {
  final AnimationBehavior behavior;
  final Curve curve;
  final Curve? reverseCurve;
  final String? debugLabel;
  final Duration duration;
  final Duration? reverseDuration;
  final GestureAnimations _effect;
  final double value;
  final double lowerBound;
  final double upperBound;
  final bool repeat;
  final double? begin;
  final double? end;
  final GestureAnimationBuilder? builder;

  final _EffectData? _data;

  bool get isActivated =>
      _effect != GestureAnimations.none &&
      duration != Duration.zero &&
      ((lowerBound != 1 && upperBound > 0) ||
          (begin != null && end != null) ||
          builder != null);

  const GestureAnimation.none() : this(builder: null);

  const GestureAnimation({
    required this.builder,
    this.behavior = AnimationBehavior.normal,
    this.debugLabel = 'custom',
    this.duration = const Duration(milliseconds: 130),
    this.curve = Curves.linear,
    this.reverseCurve,
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.repeat = false,
    this.begin,
    this.end,
  })  : _effect =
            builder != null ? GestureAnimations.custom : GestureAnimations.none,
        _data = null;

  const GestureAnimation.scale({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'scale',
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    double target = 0.95,
    this.end = 1.0,
    this.repeat = false,
  })  : _effect = GestureAnimations.scale,
        begin = target,
        builder = null,
        _data = null;

  const GestureAnimation.rotate({
    this.behavior = AnimationBehavior.normal,
    Curve curve = Curves.easeInOut,
    this.debugLabel = 'rotate',
    this.duration = const Duration(milliseconds: 130),
    Curve? reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    double target = 1.01,
    double end = 1.0,
    this.repeat = false,
  })  : _effect = GestureAnimations.rotate,
        curve = repeat ? Curves.linear : curve,
        reverseCurve =
            repeat && reverseCurve != null ? Curves.linear : reverseCurve,
        begin = repeat ? 1 - (target - 1) : target,
        end = repeat ? 1 + (target - 1) : end,
        builder = null,
        _data = null;

  const GestureAnimation.fade({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'fade',
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    double target = 0.75,
    this.end = 1.0,
    this.repeat = false,
  })  : _effect = GestureAnimations.fade,
        begin = target,
        builder = null,
        _data = null;

  GestureAnimation.pendulum({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'pendulum',
    this.duration = const Duration(milliseconds: 400),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double angleDegree = 1.0,
    int swings = 1,
  })  : _effect = GestureAnimations.pendulum,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(intensity: angleDegree, count: swings);

  GestureAnimation.shake({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'shake',
    this.duration = const Duration(milliseconds: 400),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double intensity = 4.0,
    int shakes = 3,
  })  : _effect = GestureAnimations.shake,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(intensity: intensity, count: shakes);

  GestureAnimation.swing({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'swing',
    this.duration = const Duration(milliseconds: 1500),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double angleDegree = 1.0,
    double chainLength = 1.0,
    int swings = 1,
  })  : _effect = GestureAnimations.swing,
        begin = angleDegree / 360.0,
        end = chainLength,
        builder = null,
        _data = _EffectData(count: swings);

  GestureAnimation.wave({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.debugLabel = 'wave',
    this.duration = const Duration(milliseconds: 400),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double amplitude = 1.0,
    int waves = 1,
    bool horizontal = false,
  })  : _effect = GestureAnimations.wave,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(
          intensity: amplitude,
          count: waves,
          shadowOffset: Offset(horizontal ? 1.0 : 0.0, 0.0),
        );

  GestureAnimation.wiggle({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeInOut,
    this.debugLabel = 'wiggle',
    this.duration = const Duration(milliseconds: 400),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double angleDeg = 5.0,
    int wiggles = 3,
  })  : _effect = GestureAnimations.wiggle,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(intensity: angleDeg, count: wiggles);

  GestureAnimation.depth({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeOut,
    this.debugLabel = 'depth',
    this.duration = const Duration(milliseconds: 300),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double depth = 0.0,
    double shadowBlur = 20.0,
    Color? shadowColor,
    Offset? shadowOffset,
    BorderRadius? shadowRadius,
    double shadowSpread = 0.0,
  })  : _effect = GestureAnimations.depth,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(
          intensity: depth,
          shadowBlur: shadowBlur,
          shadowColor: shadowColor,
          shadowRadius: shadowRadius,
          shadowSpread: shadowSpread,
          shadowOffset: shadowOffset ?? Offset.zero,
        );

  GestureAnimation.elevate({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeOut,
    this.debugLabel = 'elevate',
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    double liftPixels = 4.0,
  })  : _effect = GestureAnimations.elevate,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(intensity: liftPixels);

  GestureAnimation.push({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.easeOut,
    this.debugLabel = 'push',
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.upperBound = 1.0,
    this.lowerBound = 0.0,
    this.value = 1.0,
    this.repeat = false,
    required Widget shadow,
    Offset shadowOffset = const Offset(0, 7),
  })  : _effect = GestureAnimations.push,
        begin = null,
        end = null,
        builder = null,
        _data = _EffectData(shadow: shadow, shadowOffset: shadowOffset);

  Tween<double>? get _tween {
    if (begin == null && end == null) return null;
    return Tween<double>(begin: begin, end: end);
  }

  Widget _build(BuildContext c, Animation<double> a, Widget w) {
    final anim = _tween != null ? _tween!.animate(a) : a;
    switch (_effect) {
      case GestureAnimations.fade:
        return FadeTransition(opacity: anim, child: w);

      case GestureAnimations.scale:
        return ScaleTransition(scale: anim, child: w);

      case GestureAnimations.rotate:
        if (repeat && begin != null) {
          return AnimatedBuilder(
            animation: anim,
            builder: (ctx, ch) {
              final t = anim.value;
              final offset = begin! - 1.0;
              final turns = 1.0 + offset * math.sin(t * 2 * math.pi);
              return RotationTransition(
                turns: AlwaysStoppedAnimation(turns),
                child: ch,
              );
            },
            child: w,
          );
        }
        return RotationTransition(turns: anim, child: w);

      case GestureAnimations.depth:
        final data = _data!;
        final depth = data.intensity;
        final shadowBlur = data.shadowBlur;
        final shadowColor =
            data.shadowColor ?? Colors.grey.withValues(alpha: 0.25);
        final shadowOffset = data.shadowOffset;
        final shadowSpread = data.shadowSpread;

        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = 1.0 - anim.value;
            final z = depth * t;

            final cb = shadowBlur * t;
            final cs = shadowSpread * t;
            final co = (shadowColor.a * t).clamp(0.0, 1.0);
            final of = shadowOffset * t;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                if (t > 0.01)
                  Positioned.fill(
                    top: z * 0.3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: data.shadowRadius,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withValues(alpha: co),
                            blurRadius: cb,
                            spreadRadius: cs,
                            offset: of,
                          ),
                        ],
                      ),
                    ),
                  ),
                ch!,
              ],
            );
          },
          child: w,
        );

      case GestureAnimations.elevate:
        final data = _data!;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final lift = -(1.0 - anim.value) * data.intensity;
            return Transform.translate(offset: Offset(0, lift), child: ch);
          },
          child: w,
        );

      case GestureAnimations.pendulum:
        final data = _data!;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = anim.value;
            final angle = math.sin(t * data.count * 2 * math.pi) *
                (data.intensity * math.pi / 180);
            return Transform.rotate(
              angle: angle,
              alignment: Alignment.topCenter,
              child: ch,
            );
          },
          child: w,
        );

      case GestureAnimations.push:
        final data = _data!;
        final ox = data.shadowOffset.dx;
        final oy = data.shadowOffset.dy;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final progress = 1.0 - anim.value;
            final dx = ox * progress;
            final dy = oy * progress;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  left: ox,
                  top: oy,
                  right: -ox,
                  bottom: -oy,
                  child: data.shadow ?? SizedBox.shrink(),
                ),
                Transform.translate(offset: Offset(dx, dy), child: ch!),
              ],
            );
          },
          child: w,
        );

      case GestureAnimations.shake:
        final data = _data!;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = 1.0 - anim.value;
            final dx =
                math.sin(t * data.count * 2 * math.pi) * data.intensity * t;
            return Transform.translate(offset: Offset(dx, 0), child: ch);
          },
          child: w,
        );

      case GestureAnimations.swing:
        final data = _data!;
        final angleDeg = (begin ?? 25.0) * 360.0;
        final length = end ?? 100.0;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = anim.value;
            final angleRad = math.sin(t * data.count * 2 * math.pi) *
                (angleDeg * math.pi / 180);
            final dx = length * math.sin(angleRad);
            final dy = length * (1 - math.cos(angleRad));
            return Transform.translate(
              offset: Offset(dx, dy),
              child: Transform.rotate(
                angle: angleRad,
                alignment: Alignment.topCenter,
                child: ch,
              ),
            );
          },
          child: w,
        );

      case GestureAnimations.wave:
        final data = _data!;
        final isHorizontal = data.shadowOffset.dx > 0;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = anim.value;
            final offset =
                math.sin(t * data.count * 2 * math.pi) * data.intensity;
            return Transform.translate(
              offset: isHorizontal ? Offset(offset, 0) : Offset(0, offset),
              child: ch,
            );
          },
          child: w,
        );
      case GestureAnimations.wiggle:
        final data = _data!;
        return AnimatedBuilder(
          animation: anim,
          builder: (ctx, ch) {
            final t = 1.0 - anim.value;
            final angle = math.sin(t * data.count * 2 * math.pi) *
                (data.intensity * math.pi / 180) *
                t;
            return Transform.rotate(angle: angle, child: ch);
          },
          child: w,
        );

      case GestureAnimations.custom:
        return builder?.call(c, anim, w) ?? w;

      case GestureAnimations.none:
        return w;
    }
  }

  @override
  int get hashCode {
    return Object.hash(
      _effect,
      duration,
      repeat,
      begin,
      end,
      lowerBound,
      upperBound,
      _data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! GestureAnimation) return false;
    if (other._effect != _effect) return false;
    if (other.duration != duration) return false;
    if (other.repeat != repeat) return false;
    if (other.begin != begin) return false;
    if (other.end != end) return false;
    if (other.lowerBound != lowerBound) return false;
    if (other.upperBound != upperBound) return false;
    if (other._data != _data) return false;
    return true;
  }
}

enum GestureAnimations {
  fade,
  scale,
  rotate,
  pendulum,
  shake,
  swing,
  wave,
  wiggle,
  push,
  depth,
  elevate,
  custom,
  none,
}

class _EffectData {
  final double intensity;
  final int count;
  final Widget? shadow;
  final Color? shadowColor;
  final Offset shadowOffset;
  final double shadowBlur;
  final BorderRadius? shadowRadius;
  final double shadowSpread;

  const _EffectData({
    this.intensity = 0,
    this.count = 3,
    this.shadow,
    this.shadowBlur = 0,
    this.shadowColor,
    this.shadowRadius,
    this.shadowSpread = 0,
    this.shadowOffset = Offset.zero,
  });

  @override
  int get hashCode {
    return Object.hash(
      intensity,
      count,
      shadow,
      shadowBlur,
      shadowColor,
      shadowOffset,
      shadowRadius,
      shadowSpread,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! _EffectData) return false;
    if (other.intensity != intensity) return false;
    if (other.count != count) return false;
    if (other.shadow != shadow) return false;
    if (other.shadowBlur != shadowBlur) return false;
    if (other.shadowColor != shadowColor) return false;
    if (other.shadowOffset != shadowOffset) return false;
    if (other.shadowRadius != shadowRadius) return false;
    if (other.shadowSpread != shadowSpread) return false;
    return true;
  }
}
