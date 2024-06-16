import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AndrossyIcon extends StatelessWidget {
  final bool visibility;
  final BoxFit? fit;
  final dynamic icon;
  final double? size;
  final Color? color;
  final BlendMode tintMode;

  const AndrossyIcon({
    super.key,
    this.visibility = true,
    this.icon,
    this.fit,
    this.size,
    this.color,
    this.tintMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility || icon == null) return const SizedBox.shrink();
    final theme = Theme.of(context).iconTheme;
    final color = this.color ?? theme.color;
    final size = this.size ?? theme.size;
    final type = AndrossyIconType.from(icon);
    switch (type) {
      case AndrossyIconType.icon:
        return Icon(
          icon,
          color: color,
          size: size,
          fill: theme.fill,
          weight: theme.weight,
          grade: theme.weight,
          opticalSize: theme.opticalSize,
          shadows: theme.shadows,
        );
      case AndrossyIconType.svg:
        return SvgPicture.asset(
          icon,
          width: size,
          height: size,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null ? ColorFilter.mode(color, tintMode) : null,
          theme: SvgTheme(
            currentColor: color ?? const Color(0xFF808080),
          ),
        );
      case AndrossyIconType.png:
        return Image.asset(
          icon,
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
