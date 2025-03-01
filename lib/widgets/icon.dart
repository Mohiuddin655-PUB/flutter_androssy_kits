import 'package:flutter/material.dart';

import '../core/androssy.dart';
import '../core/svg_picture.dart';

class AndrossyIcon extends StatelessWidget {
  final dynamic data;
  final bool visibility;
  final BoxFit? fit;
  final double? size;
  final Color? color;
  final BlendMode tintMode;

  const AndrossyIcon(
    this.data, {
    super.key,
    this.visibility = true,
    this.fit,
    this.size,
    this.color,
    this.tintMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility || data == null) return const SizedBox.shrink();
    final theme = Theme.of(context).iconTheme;
    final color = this.color ?? theme.color;
    final size = this.size ?? theme.size;
    final type = AndrossyIconType.from(data);
    switch (type) {
      case AndrossyIconType.icon:
        return Icon(
          data,
          color: color,
          size: size,
          fill: theme.fill,
          weight: theme.weight,
          grade: theme.weight,
          opticalSize: theme.opticalSize,
          shadows: theme.shadows,
        );
      case AndrossyIconType.svg:
        final svg = Androssy.iOrNull?.svgImageBuilder;
        if (svg == null) return SizedBox(width: size, height: size);
        return svg(
          context,
          AndrossySvgPictureConfig(
            data,
            width: size,
            height: size,
            fit: fit ?? BoxFit.contain,
            colorFilter:
                color != null ? ColorFilter.mode(color, tintMode) : null,
            theme: AndrossySvgTheme(
              currentColor: color ?? const Color(0xFF808080),
            ),
            source: AndrossySvgSource.asset,
          ),
        );
      case AndrossyIconType.png:
        return Image.asset(
          data,
          color: color,
          width: size,
          height: size,
          fit: fit,
          colorBlendMode: tintMode,
        );
      default:
        return SizedBox(
          width: size,
          height: size,
        );
    }
  }
}

enum AndrossyIconType {
  none,
  icon,
  svg,
  png;

  factory AndrossyIconType.from(dynamic source) {
    if (source is IconData) {
      return AndrossyIconType.icon;
    } else if (source is String) {
      if (source.endsWith('.svg')) {
        return AndrossyIconType.svg;
      } else if (source.endsWith('.png')) {
        return AndrossyIconType.png;
      } else {
        return AndrossyIconType.none;
      }
    } else {
      return AndrossyIconType.none;
    }
  }
}
