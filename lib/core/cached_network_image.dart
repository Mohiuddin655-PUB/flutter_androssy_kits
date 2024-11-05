import 'package:flutter/material.dart';

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
