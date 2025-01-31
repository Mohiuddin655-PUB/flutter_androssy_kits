import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core/androssy.dart';

class AndrossyText extends StatelessWidget {
  final String? ellipsis;
  final int? maxLines;

  final Locale? locale;

  final Color? selectionColor;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;

  final String? data;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final List<InlineSpan> spans;
  final TextStyle? style;
  final TextWidthBasis textWidthBasis;
  final ValueChanged<BuildContext>? onClick;

  final String? prefix;
  final TextStyle? prefixStyle;
  final ValueChanged<BuildContext>? onPrefixClick;

  final String? suffix;
  final TextStyle? suffixStyle;
  final ValueChanged<BuildContext>? onSuffixClick;

  final bool translate;

  const AndrossyText(
    this.data, {
    super.key,
    this.ellipsis,
    this.locale,
    this.maxLines,
    this.selectionColor,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.overflow,
    this.textScaler,
    this.spans = const [],
    this.style,
    this.textWidthBasis = TextWidthBasis.parent,
    this.onClick,
    this.prefix,
    this.prefixStyle,
    this.onPrefixClick,
    this.suffix,
    this.suffixStyle,
    this.onSuffixClick,
    this.translate = false,
  });

  GestureRecognizer? _(
    BuildContext context,
    ValueChanged<BuildContext> callback,
  ) {
    return TapGestureRecognizer()..onTap = () => callback(context);
  }

  String? _text(BuildContext context, String? raw) {
    if (!translate) return raw;
    if (raw == null || raw.isEmpty) return null;
    final converter = Androssy.iOrNull?.textConverter;
    if (converter == null) return null;
    return converter(context, raw);
  }

  Iterable<InlineSpan> _spans(
    BuildContext context,
    Iterable<InlineSpan> children,
  ) {
    if (!translate) return children;
    return children.map((e) {
      if (e is! TextSpan) return e;
      return TextSpan(
        text: _text(context, e.text),
        children: _spans(context, e.children ?? []).toList(),
        locale: e.locale,
        mouseCursor: e.mouseCursor,
        onEnter: e.onEnter,
        onExit: e.onExit,
        recognizer: e.recognizer,
        style: e.style,
        semanticsLabel: e.semanticsLabel,
        spellOut: e.spellOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = _text(context, this.data);
    final prefix = _text(context, this.prefix);
    final suffix = _text(context, this.suffix);
    final ellipsis = _text(context, this.ellipsis);

    if ((data == null || data.isEmpty) && spans.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context).textTheme.bodyMedium;
    final isEllipsis = ellipsis != null;
    final isPrefix = (prefix ?? "").isNotEmpty;
    final isSuffix = (suffix ?? "").isNotEmpty;
    final isSpannable = isPrefix || isSuffix || spans.isNotEmpty;

    final mStyle = style ?? theme;

    final mPC = onPrefixClick ?? onClick;
    final mSC = onSuffixClick ?? onClick;

    final span = isSpannable
        ? TextSpan(
            style: isEllipsis ? mStyle : null,
            semanticsLabel: semanticsLabel,
            children: [
              if (isPrefix)
                TextSpan(
                  text: prefix,
                  recognizer: mPC != null ? _(context, mPC) : null,
                  style: prefixStyle ?? mStyle,
                ),
              if (data != null || data!.isNotEmpty)
                TextSpan(
                  text: data,
                  recognizer: onClick != null ? _(context, onClick!) : null,
                ),
              ..._spans(context, spans),
              if (isSuffix)
                TextSpan(
                  text: suffix,
                  recognizer: mSC != null ? _(context, mSC) : null,
                  style: suffixStyle ?? mStyle,
                ),
            ],
          )
        : null;

    if (isEllipsis) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final painter = TextPainter(
            text: span ??
                TextSpan(
                  text: data,
                  style: mStyle,
                  locale: locale,
                  semanticsLabel: semanticsLabel,
                  recognizer: onClick != null ? _(context, onClick!) : null,
                ),
            textAlign: textAlign ?? TextAlign.start,
            textDirection: textDirection ?? TextDirection.ltr,
            textScaler: textScaler ?? TextScaler.noScaling,
            maxLines: maxLines,
            ellipsis: ellipsis,
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
    }

    if (span != null) {
      return Text.rich(
        span,
        style: mStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }

    return Text(
      data ?? "",
      style: mStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
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
