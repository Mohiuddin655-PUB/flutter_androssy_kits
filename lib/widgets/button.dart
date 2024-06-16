import 'dart:math';

import 'package:flutter/material.dart';

import 'button_skeleton.dart';
import 'view.dart';

class AndrossyButton extends AndrossyView {
  // ICON
  final dynamic icon;
  final IconAlignment iconAlignment;
  final Color? iconColor;
  final bool iconColorAsRoot;
  final bool iconFlexible;
  final bool iconOnly;
  final double? iconSize;
  final double? iconSpace;

  // TEXT
  final String? text;
  final double? textSize;
  final FontWeight? textFontWeight;
  final TextStyle? textStyle;
  final bool textCenter;
  final bool textAllCaps;
  final Color? textColor;

  final bool activated;

  const AndrossyButton({
    super.key,
    // ANIMATION
    super.animation,
    super.animationCurve,
    // BACKDROP
    super.backdropFilter,
    super.backdropMode,
    // DECORATION
    super.color,
    super.decoration,
    super.decorationShape,
    super.foregroundDecoration,
    super.foregroundDecorationShape,
    // CLIPPER
    super.clipper,
    super.clipConfig,
    super.clipBehavior,
    // DIMENSION
    super.aspectRatio,
    super.flex,
    // OPACITY AND VISIBILITY
    super.opacity,
    super.opacityAlwaysIncludeSemantics,
    super.visibility,
    // PAINTER
    super.painter,
    super.painterConfig,
    // POINTER
    super.absorbPointer,
    super.ignorePointer,
    // POSITION
    super.alignment,
    super.position,
    super.positionType,
    // RENDER
    super.onRenderedSize,
    // SHADER
    super.shaderBlendMode,
    super.shaderCallback,
    super.shaderGradient,
    // SHADOW
    super.shadows,
    // SIZE
    super.constraints,
    super.height,
    super.width,
    // SPACER
    super.margin,
    super.padding,
    // TRANSFORM
    super.transform,
    super.transformAlignment,
    // GESTURE
    super.elevation,
    super.enabled,
    super.haptic,
    super.highlightColor,
    super.hoverColor,
    super.splashColor,
    super.clickEffect,
    super.onClick,
    super.onDoubleClick,
    super.onLongClick,
    super.onHover,

    // ICON
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.iconColor,
    this.iconColorAsRoot = false,
    this.iconFlexible = false,
    this.iconOnly = false,
    this.iconSize,
    this.iconSpace,
    // TEXT
    this.text,
    this.textAllCaps = true,
    this.textCenter = false,
    this.textColor,
    this.textFontWeight,
    this.textSize,
    this.textStyle,
    // BASE
    this.activated = false,
  });

  bool get _iconOnly => iconOnly && icon != null;

  bool get _textOnly => !_iconOnly && text != null && text!.isNotEmpty;

  @override
  ViewTheme defaultTheme(BuildContext context) {
    final theme = ButtonTheme.of(context);
    final scheme = theme.colorScheme;
    final io = _iconOnly;
    final p = theme.padding;
    final x = min(p.horizontal, p.vertical);
    print(x);
    return ViewTheme(
      decoration: BoxDecoration(
        color: enabled
            ? activated
                ? scheme?.secondary
                : scheme?.primary
            : scheme?.tertiary,
        borderRadius: io ? null : BorderRadius.circular(x * 2),
        shape: io ? BoxShape.circle : BoxShape.rectangle,
      ),
      constraints: io ? null : BoxConstraints(minWidth: theme.minWidth),
      padding: io
          ? EdgeInsets.all(x / 2)
          : _textOnly
              ? EdgeInsets.symmetric(
                  horizontal: p.horizontal / 2,
                  vertical: p.vertical / 2,
                )
              : theme.padding,
      alignment: height != null && height! > 0 ? Alignment.center : null,
    );
  }

  @override
  Widget attach(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();
    final theme = ButtonTheme.of(context);
    final scheme = theme.colorScheme;

    final fg = enabled
        ? activated
            ? scheme?.onSecondary
            : scheme?.onPrimary
        : scheme?.onTertiary;

    return AndrossyButtonSkeleton(
      icon: icon,
      iconAlignment: iconAlignment,
      iconFlexible: iconFlexible,
      iconOnly: _iconOnly,
      iconColor: iconColor,
      iconColorAsRoot: iconColorAsRoot,
      iconSize: iconSize,
      iconSpace: iconSpace,
      text: _iconOnly ? null : text,
      textAllCaps: textAllCaps,
      textCenter: textCenter,
      textColor: textColor ?? fg,
      textFontWeight: textFontWeight ?? FontWeight.w600,
      textSize: textSize ?? 16,
      textStyle: textStyle,
    );
  }
}
