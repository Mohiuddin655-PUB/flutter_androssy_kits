import 'package:flutter/material.dart';

import 'button_skeleton.dart';
import 'gesture.dart';

export 'gesture.dart';

class AndrossyButtonProperty<T> {
  final T? activated;
  final T? disabled;
  final T? enabled;
  final T? loading;

  const AndrossyButtonProperty({
    this.activated,
    this.disabled,
    this.enabled,
    this.loading,
  });

  const AndrossyButtonProperty.all(T value)
      : this(activated: value, disabled: value, enabled: value, loading: value);

  T? from(AndrossyButtonPropertyState state) {
    switch (state) {
      case AndrossyButtonPropertyState.activated:
        return activated;
      case AndrossyButtonPropertyState.disabled:
        return disabled;
      case AndrossyButtonPropertyState.enabled:
        return enabled;
      case AndrossyButtonPropertyState.loading:
        return loading;
    }
  }
}

enum AndrossyButtonPropertyState {
  activated,
  disabled,
  enabled,
  loading;

  factory AndrossyButtonPropertyState.from(AndrossyButtonState state) {
    if (state.enabled) {
      if (state.activated) return activated;
      if (state.loading) return loading;
      return enabled;
    }
    return disabled;
  }
}

enum AndrossyBorderStyle { dotted, solid }

class AndrossyButton extends StatefulWidget {
  final double elevation;
  final Color? elevationColor;
  final bool enableFeedback;
  final Color? highlightColor;
  final Color? hoverColor;
  final MouseCursor? mouseCursor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final WidgetStateProperty<Color?>? overlayColor;
  final AndrossyGestureEffect clickEffect;

  final bool activated;
  final bool enabled;
  final bool loading;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsets padding;
  final Color? primary;

  final dynamic icon;
  final IconAlignment iconOrIndicatorAlignment;
  final bool autoIconOrIndicatorColorAdjustment;
  final bool iconOrIndicatorFlexible;
  final bool iconOnly;
  final double? iconOrIndicatorSpace;
  final double iconSize;
  final Widget? indicator;
  final double? indicatorSize;
  final double? indicatorStrokeWidth;
  final String? text;
  final AndrossyButtonProperty<String>? texts;
  final bool textAllCaps;
  final AndrossyButtonProperty<Color> textColor;
  final double? textSize;
  final TextStyle? textStyle;
  final bool centerText;

  final AndrossyButtonProperty<dynamic>? icons;
  final AndrossyButtonProperty<Color>? iconColor;
  final AndrossyButtonProperty<Color>? indicatorColor;
  final AndrossyButtonProperty<Color> backgroundColor;

  final bool borderOnly;
  final AndrossyButtonProperty<Color> borderColor;
  final BorderRadius? borderRadius;
  final double borderStrokeAlign;
  final double borderWidth;

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onToggle;

  const AndrossyButton({
    super.key,
    this.activated = false,
    this.enabled = true,
    this.loading = false,
    this.icon,
    this.icons,
    this.iconOrIndicatorAlignment = IconAlignment.end,
    this.iconColor,
    this.indicatorColor,
    this.autoIconOrIndicatorColorAdjustment = true,
    this.iconOrIndicatorFlexible = false,
    this.iconOnly = false,
    this.iconSize = 24,
    this.iconOrIndicatorSpace,
    this.indicator,
    this.indicatorSize,
    this.indicatorStrokeWidth,
    this.text,
    this.texts,
    this.centerText = false,
    this.textColor = const AndrossyButtonProperty(),
    this.textAllCaps = false,
    this.textSize,
    this.textStyle,
    this.backgroundColor = const AndrossyButtonProperty(),
    this.width,
    this.height,
    this.constraints,
    this.padding = const EdgeInsets.all(8),
    this.borderColor = const AndrossyButtonProperty(),
    this.borderWidth = 1.5,
    this.borderStrokeAlign = BorderSide.strokeAlignInside,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.onTap,
    this.onToggle,
    this.primary,
    this.borderOnly = false,
    this.borderRadius,
    this.elevation = 0,
    this.elevationColor,
    this.enableFeedback = true,
    this.highlightColor,
    this.hoverColor,
    this.mouseCursor,
    this.splashColor,
    this.splashFactory,
    this.overlayColor,
    this.clickEffect = const AndrossyGestureEffect(),
  });

  @override
  State<AndrossyButton> createState() => AndrossyButtonState();
}

