import 'dart:ui';

import 'package:flutter/material.dart';

import 'painter.dart';

Path _path(AndrossyDockConfig config, Size size) {
  final borderRadius = config.getAdjustmentRadius(size) ?? BorderRadius.zero;
  final curveHeightPercentage = config.curveHeightPercentage ?? 0.15;
  final curveWidthPercentage = config.curveWidthPercentage ?? 0.15;
  final sides = config.sides ?? const DockedArcSides();
  final strokeInset = config.strokeInset;
  final dockInset = config.dockInset != 0 ? config.dockInset : strokeInset;

  final btl = borderRadius.topLeft;
  final btr = borderRadius.topRight;
  final bbl = borderRadius.bottomLeft;
  final bbr = borderRadius.bottomRight;

  final x = size.width;
  final y = size.height;

  final curveX = x * curveWidthPercentage;
  final curveY = y * curveHeightPercentage;

  Path path = Path();

  /// TOP LEFT
  path.moveTo(btl.x + strokeInset, strokeInset);
  path.arcToPoint(
    Offset(strokeInset, btl.y + strokeInset),
    radius: Radius.circular(btl.x),
    clockwise: sides.topLeft.isCornerDock,
  );

  /// LEFT
  if (sides.left.isDock) {
    path.lineTo(dockInset, y / 2 - curveY);
    path.arcToPoint(
      Offset(dockInset, y / 2 + curveY),
      radius: Radius.circular(curveY),
      clockwise: sides.left.isInner,
    );
  }

  /// BOTTOM LEFT
  path.lineTo(strokeInset, y - bbl.y - strokeInset);
  path.arcToPoint(
    Offset(bbl.x + strokeInset, y - strokeInset),
    radius: Radius.circular(bbl.x),
    clockwise: sides.bottomLeft.isCornerDock,
  );

  /// BOTTOM
  if (sides.bottom.isDock) {
    path.lineTo(x / 2 - curveX, y - dockInset);
    path.arcToPoint(
      Offset(x / 2 + curveX, y - dockInset),
      radius: Radius.circular(curveX),
      clockwise: sides.bottom.isInner,
    );
  }

  /// BOTTOM RIGHT
  path.lineTo(x - bbr.x - strokeInset, y - strokeInset);
  path.arcToPoint(
    Offset(x - strokeInset, y - bbr.y - strokeInset),
    radius: Radius.circular(bbr.x),
    clockwise: sides.bottomRight.isCornerDock,
  );

  /// RIGHT
  if (sides.right.isDock) {
    path.lineTo(x - dockInset, y / 2 + curveY);
    path.arcToPoint(
      Offset(x - dockInset, y / 2 - curveY),
      radius: Radius.circular(curveY),
      clockwise: sides.right.isInner,
    );
  }

  /// TOP RIGHT
  path.lineTo(x - strokeInset, btr.y + strokeInset);
  path.arcToPoint(
    Offset(x - btr.x - strokeInset, strokeInset),
    radius: Radius.circular(btr.x),
    clockwise: sides.topRight.isCornerDock,
  );

  /// TOP
  if (sides.top.isDock) {
    path.lineTo(x / 2 + curveX, dockInset);
    path.arcToPoint(
      Offset(x / 2 - curveX, dockInset),
      radius: Radius.circular(curveX),
      clockwise: sides.top.isInner,
    );
  }
  return path..close();
}

class DockedArcSides {
  final DockedArcSide left;
  final DockedArcSide top;
  final DockedArcSide right;
  final DockedArcSide bottom;
  final DockedArcSide topLeft;
  final DockedArcSide topRight;
  final DockedArcSide bottomLeft;
  final DockedArcSide bottomRight;

  const DockedArcSides({
    this.left = DockedArcSide.none,
    this.top = DockedArcSide.none,
    this.right = DockedArcSide.none,
    this.bottom = DockedArcSide.none,
    this.topLeft = DockedArcSide.outer,
    this.topRight = DockedArcSide.outer,
    this.bottomLeft = DockedArcSide.outer,
    this.bottomRight = DockedArcSide.outer,
  });
}

enum DockedArcSide {
  inner,
  outer,
  none;

  bool get isDock => this != none;

  bool get isInner => this == inner;

  bool get isOuter => this == outer;

  bool get isCornerDock => this == inner;
}

class AndrossyDockConfig extends AndrossyPainterConfig {
  final double? curveHeightPercentage;
  final double? curveWidthPercentage;
  final DockedArcSides? sides;
  final double dockInset;

  const AndrossyDockConfig({
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
    super.strokePoints = const [],
    super.strokeWidth,
    super.style,
    // CHILD
    this.curveHeightPercentage,
    this.curveWidthPercentage,
    this.sides,
    this.dockInset = 0,
  });

  AndrossyDockConfig copyWith({
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
    double? curveHeightPercentage,
    double? curveWidthPercentage,
    DockedArcSides? sides,
  }) {
    return AndrossyDockConfig(
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
      curveHeightPercentage:
          curveHeightPercentage ?? this.curveHeightPercentage,
      curveWidthPercentage: curveWidthPercentage ?? this.curveWidthPercentage,
      sides: sides ?? this.sides,
    );
  }
}

class AndrossyDockPainter extends CustomPainter {
  final AndrossyDockConfig config;

  const AndrossyDockPainter({
    this.config = const AndrossyDockConfig(),
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

class AndrossyDockClipper extends CustomClipper<Path> {
  final AndrossyDockConfig config;

  const AndrossyDockClipper({
    super.reclip,
    required this.config,
  });

  @override
  Path getClip(Size size) {
    final path = _path(config, size);
    if (config.style == PaintingStyle.stroke &&
        config.strokePoints.isNotEmpty) {
      return config.dash(path);
    } else {
      return _path(config, size);
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
