import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef OnAndrossyGestureEffectBuilder = Widget Function(
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

  final AndrossyGestureEffect? clickEffect;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
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
    this.clickEffect,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    required this.child,
  });

  @override
  State<AndrossyGesture> createState() => _AndrossyGestureState();
}

class _AndrossyGestureState extends State<AndrossyGesture>
    with TickerProviderStateMixin {
  AndrossyGestureEffect get _effect {
    return widget.clickEffect ?? const AndrossyGestureEffect();
  }

  AnimationController? _primary, _secondary;
  Animation<double>? _primaryAnimation, _secondaryAnimation;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AndrossyGesture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clickEffect != oldWidget.clickEffect) {
      if (_primary != null) _primary?.dispose();
      if (_secondary != null) _secondary?.dispose();
      _primary = null;
      _secondary = null;
      _init();
    }
  }

  @override
  void dispose() {
    if (_isPrimaryMode) _primary!.dispose();
    if (_isSecondaryMode) _secondary!.dispose();
    super.dispose();
  }

  void _init() {
    if (_effect.primary != null && _effect.primary!.isActivated) {
      _primary = AnimationController(
        vsync: this,
        animationBehavior:
            _effect.primary?.behavior ?? AnimationBehavior.normal,
        debugLabel: _effect.primary?.debugLabel,
        duration: _effect.primary?.duration,
        reverseDuration: _effect.primary?.reverseDuration,
        value: _effect.primary?.value,
        upperBound: _effect.primary?.upperBound ?? 1,
        lowerBound: _effect.primary?.lowerBound ?? 0,
      );
      if (_effect.primary?.repeat ?? false) {
        _primary?.repeat(reverse: true);
      }
      final curve = _effect.primary?.curve ?? Curves.linear;
      _primaryAnimation = CurvedAnimation(
        parent: _primary!,
        curve: curve,
        reverseCurve: _effect.primary?.reverseCurve ?? curve,
      );
    }

    if (_effect.secondary != null && _effect.secondary!.isActivated) {
      _secondary = AnimationController(
        vsync: this,
        animationBehavior:
            _effect.secondary?.behavior ?? AnimationBehavior.normal,
        debugLabel: _effect.secondary?.debugLabel,
        duration: _effect.secondary?.duration,
        reverseDuration: _effect.secondary?.reverseDuration,
        value: _effect.secondary?.value,
        upperBound: _effect.secondary?.upperBound ?? 1,
        lowerBound: _effect.secondary?.lowerBound ?? 0,
      );
      if (_effect.secondary?.repeat ?? false) {
        _secondary?.repeat(reverse: true);
      }
      final curve = _effect.secondary?.curve ?? Curves.linear;
      _secondaryAnimation = CurvedAnimation(
        parent: _secondary!,
        curve: curve,
        reverseCurve: _effect.secondary?.reverseCurve ?? curve,
      );
    }
  }

  bool get _isPrimaryMode => _primary != null;

  bool get _isSecondaryMode => _secondary != null;

  void _animate(VoidCallback? callback) {
    if (callback == null) return;
    callback();
    if (_isPrimaryMode) {
      _primary!.reverse().whenComplete(_primary!.forward);
    }
    if (_isSecondaryMode) {
      _secondary!.reverse().whenComplete(_secondary!.forward);
    }
  }

  void _animateEnd() {
    if (_isPrimaryMode) _primary!.forward();
    if (_isSecondaryMode) _secondary!.forward();
  }

  void _animateStart() {
    if (_isPrimaryMode) _primary!.reverse();
    if (_isSecondaryMode) _secondary!.reverse();
  }

  void _onTap() async => _animate(widget.onTap);

  void _onTapUp(TapUpDetails details) => _animateEnd();

  void _onTapDown(TapDownDetails details) => _animateStart();

  void _onTapCancel() => _animateEnd();

  bool get _inkwell {
    return widget.enableFeedback ||
        widget.splashColor != null ||
        widget.highlightColor != null ||
        widget.onHover != null;
  }

  bool get _isHoldMode {
    return (_isPrimaryMode || _isSecondaryMode) &&
        widget.onTap != null &&
        widget.onDoubleTap == null &&
        widget.onLongPress == null;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visibility) return const SizedBox.shrink();
    Widget child = widget.child;

    if (widget.enabled) {
      if (_inkwell) {
        child = InkWell(
          mouseCursor: widget.mouseCursor,
          enableFeedback: widget.enableFeedback,
          overlayColor: widget.overlayColor,
          splashFactory: widget.splashFactory,
          splashColor: widget.splashColor ?? Colors.transparent,
          hoverColor: widget.hoverColor ?? Colors.transparent,
          highlightColor: widget.highlightColor ?? Colors.transparent,
          onHover: widget.onHover,
          onTap: widget.onTap != null ? _onTap : null,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongPress,
          onTapUp: _isHoldMode ? _onTapUp : null,
          onTapDown: _isHoldMode ? _onTapDown : null,
          onTapCancel: _isHoldMode ? _onTapCancel : null,
          child: child,
        );
      } else {
        child = GestureDetector(
          onTap: widget.onTap != null ? _onTap : null,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongPress,
          onTapUp: _isHoldMode ? _onTapUp : null,
          onTapDown: _isHoldMode ? _onTapDown : null,
          onTapCancel: _isHoldMode ? _onTapCancel : null,
          child: child,
        );
      }

      if (kIsWeb) {
        return RepaintBoundary(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: child,
          ),
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

    if (_isSecondaryMode && _effect.secondary != null) {
      child = _effect.secondary!._build(
        context: context,
        animation: _secondaryAnimation!,
        child: child,
      );
    }
    if (_isPrimaryMode && _effect.primary != null) {
      child = _effect.primary!._build(
        context: context,
        animation: _primaryAnimation!,
        child: child,
      );
    }

    return child;
  }
}

