import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'painter.dart';

Path _path(AndrossyStarConfig config, Size size) {
  double ixi = config.strokeInset;
  final inset = config.strokeAlign == StrokeAlign.center ? 0 : ixi * 6;
  int points = config.points;
  double outerRadius = min(size.width - inset, size.height - inset) / 2;
  double innerRadius = outerRadius * config._radius;

  double centerX = size.width / 2;
  double centerY = size.height / 2;

  Path path = Path();

  double angle = 2 * pi / points;

  for (int i = 0; i <= points; i++) {
    double x = centerX + outerRadius * cos(i * angle - pi / 2);
    double y = centerY + outerRadius * sin(i * angle - pi / 2);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
    x = centerX + innerRadius * cos((i + 0.5) * angle - pi / 2);
    y = centerY + innerRadius * sin((i + 0.5) * angle - pi / 2);
    path.lineTo(x, y);
  }
  path.close();
  return path;
}

class AndrossyStarConfig extends AndrossyPainterConfig {
  final double? inset;
  final bool inverse;
  final int points;
  final double? radius;

  double get _radius {
    final x = inverse ? -1 : 1;
    if (radius != null) return radius! * x;
    final itemCount = points;
    const int maxItemCount = 30;
    double value;
    if (itemCount < 5) {
      value = 0.5;
    } else if (itemCount >= maxItemCount) {
      value = 0.9;
    } else {
      value = 0.5 + (itemCount - 5) * (0.9 - 0.5) / (maxItemCount - 5);
    }
    return value * x;
  }

  const AndrossyStarConfig({
    // PARENT
    super.blendMode,
    super.borderRadius,
    super.color,
    super.colorFilter,
    super.filterQuality,
    super.gradient,
    super.imageFilter,
    super.invertColors,
    super.isAntiAlias,
    super.maskFilter,
    super.strokeAlign,
    super.strokeCap,
    super.strokeJoin,
    super.strokeMiterLimit,
    super.strokePoints,
    super.strokeWidth,
    super.style,
    // CHILD
    this.points = 5,
    this.inset,
    this.inverse = false,
    this.radius,
  });

  AndrossyStarConfig copyWith({
    // PARENT
    BlendMode? blendMode,
    BorderRadius? borderRadius,
    Color? color,
    ColorFilter? colorFilter,
    FilterQuality? filterQuality,
    Gradient? gradient,
    ImageFilter? imageFilter,
    bool? invertColors,
    bool? isAntiAlias,
    MaskFilter? maskFilter,
    StrokeAlign? strokeAlign,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    double? strokeMiterLimit,
    List<double>? strokePoints,
    double? strokeWidth,
    PaintingStyle? style,
    // CHILD
    int? points,
  }) {
    return AndrossyStarConfig(
      // PARENT
      blendMode: blendMode ?? this.blendMode,
      borderRadius: borderRadius ?? this.borderRadius,
      color: color ?? this.color,
      colorFilter: colorFilter ?? this.colorFilter,
      filterQuality: filterQuality ?? this.filterQuality,
      gradient: gradient ?? this.gradient,
      imageFilter: imageFilter ?? this.imageFilter,
      invertColors: invertColors ?? this.invertColors,
      isAntiAlias: isAntiAlias ?? this.isAntiAlias,
      maskFilter: maskFilter ?? this.maskFilter,
      strokeAlign: strokeAlign ?? this.strokeAlign,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      strokeMiterLimit: strokeMiterLimit ?? this.strokeMiterLimit,
      strokePoints: strokePoints ?? this.strokePoints,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      style: style ?? this.style,
      // CHILD
      points: points ?? this.points,
    );
  }
}

class AndrossyStarPainter extends CustomPainter {
  final AndrossyStarConfig config;

  const AndrossyStarPainter({
    this.config = const AndrossyStarConfig(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _path(config, size);
    final painter = config.build(size);
    if (config.style == PaintingStyle.stroke &&
        config.strokePoints.isNotEmpty) {
      final dash = config.dash(path);
      canvas.drawPath(dash, painter);
    } else {
      canvas.drawPath(path, painter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class AndrossyStarClipper extends CustomClipper<Path> {
  final AndrossyStarConfig config;

  const AndrossyStarClipper({
    super.reclip,
    required this.config,
  });

  @override
  Path getClip(Size size) {
    return _path(AndrossyStarConfig(), size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
