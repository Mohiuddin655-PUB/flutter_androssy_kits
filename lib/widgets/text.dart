import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef OnAndrossyTextClickListener = void Function(BuildContext context);

class AndrossyText extends StatelessWidget {
  final bool visibility;

  /// BASE
  final String? ellipsis;
  final int? maxLines;

  final double? letterSpacing;
  final double? lineHeight;
  final Locale? locale;
  final double? wordSpacing;

  final String? textFontFamily;
  final FontStyle? textFontStyle;
  final FontWeight? textFontWeight;
  final Color? selectionColor;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;

  final String? text;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextDecoration? textDecoration;
  final Color? textDecorationColor;
  final TextDecorationStyle? textDecorationStyle;
  final double? textDecorationThickness;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final TextLeadingDistribution? textLeadingDistribution;
  final TextOverflow? textOverflow;
  final TextScaler? textScaler;
  final double? textSize;
  final List<TextSpan> textSpans;
  final TextStyle? textStyle;
  final TextWidthBasis textWidthBasis;
  final OnAndrossyTextClickListener? onClick;

  ///PREFIX
  final FontStyle? prefixFontStyle;
  final FontWeight? prefixFontWeight;
  final String? prefixText;
  final Color? prefixTextColor;
  final TextDecoration? prefixTextDecoration;
  final Color? prefixTextDecorationColor;
  final TextDecorationStyle? prefixTextDecorationStyle;
  final double? prefixTextDecorationThickness;
  final double? prefixTextLetterSpace;
  final double? prefixTextSize;
  final TextStyle? prefixTextStyle;
  final bool prefixTextVisible;
  final OnAndrossyTextClickListener? onPrefixClick;

  ///SUFFIX
  final FontStyle? suffixFontStyle;
  final FontWeight? suffixFontWeight;
  final String? suffixText;
  final Color? suffixTextColor;
  final TextDecoration? suffixTextDecoration;
  final Color? suffixTextDecorationColor;
  final TextDecorationStyle? suffixTextDecorationStyle;
  final double? suffixTextDecorationThickness;
  final double? suffixTextLetterSpace;
  final double? suffixTextSize;
  final TextStyle? suffixTextStyle;
  final bool suffixTextVisible;
  final OnAndrossyTextClickListener? onSuffixClick;

  const AndrossyText({
    super.key,
    this.visibility = true,
    this.ellipsis,
    this.textFontFamily,
    this.textFontStyle,
    this.textFontWeight,
    this.letterSpacing,
    this.lineHeight,
    this.locale,
    this.maxLines,
    this.selectionColor,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.text,
    this.textAlign,
    this.textColor,
    this.textDecoration,
    this.textDecorationColor,
    this.textDecorationStyle,
    this.textDecorationThickness,
    this.textDirection,
    this.textHeightBehavior,
    this.textLeadingDistribution,
    this.textOverflow,
    this.textScaler,
    this.textSize,
    this.textSpans = const [],
    this.textStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.wordSpacing,
    this.onClick,

    ///PREFIX
    this.prefixFontStyle,
    this.prefixFontWeight,
    this.prefixText,
    this.prefixTextColor,
    this.prefixTextDecoration,
    this.prefixTextDecorationColor,
    this.prefixTextDecorationStyle,
    this.prefixTextDecorationThickness,
    this.prefixTextLetterSpace,
    this.prefixTextSize,
    this.prefixTextStyle,
    this.prefixTextVisible = true,
    this.onPrefixClick,

    ///SUFFIX
    this.suffixFontStyle,
    this.suffixFontWeight,
    this.suffixText,
    this.suffixTextColor,
    this.suffixTextDecoration,
    this.suffixTextDecorationColor,
    this.suffixTextDecorationStyle,
    this.suffixTextDecorationThickness,
    this.suffixTextLetterSpace,
    this.suffixTextSize,
    this.suffixTextStyle,
    this.suffixTextVisible = true,
    this.onSuffixClick,
  });