class AndrossyGestureEffect {
  final AndrossyGestureAnimation? primary;
  final AndrossyGestureAnimation? secondary;

  bool get isActivated {
    return (primary?.isActivated ?? false) || (secondary?.isActivated ?? false);
  }

  const AndrossyGestureEffect({
    this.primary,
    this.secondary,
  });

  AndrossyGestureEffect.fade({
    AnimationBehavior behavior = AnimationBehavior.normal,
    Curve curve = Curves.linear,
    String? debugLabel,
    Duration duration = const Duration(milliseconds: 130),
    Curve? reverseCurve,
    Duration? reverseDuration,
    double value = 1.0,
    double upperBound = 1.0,
    double lowerBound = 0.75,
    double? begin,
    double? end,
    bool repeat = false,
  }) : this(
          primary: AndrossyGestureAnimation.fade(
            behavior: behavior,
            curve: curve,
            debugLabel: debugLabel,
            duration: duration,
            reverseCurve: reverseCurve,
            reverseDuration: reverseDuration,
            value: value,
            upperBound: upperBound,
            lowerBound: lowerBound,
            repeat: repeat,
          ),
        );

  AndrossyGestureEffect.scale({
    AnimationBehavior behavior = AnimationBehavior.normal,
    Curve curve = Curves.linear,
    String? debugLabel,
    Duration duration = const Duration(milliseconds: 130),
    Curve? reverseCurve,
    Duration? reverseDuration,
    double value = 1.0,
    double upperBound = 1.0,
    double lowerBound = 0.95,
    bool repeat = false,
  }) : this(
          primary: AndrossyGestureAnimation.scale(
            behavior: behavior,
            curve: curve,
            debugLabel: debugLabel,
            duration: duration,
            reverseCurve: reverseCurve,
            reverseDuration: reverseDuration,
            value: value,
            upperBound: upperBound,
            lowerBound: lowerBound,
            repeat: repeat,
          ),
        );

