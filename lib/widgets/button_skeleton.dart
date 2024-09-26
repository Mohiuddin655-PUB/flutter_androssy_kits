import 'package:flutter/material.dart';

import 'icon.dart';

class AndrossyButtonSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final EdgeInsets? padding;

  final dynamic icon;
  final IconAlignment iconAlignment;
  final Color? iconColor;
  final bool iconColorAsRoot;
  final bool iconFlexible;
  final bool iconOnly;
  final double iconSize;
  final double? iconSpace;
  final Widget? indicator;
  final Color? indicatorColor;
  final double? indicatorSize;
  final double? indicatorStrokeWidth;
  final bool indicatorVisible;

  final String? text;
  final double? textSize;
  final TextStyle? textStyle;
  final bool textCenter;
  final bool textAllCaps;
  final Color? textColor;

  const AndrossyButtonSkeleton({
    super.key,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.iconColor,
    this.iconColorAsRoot = false,
    this.iconFlexible = false,
    this.iconOnly = false,
    this.iconSize = 24,
    this.iconSpace,
    this.indicator,
    this.indicatorColor,
    this.indicatorSize,
    this.indicatorStrokeWidth,
    this.indicatorVisible = false,
    this.text,
    this.textAllCaps = false,
    this.textCenter = false,
    this.textColor,
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

  bool get _invisibility => icon == null && (text ?? "").isEmpty;

  bool get _iconOnly => iconOnly || (text ?? "").isEmpty;

  bool get _textOnly => icon == null;

  String? get _text => textAllCaps ? text?.toUpperCase() : text;

  Alignment? get alignment {
    Alignment? value;
    if (height != null && height! > 0 && width != null && width! > 0) {
      value = Alignment.center;
    }
    return value;
  }

  Widget _textWidget() {
    return Text(
      _text!,
      textAlign: TextAlign.center,
      style: (textStyle ?? const TextStyle()).copyWith(
        color: textStyle?.color ?? textColor,
        fontSize: textStyle?.fontSize ?? textSize ?? 16,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
      ),
    );
  }

  Widget _indicator() {
    if (indicator != null) return indicator!;
    final size =
        indicatorSize ?? (height != null ? height! * 0.6 : null) ?? iconSize;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(
          color: indicatorColor ?? _iconColor,
          strokeWidth: indicatorStrokeWidth ?? (size * 0.1),
          strokeAlign: CircularProgressIndicator.strokeAlignInside,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }

  Widget _iconWidget() {
    if (indicatorVisible) return _indicator();
    return AndrossyIcon(
      icon: icon,
      color: _iconColor,
      size: iconSize,
    );
  }

  Widget _child() {
    if (_invisibility) return const SizedBox.shrink();
    if (_iconOnly) {
      return indicatorVisible ? _indicator() : _iconWidget();
    } else if (_textOnly) {
      return indicatorVisible ? _indicator() : _textWidget();
    } else if (_centerText) {
      return Stack(
        alignment: Alignment.center,
        children: [
          if (text != null && text!.isNotEmpty) _textWidget(),
          if (icon != null)
            Positioned(
              left: _isEndIconVisible ? null : 0,
              right: _isEndIconVisible ? 0 : null,
              child: _iconWidget(),
            ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isStartIconVisible) _iconWidget(),
          if (_isStartIconFlex)
            const Spacer()
          else if (_isStartIconVisible)
            SizedBox(width: _iconSpace),
          if (text != null) _textWidget(),
          if (_isEndIconFlex)
            const Spacer()
          else if (_isEndIconVisible)
            SizedBox(width: _iconSpace),
          if (_isEndIconVisible) _iconWidget(),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _child();
    final isValidHeight = height != null && height! > 0;
    final isValidWidth = width != null && width! > 0;
    if (isValidHeight && !isValidWidth) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [child],
      );
    }
    if (isValidWidth && !isValidHeight) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [child],
      );
    }
    if (isValidWidth && isValidHeight) {
      child = Align(
        alignment: Alignment.center,
        child: child,
      );
    }
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      child: child,
    );
  }
}
