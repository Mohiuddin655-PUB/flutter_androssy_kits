import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnAndrossyGestureClickListener = void Function(BuildContext context);

typedef OnClickEffectBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget child,
);

class AndrossyGesture extends StatelessWidget {
  final bool visibility;
  final EdgeInsetsGeometry? margin;

  final Color? background;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clipBehavior;
  final ShapeBorder? shape;

  final double elevation;
  final bool enabled;
  final bool haptic;

  final Color? highlightColor;
  final Color? hoverColor;
  final Color? splashColor;

  final GestureClickEffect? clickEffect;
  final OnAndrossyGestureClickListener? onClick;
  final OnAndrossyGestureClickListener? onDoubleClick;
  final OnAndrossyGestureClickListener? onLongClick;
  final void Function(bool status)? onHover;

  final Widget child;

  const AndrossyGesture({
    super.key,
    this.visibility = true,
    this.margin,
    this.elevation = 0,
    this.borderRadius,
    this.background,
    this.clipBehavior,
    this.enabled = true,
    this.haptic = true,
    this.shape,
    this.splashColor,
    this.hoverColor,
    this.highlightColor,
    this.clickEffect,
    this.onClick,
    this.onDoubleClick,
    this.onLongClick,
    this.onHover,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();
    Widget child = this.child;
    if (elevation > 0 || background != null || borderRadius != null) {
      child = Material(
        elevation: elevation,
        borderRadius: borderRadius,
        color: background,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        shape: shape,
        child: _Listener(
          haptic: haptic,
          splashColor: splashColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          clickEffect: clickEffect,
          onClick: enabled && isClickable ? _onClick : null,
          onDoubleClick: enabled ? onDoubleClick : null,
          onLongClick: enabled ? onLongClick : null,
          onHover: enabled ? onHover : null,
          child: child,
        ),
      );
      if (margin != null) {
        child = Padding(padding: margin!, child: child);
      }
    } else {
      child = _Listener(
        haptic: haptic,
        splashColor: splashColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        clickEffect: clickEffect,
        onClick: enabled && isClickable ? _onClick : null,
        onDoubleClick: enabled ? onDoubleClick : null,
        onLongClick: enabled ? onLongClick : null,
        onHover: enabled ? onHover : null,
        child: child,
      );
    }
    if (enabled && kIsWeb) {
      return RepaintBoundary(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: child,
        ),
      );
    } else {
      return child;
    }
  }

  bool get isClickable => onClick != null;

  void _onClick(BuildContext context) {
    if (isClickable) {
      onClick!(context);
    }
  }
}

class _Listener extends StatefulWidget {
  final bool haptic;
  final Color? splashColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Widget child;
  final GestureClickEffect? clickEffect;
  final OnAndrossyGestureClickListener? onClick;
  final OnAndrossyGestureClickListener? onDoubleClick;
  final OnAndrossyGestureClickListener? onLongClick;
  final void Function(bool status)? onHover;

  const _Listener({
    this.haptic = true,
    this.splashColor,
    this.hoverColor,
    this.highlightColor,
    this.clickEffect,
    this.onClick,
    this.onDoubleClick,
    this.onLongClick,
    this.onHover,
    required this.child,
  });

  @override
  State<_Listener> createState() => _ListenerState();
}

