import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

enum AndrossySvgSource { asset, file, memory, network, string }

class AndrossySvgPictureConfig {
  final Key? key;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  final WidgetBuilder? placeholderBuilder;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  final ColorFilter? colorFilter;
  final AndrossySvgTheme? theme;
  final AssetBundle? bundle;
  final String? package;
  final dynamic data;
  final Map<String, String>? headers;
  final AndrossySvgSource source;

  String get assetName => data as String;

  String get url => data as String;

  File get file => data as File;

  String get string => data as String;

  Uint8List get bytes => data as Uint8List;

  const AndrossySvgPictureConfig(
    this.data, {
    this.key,
    this.matchTextDirection = false,
    this.bundle,
    this.package,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.theme,
    this.colorFilter,
    this.headers,
    required this.source,
  });
}

class AndrossySvgTheme {
  final Color currentColor;
  final double fontSize;
  final double xHeight;

  const AndrossySvgTheme({
    this.currentColor = const Color(0xFF000000),
    this.fontSize = 14,
    double? xHeight,
  }) : xHeight = xHeight ?? fontSize / 2;
}
