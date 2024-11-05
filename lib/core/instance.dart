import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

typedef AndrossyImageBuilder<Config> = Widget Function(
  BuildContext context,
  Config config,
);

class Androssy {
  final AndrossyImageBuilder<AndrossyNetworkImageConfig>?
      cachedNetworkImageBuilder;
  final AndrossyImageBuilder<AndrossySvgImageConfig>? svgImageBuilder;

  const Androssy._({
    this.cachedNetworkImageBuilder,
    this.svgImageBuilder,
  });

  static Androssy? _i;

  static Androssy? get iOrNull => _i;

  static Androssy get i {
    if (_i != null) return _i!;
    throw UnimplementedError(
      "$Androssy hasn't initialized yet, Firstly initialize $Androssy.init() then use.",
    );
  }

  static void init({
    final AndrossyImageBuilder<AndrossyNetworkImageConfig>?
        cachedNetworkImageBuilder,
    final AndrossyImageBuilder<AndrossySvgImageConfig>? svgImageBuilder,
  }) {
    _i = Androssy._(
      cachedNetworkImageBuilder: cachedNetworkImageBuilder,
      svgImageBuilder: svgImageBuilder,
    );
  }
}

typedef LoadingErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String url,
  Object error,
);

typedef ImageWidgetBuilder = Widget Function(
  BuildContext context,
  ImageProvider imageProvider,
);

typedef PlaceholderWidgetBuilder = Widget Function(
  BuildContext context,
  String url,
);

typedef ProgressIndicatorBuilder = Widget Function(
  BuildContext context,
  String url,
  Object progress,
);

class AndrossyNetworkImageConfig {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlendMode;

  final Alignment alignment;
  final Object? cacheManager;
  final String? cacheKey;
  final LoadingErrorWidgetBuilder? errorWidget;
  final ValueChanged<Object>? errorListener;
  final Curve fadeInCurve;
  final Duration fadeInDuration;
  final Curve fadeOutCurve;
  final Duration? fadeOutDuration;
  final FilterQuality filterQuality;
  final Map<String, String>? httpHeaders;
  final ImageWidgetBuilder? imageBuilder;
  final Object? imageRenderMethodForWeb;
  final bool matchTextDirection;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final Duration? placeholderFadeInDuration;
  final ImageRepeat repeat;
  final bool useOldImageOnUrlChange;

  const AndrossyNetworkImageConfig.adjust({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.cacheManager,
    this.cacheKey,
    this.errorWidget,
    this.errorListener,
    this.fadeInCurve = Curves.easeIn,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeOutDuration,
    this.filterQuality = FilterQuality.low,
    this.httpHeaders,
    this.imageBuilder,
    this.imageRenderMethodForWeb,
    this.matchTextDirection = false,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.memCacheHeight,
    this.memCacheWidth,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.placeholderFadeInDuration,
    this.repeat = ImageRepeat.noRepeat,
    this.useOldImageOnUrlChange = false,
  });

  const AndrossyNetworkImageConfig({
    this.alignment = Alignment.center,
    this.cacheManager,
    this.cacheKey,
    this.errorWidget,
    this.errorListener,
    this.fadeInCurve = Curves.easeIn,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeOutDuration,
    this.filterQuality = FilterQuality.low,
    this.httpHeaders,
    this.imageBuilder,
    this.imageRenderMethodForWeb,
    this.matchTextDirection = false,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.memCacheHeight,
    this.memCacheWidth,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.placeholderFadeInDuration,
    this.repeat = ImageRepeat.noRepeat,
    this.useOldImageOnUrlChange = false,
  })  : imageUrl = '',
        width = null,
        height = null,
        fit = null,
        color = null,
        colorBlendMode = null;
}

enum AndrossyContentSource { asset, file, memory, network, string }

class AndrossySvgImageConfig {
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
  final AndrossyContentSource source;

  String get assetName => data as String;

  String get url => data as String;

  File get file => data as File;

  String get string => data as String;

  Uint8List get bytes => data as Uint8List;

  const AndrossySvgImageConfig(
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