class _ListenerState extends State<_Listener>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  GestureClickEffect get _effect {
    return widget.clickEffect ?? const GestureClickEffect();
  }

  @override
  void initState() {
    super.initState();
    if (!_effect._effect.isNone) {
      _controller = AnimationController(
        vsync: this,
        animationBehavior: _effect.behavior,
        duration: _effect.duration,
        reverseDuration: _effect.reverseDuration,
        value: _effect.value,
        upperBound: _effect.upperBound,
        lowerBound: _effect.lowerBound,
      );
      _animation = CurvedAnimation(
        parent: _controller!,
        curve: _effect.curve,
        reverseCurve: _effect.reverseCurve ?? _effect.curve,
      );
    }
  }

  @override
  void dispose() {
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  bool get _isHoldMode {
    return widget.onClick != null &&
        widget.onDoubleClick == null &&
        widget.onLongClick == null;
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onClick != null) {
      _controller?.forward();
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onClick != null) {
      _controller?.reverse();
      if (widget.haptic) {
        if (!kIsWeb && Platform.isAndroid) {
          HapticFeedback.lightImpact();
        } else {
          HapticFeedback.selectionClick();
        }
      }
    }
  }

  void _onTapCancel() {
    if (widget.onClick != null) {
      _controller?.forward();
    }
  }

  void _onClick() async {
    if (widget.onClick != null) widget.onClick!(context);
    if (_controller != null) {
      _controller!.reverse().whenComplete(_controller!.forward);
    }
  }

  void _onDClick() {
    if (widget.onDoubleClick != null) widget.onDoubleClick!(context);
    if (_controller != null) {
      _controller!.reverse().whenComplete(_controller!.forward);
    }
  }

  void _onLClick() {
    if (widget.onLongClick != null) widget.onLongClick!(context);
    if (_controller != null) {
      _controller!.reverse().whenComplete(_controller!.forward);
    }
  }

  void _onHover(bool value) async {
    if (widget.onHover != null) widget.onHover!(value);
  }

  bool get _inkwell {
    return widget.splashColor != null ||
        widget.highlightColor != null ||
        widget.onHover != null;
  }

  @override
  Widget build(BuildContext context) {
    if (_inkwell) {
      return InkWell(
        splashColor: widget.splashColor,
        hoverColor: widget.hoverColor,
        highlightColor: widget.highlightColor,
        onHover: widget.onHover != null ? _onHover : null,
        onTap: widget.onClick != null ? _onClick : null,
        onDoubleTap: widget.onDoubleClick != null ? _onDClick : null,
        onLongPress: widget.onLongClick != null ? _onLClick : null,
        onTapUp: _isHoldMode ? _onTapUp : null,
        onTapDown: _isHoldMode ? _onTapDown : null,
        onTapCancel: _isHoldMode ? _onTapCancel : null,
        child: _Effect(
          effect: _effect,
          value: _animation,
          child: widget.child,
        ),
      );
    } else {
      return GestureDetector(
        onTap: widget.onClick != null ? _onClick : null,
        onDoubleTap: widget.onDoubleClick != null ? _onDClick : null,
        onLongPress: widget.onLongClick != null ? _onLClick : null,
        onTapUp: _isHoldMode ? _onTapUp : null,
        onTapDown: _isHoldMode ? _onTapDown : null,
        onTapCancel: _isHoldMode ? _onTapCancel : null,
        child: _Effect(
          effect: _effect,
          value: _animation,
          child: widget.child,
        ),
      );
    }
  }
}

class _Effect extends StatelessWidget {
  final GestureClickEffect effect;
  final Animation<double>? value;
  final Widget child;

  const _Effect({
    required this.effect,
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;
    if (value != null) {
      if (effect._effect.isBounce) {
        child = ScaleTransition(scale: value!, child: child);
      } else if (effect._effect.isFade) {
        child = FadeTransition(opacity: value!, child: child);
      } else if (effect._effect.isBounceWithFade) {
        child = AnimatedBuilder(
          animation: value!,
          child: child,
          builder: (context, child) {
            final value = this.value!.value;
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
        );
      } else if (effect._effect.isCustom) {
        child = AnimatedBuilder(
          animation: value!,
          builder: (context, child) => effect.builder!(context, value!, child!),
          child: child,
        );
      }
    }
    return child;
  }
}

enum _Effects {
  none,
  bounce,
  bounceWithFade,
  fade,
  custom;

  bool get isNone => this == none;

  bool get isBounce => this == bounce;

  bool get isBounceWithFade => this == bounceWithFade;

  bool get isFade => this == fade;

  bool get isCustom => this == custom;
}

class GestureClickEffect {
  final AnimationBehavior behavior;
  final Curve curve;
  final Curve? reverseCurve;
  final Duration duration;
  final Duration? reverseDuration;
  final _Effects _effect;
  final double value;
  final double lowerBound;
  final double upperBound;
  final OnClickEffectBuilder? builder;

  const GestureClickEffect({
    this.builder,
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.9,
  }) : _effect = _Effects.none;

  const GestureClickEffect.bounce({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.95,
  })  : _effect = _Effects.bounce,
        builder = null;

  const GestureClickEffect.fade({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.8,
  })  : _effect = _Effects.fade,
        builder = null;

  const GestureClickEffect.bounceWithFade({
    this.behavior = AnimationBehavior.normal,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.value = 1.0,
    this.upperBound = 1.0,
    this.lowerBound = 0.9,
  })  : _effect = _Effects.bounceWithFade,
        builder = null;
}