class AndrossyButtonState extends State<AndrossyButton> {
  late bool _activated = widget.activated;

  bool get activated => _activated;

  late bool _enabled = widget.enabled;

  bool get enabled => _enabled;

  late bool _loading = widget.loading;

  bool get loading => _loading && enabled;

  bool get _clickable => enabled && !_loading;

  void setActivated(bool value) => setState(() => _activated = value);

  void setEnabled(bool value) => setState(() => _enabled = value);

  void setLoading(bool value) => setState(() => _loading = value);

  void showLoader() => setLoading(true);

  void hideLoader() => setLoading(false);

  @override
  void didUpdateWidget(covariant AndrossyButton oldWidget) {
    _activated = widget.activated;
    _enabled = widget.enabled;
    _loading = widget.loading;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final state = AndrossyButtonPropertyState.from(this);

    final text = widget.texts?.from(state) ?? widget.text ?? "";

    final primaryColor = widget.primary ?? Theme.of(context).primaryColor;
    final isClickMode = widget.onTap != null ||
        widget.onToggle != null ||
        widget.onDoubleTap != null ||
        widget.onLongPress != null ||
        widget.onHover != null;

    final borderColor = widget.borderColor.from(state);

    final foregroundColor = (enabled && isClickMode) || _loading
        ? activated
            ? widget.borderOnly
                ? borderColor ?? primaryColor
                : primaryColor
            : widget.borderOnly
                ? borderColor ?? primaryColor
                : Colors.white
        : Colors.grey.withOpacity(0.75);

    return AndrossyGesture(
      backgroundColor: !widget.borderOnly
          ? widget.backgroundColor.from(state) ??
              ((enabled && isClickMode) || _loading
                  ? activated
                      ? primaryColor.withOpacity(0.1)
                      : primaryColor
                  : Colors.grey.withOpacity(0.1))
          : null,
      clickEffect: widget.clickEffect,
      clipBehavior: Clip.antiAlias,
      enabled: widget.enabled,
      enableFeedback: widget.enableFeedback,
      elevation: widget.elevation,
      elevationColor: widget.elevationColor,
      highlightColor: widget.highlightColor,
      hoverColor: widget.hoverColor,
      overlayColor: widget.overlayColor,
      mouseCursor: widget.mouseCursor,
      splashColor: widget.splashColor,
      splashFactory: widget.splashFactory,
      materialType: widget.borderOnly ? MaterialType.transparency : null,
      shape: RoundedRectangleBorder(
        side: borderColor != null || widget.borderOnly
            ? BorderSide(
                color: borderColor ?? foregroundColor,
                width: widget.borderWidth,
              )
            : BorderSide.none,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
      ),
      onTap: _clickable && (widget.onTap != null || widget.onToggle != null)
          ? _onTap
          : null,
      onDoubleTap: _clickable ? widget.onDoubleTap : null,
      onLongPress: _clickable ? widget.onLongPress : null,
      onHover: _clickable ? widget.onHover : null,
      child: AndrossyButtonSkeleton(
        width: widget.width,
        height: widget.height,
        constraints: widget.constraints,
        padding: widget.padding,
        icon: widget.icons?.from(state) ?? widget.icon,
        iconAlignment: widget.iconOrIndicatorAlignment,
        iconColor: widget.iconColor?.from(state) ?? foregroundColor,
        iconColorAsRoot: widget.autoIconOrIndicatorColorAdjustment,
        iconFlexible: widget.iconOrIndicatorFlexible,
        iconOnly: widget.iconOnly,
        iconSize: widget.iconSize,
        iconSpace: widget.iconOrIndicatorSpace,
        text: text,
        textStyle: widget.textStyle,
        textColor: widget.textColor.from(state) ?? foregroundColor,
        textSize: widget.textSize,
        textAllCaps: widget.textAllCaps,
        textCenter: widget.centerText,
        indicator: widget.indicator,
        indicatorColor: widget.indicatorColor?.from(state) ?? foregroundColor,
        indicatorSize: widget.indicatorSize,
        indicatorStrokeWidth: widget.indicatorStrokeWidth,
        indicatorVisible: _loading,
      ),
    );
  }

  void _onTap() {
    if (widget.onToggle != null) {
      setState(() {
        _activated = !activated;
        widget.onToggle!(activated);
      });
    } else if (widget.onTap != null) {
      widget.onTap!();
    }
  }
}
