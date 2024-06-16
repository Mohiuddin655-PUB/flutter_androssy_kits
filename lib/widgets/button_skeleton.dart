import 'package:flutter/material.dart';

import 'icon.dart';
import 'text.dart';

class AndrossyButtonSkeleton extends StatelessWidget {
  final bool visibility;

  final dynamic icon;
  final IconAlignment iconAlignment;
  final Color? iconColor;
  final bool iconColorAsRoot;
  final bool iconFlexible;
  final bool iconOnly;
  final double? iconSize;
  final double? iconSpace;

  final String? text;
  final double? textSize;
  final FontWeight? textFontWeight;
  final TextStyle? textStyle;
  final bool textCenter;
  final bool textAllCaps;
  final Color? textColor;

  const AndrossyButtonSkeleton({
    super.key,
    this.visibility = true,
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.iconColor,
    this.iconColorAsRoot = false,
    this.iconFlexible = false,
    this.iconOnly = false,
    this.iconSize,
    this.iconSpace,
    this.text,
    this.textAllCaps = false,
    this.textCenter = false,
    this.textColor,
    this.textFontWeight,
    this.textSize,
    this.textStyle,
  });

  bool get _centerText => textCenter;

  bool get _isStartIconVisible {
    return iconAlignment == IconAlignment.start && icon != null;
  }

  bool get _isEndIconVisible {
    return iconAlignment == IconAlignment.end && icon != null;
  }

  bool get _isStartIconFlex => _isStartIconVisible && iconFlexible;

  bool get _isEndIconFlex => _isEndIconVisible && iconFlexible;

  double get _iconSpace => iconSpace ?? (iconOnly ? 0 : 16);

  Color? get _iconColor => iconColor ?? (iconColorAsRoot ? null : textColor);

  bool get _invisibility {
    return !visibility || (icon == null && (text ?? "").isEmpty);
  }

  bool get _iconOnly => iconOnly || (text ?? "").isEmpty;

  bool get _textOnly => icon == null;

  String? get _text => textAllCaps ? text?.toUpperCase() : text;

  @override
  Widget build(BuildContext context) {
    if (_invisibility) return const SizedBox.shrink();
    if (_iconOnly) {
      return AndrossyIcon(
        visibility: icon != null,
        icon: icon,
        color: _iconColor,
        size: iconSize,
      );
    } else if (_textOnly) {
      return AndrossyText(
        text: _text,
        textAlign: TextAlign.center,
        textColor: textColor,
        textSize: textSize,
        textFontWeight: textFontWeight,
        textStyle: textStyle,
      );
    } else if (_centerText) {
      return Stack(
        alignment: Alignment.center,
        children: [
          if (text != null)
            AndrossyText(
              text: _text,
              textAlign: TextAlign.center,
              textColor: textColor,
              textSize: textSize,
              textFontWeight: textFontWeight,
              textStyle: textStyle,
            ),
          if (icon != null)
            Positioned(
              left: _isEndIconVisible ? null : 0,
              right: _isEndIconVisible ? 0 : null,
              child: AndrossyIcon(
                icon: icon,
                color: _iconColor,
                size: iconSize,
              ),
            ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isStartIconVisible)
            AndrossyIcon(icon: icon, color: _iconColor, size: iconSize),
          if (_isStartIconFlex)
            const Spacer()
          else if (_isStartIconVisible)
            SizedBox(width: _iconSpace),
          if (text != null)
            AndrossyText(
              text: _text,
              textAlign: TextAlign.center,
              textColor: textColor,
              textSize: textSize,
              textFontWeight: textFontWeight,
              textStyle: textStyle,
            ),
          if (_isEndIconFlex)
            const Spacer()
          else if (_isEndIconVisible)
            SizedBox(width: _iconSpace),
          if (_isEndIconVisible)
            AndrossyIcon(icon: icon, color: _iconColor, size: iconSize),
        ],
      );
    }
  }
}