  GestureRecognizer? _(
      BuildContext context, OnAndrossyTextClickListener callback) {
    return TapGestureRecognizer()..onTap = () => callback(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();

    final theme = Theme.of(context).textTheme.bodyMedium;
    final isEllipsis = ellipsis != null;
    final isPrefix = (prefixText ?? "").isNotEmpty && prefixTextVisible;
    final isSuffix = (suffixText ?? "").isNotEmpty && suffixTextVisible;
    final isSpannable = isPrefix || isSuffix || textSpans.isNotEmpty;

    final style = (textStyle ?? theme ?? const TextStyle()).copyWith(
      color: textColor,
      fontSize: textSize,
      fontWeight: textFontWeight,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness,
      fontFamily: textFontFamily,
      fontStyle: textFontStyle,
      height: lineHeight,
      leadingDistribution: textLeadingDistribution,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );

    final mPC = onPrefixClick ?? onClick;
    final mSC = onSuffixClick ?? onClick;

    var span = isSpannable
        ? TextSpan(
            style: isEllipsis ? style : null,
            semanticsLabel: semanticsLabel,
            children: [
              if (isPrefix)
                TextSpan(
                  text: prefixText,
                  recognizer: mPC != null ? _(context, mPC) : null,
                  style: (prefixTextStyle ?? style).copyWith(
                    color: prefixTextColor,
                    fontSize: prefixTextSize,
                    fontStyle: prefixFontStyle,
                    letterSpacing: prefixTextLetterSpace,
                    fontWeight: prefixFontWeight,
                    decoration: prefixTextDecoration,
                    decorationColor: prefixTextDecorationColor,
                    decorationStyle: prefixTextDecorationStyle,
                    decorationThickness: prefixTextDecorationThickness,
                  ),
                ),
              TextSpan(
                text: text,
                recognizer: onClick != null ? _(context, onClick!) : null,
              ),
              ...textSpans,
              if (isSuffix)
                TextSpan(
                  text: suffixText,
                  recognizer: mSC != null ? _(context, mSC) : null,
                  style: (suffixTextStyle ?? style).copyWith(
                    color: suffixTextColor,
                    fontSize: suffixTextSize,
                    fontStyle: suffixFontStyle,
                    letterSpacing: suffixTextLetterSpace,
                    fontWeight: suffixFontWeight,
                    decoration: suffixTextDecoration,
                    decorationColor: suffixTextDecorationColor,
                    decorationStyle: suffixTextDecorationStyle,
                    decorationThickness: suffixTextDecorationThickness,
                  ),
                ),
            ],
          )
        : null;

    if (isEllipsis) {
      return LayoutBuilder(
        builder: (context, constraints) {
          var painter = TextPainter(
            text: span ??
                TextSpan(
                  text: text,
                  style: style,
                  locale: locale,
                  semanticsLabel: semanticsLabel,
                  recognizer: onClick != null ? _(context, onClick!) : null,
                ),
            textAlign: textAlign ?? TextAlign.start,
            textDirection: textDirection ?? TextDirection.ltr,
            textScaler: textScaler ?? TextScaler.noScaling,
            maxLines: maxLines,
            ellipsis: ellipsis ?? "...",
            locale: locale,
            strutStyle: strutStyle,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
          );
          painter.layout(maxWidth: constraints.maxWidth);
          return CustomPaint(
            size: painter.size,
            painter: _EllipsisPainter(painter),
          );
        },
      );
    } else if (span != null) {
      return Text.rich(
        span,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: textOverflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    } else {
      return Text(
        text ?? "",
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: textOverflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }
  }
}

class _EllipsisPainter extends CustomPainter {
  final TextPainter painter;

  const _EllipsisPainter(this.painter);

  @override
  void paint(Canvas canvas, Size size) {
    painter.layout(maxWidth: size.width);
    painter.paint(canvas, const Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
