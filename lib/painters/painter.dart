import 'dart:ui';

import 'package:flutter/material.dart';

enum StrokeAlign { inside, outside, center }

/// USE LIKE
///
/// * [AndrossyDockConfig]
/// * [AndrossyStarConfig]
abstract class AndrossyPainterConfig {
  final BlendMode? blendMode;
  final BorderRadius? borderRadius;
  final Color? color;
  final ColorFilter? colorFilter;
  final FilterQuality? filterQuality;
  final Gradient? gradient;
  final ImageFilter? imageFilter;
  final bool? invertColors;
  final bool? isAntiAlias;
  final MaskFilter? maskFilter;
  final StrokeAlign strokeAlign;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final double? strokeMiterLimit;
  final List<double> strokePoints;
  final double strokeWidth;
  final PaintingStyle style;

  const AndrossyPainterConfig({
    this.blendMode,
    this.borderRadius,
    this.color,
    this.colorFilter,
    this.filterQuality,
    this.gradient,
    this.imageFilter,
    this.invertColors,
    this.isAntiAlias,
    this.maskFilter,
    this.strokeAlign = StrokeAlign.inside,
    this.strokeCap,
    this.strokeJoin,
    this.strokeMiterLimit,
    this.strokePoints = const [],
    this.strokeWidth = 1,
    this.style = PaintingStyle.fill,
  });

  double get strokeInset {
    double inset = 0.0;
    double width = strokeWidth;
    if (style == PaintingStyle.stroke && width > 0) {
      if (strokeAlign == StrokeAlign.inside) {
        inset = width / 2;
      } else if (strokeAlign == StrokeAlign.outside) {
        inset = -width / 2;
      }
    }
    return inset;
  }

  BorderRadius? getAdjustmentRadius(Size size) {
    final x = size.width;
    final y = size.height;
    final isSquire = x == y;
    if (isSquire && borderRadius != null && strokeAlign != StrokeAlign.center) {
      final i = strokeWidth / 2;
      final xi = x / 2;
      final yi = y / 2;

      final b = borderRadius!;
      final tl = b.topLeft;
      final tr = b.topRight;
      final br = b.bottomRight;
      final bl = b.bottomLeft;

      final radius = BorderRadius.only(
        topLeft: Radius.elliptical(
          tl.x >= xi ? i : 0,
          tl.y >= yi ? i : 0,
        ),
        topRight: Radius.elliptical(
          tr.x >= xi ? i : 0,
          tr.y >= yi ? i : 0,
        ),
        bottomLeft: Radius.elliptical(
          bl.x >= xi ? i : 0,
          bl.y >= yi ? i : 0,
        ),
        bottomRight: Radius.elliptical(
          br.x >= xi ? i : 0,
          br.y >= yi ? i : 0,
        ),
      );
      if (strokeAlign == StrokeAlign.inside) {
        return borderRadius! - radius;
      } else {
        return borderRadius! + radius;
      }
    } else {
      return borderRadius;
    }
  }

  Paint build(Size size) {
    final strokeWidth = this.strokeWidth;

    final fill = style == PaintingStyle.fill;

    Paint paint = Paint()..style = style;

    if (blendMode != null) paint.blendMode = blendMode!;
    if (color != null) paint.color = color!;
    if (colorFilter != null) paint.colorFilter = colorFilter;
    if (filterQuality != null) paint.filterQuality = filterQuality!;
    if (gradient != null) {
      paint.shader = gradient!.createShader(Offset.zero & size);
    }
    if (imageFilter != null) paint.imageFilter = imageFilter;
    if (invertColors != null) paint.invertColors = invertColors!;
    if (isAntiAlias != null) paint.isAntiAlias = isAntiAlias!;
    if (maskFilter != null) paint.maskFilter = maskFilter;
    if (strokeCap != null) paint.strokeCap = strokeCap!;
    if (strokeJoin != null) paint.strokeJoin = strokeJoin!;
    if (strokeMiterLimit != null) paint.strokeMiterLimit = strokeMiterLimit!;
    if (strokeWidth > 0 && !fill) paint.strokeWidth = strokeWidth;
    return paint;
  }

  Path dash(Path root) {
    final dash = strokePoints;
    final metrics = root.computeMetrics(forceClosed: false);
    Path path = Path();

    for (PathMetric me in metrics) {
      double totalLength = me.length;
      int index = -1;

      for (double start = 0; start < totalLength;) {
        double to = start + dash[(++index) % dash.length];
        to = to > totalLength ? totalLength : to;
        bool isEven = index % 2 == 0;
        if (isEven) {
          path.addPath(
            me.extractPath(start, to, startWithMoveTo: true),
            Offset.zero,
          );
        }
        start = to;
      }
    }
    return path;
  }
}

enum AndrossyClip { dock, star }