  AndrossyGestureEffect.bounce({
    AnimationBehavior behavior = AnimationBehavior.normal,
    Curve curve = Curves.bounceInOut,
    String? debugLabel,
    Duration duration = const Duration(milliseconds: 130),
    Curve? reverseCurve,
    Duration? reverseDuration,
    double value = 1.0,
    double upperBound = 1.2,
    double lowerBound = 1.0,
    bool repeat = false,
  }) : this(
          primary: AndrossyGestureAnimation.bounce(
            behavior: behavior,
            curve: curve,
            debugLabel: debugLabel,
            duration: duration,
            reverseCurve: reverseCurve,
            reverseDuration: reverseDuration,
            value: value,
            upperBound: upperBound,
            lowerBound: lowerBound,
            repeat: repeat,
          ),
        );

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

class AndrossyGestureAnimation {
  final AnimationBehavior behavior;
  final Curve curve;
  final Curve? reverseCurve;
  final String? debugLabel;
  final Duration duration;
  final Duration? reverseDuration;
  final _Effects _effect;
  final double value;
  final double lowerBound;
  final double upperBound;
  final bool repeat;
  final double? begin;
  final double? end;
  final OnAndrossyGestureEffectBuilder? builder;

  bool get isActivated =>
      _effect != _Effects.none &&
      duration != Duration.zero &&
      ((lowerBound != 1 && upperBound > 0) ||
          (begin != null && end != null) ||
          builder != null);

  const AndrossyGestureAnimation.none() : this();

  const AndrossyGestureAnimation({
    this.builder,
    this.behavior = AnimationBehavior.normal,
    this.debugLabel,
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
  }) : _effect = builder != null ? _Effects.custom : _Effects.none;

  const AndrossyGestureAnimation.scale({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.debugLabel,
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.95,
    this.repeat = false,
  })  : _effect = _Effects.scale,
        builder = null,
        begin = null,
        end = null;

  const AndrossyGestureAnimation.bounce({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.bounceInOut,
    this.debugLabel,
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.value = 1.0,
    this.repeat = false,
    double upperBound = 1.2,
    double lowerBound = 1.0,
  })  : _effect = _Effects.scale,
        builder = null,
        upperBound = 1,
        lowerBound = 0,
        begin = upperBound,
        end = lowerBound;

  const AndrossyGestureAnimation.rotate({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.bounceInOut,
    this.debugLabel,
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.value = 1.0,
    this.repeat = false,
    double upperBound = 1.2,
    double lowerBound = 1.0,
  })  : _effect = _Effects.scale,
        builder = null,
        upperBound = 1,
        lowerBound = 0,
        begin = upperBound,
        end = lowerBound;

  const AndrossyGestureAnimation.fade({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.debugLabel,
    this.duration = const Duration(milliseconds: 130),
    this.reverseCurve,
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.75,
    this.repeat = false,
  })  : _effect = _Effects.fade,
        builder = null,
        begin = null,
        end = null;

  Tween<double>? get _tween {
    if (begin == null && end == null) return null;
    return Tween<double>(begin: begin, end: end);
  }

  Widget _build({
    required BuildContext context,
    required Animation<double> animation,
    required Widget child,
  }) {
    final anim = _tween != null ? _tween!.animate(animation) : animation;
    switch (_effect) {
      case _Effects.fade:
        return FadeTransition(opacity: anim, child: child);
      case _Effects.scale:
        return ScaleTransition(scale: anim, child: child);
      case _Effects.custom:
        return builder?.call(context, anim, child) ?? child;
      case _Effects.none:
        return child;
    }
  }

  @override
  int get hashCode =>
      _effect.hashCode ^
      duration.hashCode ^
      lowerBound.hashCode ^
      upperBound.hashCode ^
      repeat.hashCode ^
      begin.hashCode ^
      end.hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

enum _Effects { fade, scale, custom, none }
