import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef OnAndrossyGestureEffectBuilder = Widget Function(
  BuildContext context,
  Animation<double> primary,
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
  final ValueChanged<BuildContext>? onTap;
  final ValueChanged<BuildContext>? onDoubleTap;
  final ValueChanged<BuildContext>? onLongPress;
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
    if (_effect.primary != null && _effect.primary!._effect != _Effects.none) {
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
      final curve = _effect.primary?.curve ?? Curves.linear;
      _primaryAnimation = CurvedAnimation(
        parent: _primary!,
        curve: curve,
        reverseCurve: _effect.primary?.reverseCurve ?? curve,
      );
    }

    if (_effect.secondary != null &&
        _effect.secondary!._effect != _Effects.none) {
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

  void _animate(ValueChanged<BuildContext>? callback) {
    if (callback == null) return;
    callback(context);
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

  @override
  void dispose() {
    if (_isPrimaryMode) _primary!.dispose();
    if (_isSecondaryMode) _secondary!.dispose();
    super.dispose();
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
          onDoubleTap: widget.onDoubleTap != null
              ? () => widget.onDoubleTap!(context)
              : null,
          onLongPress: widget.onLongPress != null
              ? () => widget.onLongPress!(context)
              : null,
          onTapUp: _isHoldMode ? _onTapUp : null,
          onTapDown: _isHoldMode ? _onTapDown : null,
          onTapCancel: _isHoldMode ? _onTapCancel : null,
          child: child,
        );
      } else {
        child = GestureDetector(
          onTap: widget.onTap != null ? _onTap : null,
          onDoubleTap: widget.onDoubleTap != null
              ? () => widget.onDoubleTap!(context)
              : null,
          onLongPress: widget.onLongPress != null
              ? () => widget.onLongPress!(context)
              : null,
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
          ),
        );
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
  final OnAndrossyGestureEffectBuilder? builder;

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
    this.lowerBound = 0.9,
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
  })  : _effect = _Effects.scale,
        builder = null;

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
  })  : _effect = _Effects.fade,
        builder = null;

  Widget _build({
    required BuildContext context,
    required Animation<double> animation,
    required Widget child,
  }) {
    switch (_effect) {
      case _Effects.scale:
        return ScaleTransition(
          scale: animation,
          filterQuality: FilterQuality.low,
          child: child,
        );
      case _Effects.fade:
        return FadeTransition(opacity: animation, child: child);
      case _Effects.custom:
        return builder?.call(context, animation, child) ?? child;
      case _Effects.none:
        return child;
    }
  }
}

enum _Effects { fade, scale, custom, none }
