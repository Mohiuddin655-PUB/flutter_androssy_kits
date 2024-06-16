import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';

class AndrossyImage extends StatelessWidget {
  final bool visibility;
  final dynamic image;
  final AndrossyImageType imageType;
  final double? width, height;
  final BoxFit? scaleType;
  final bool cacheMode;
  final Color? tint;
  final BlendMode? tintMode;
  final AndrossyNetworkImageConfig? networkImageConfig;

  const AndrossyImage({
    super.key,
    this.visibility = true,
    this.width,
    this.height,
    this.cacheMode = true,
    this.image,
    this.imageType = AndrossyImageType.detect,
    this.scaleType,
    this.tint,
    this.tintMode,
    this.networkImageConfig,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility || image == null) return const SizedBox.shrink();
    final type = AndrossyImageType._(image, imageType);
    if (type == AndrossyImageType.asset) {
      return Image.asset(
        "$image",
        width: width,
        height: height,
        fit: scaleType,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type == AndrossyImageType.network) {
      if (cacheMode) {
        final config = networkImageConfig ?? const AndrossyNetworkImageConfig();
        return CachedNetworkImage(
          imageUrl: "$image",
          width: width,
          height: height,
          fit: scaleType,
          color: tint,
          colorBlendMode: tintMode,
          alignment: config.alignment,
          cacheKey: config.cacheKey,
          cacheManager: config.cacheManager,
          errorWidget: config.errorBuilder,
          errorListener: config.errorListener,
          fadeInCurve: config.fadeInCurve,
          fadeInDuration: config.fadeInDuration,
          fadeOutCurve: config.fadeOutCurve,
          fadeOutDuration: config.fadeOutDuration,
          filterQuality: config.filterQuality,
          httpHeaders: config.httpHeaders,
          imageBuilder: config.imageBuilder,
          imageRenderMethodForWeb: config.imageRenderMethodForWeb,
          matchTextDirection: config.matchTextDirection,
          maxHeightDiskCache: config.maxHeightDiskCache,
          maxWidthDiskCache: config.maxWidthDiskCache,
          memCacheHeight: config.memCacheHeight,
          memCacheWidth: config.memCacheWidth,
          placeholder: config.placeholder,
          placeholderFadeInDuration: config.placeholderFadeInDuration,
          progressIndicatorBuilder: config.progressBuilder,
          repeat: config.repeat,
          useOldImageOnUrlChange: config.useOldImageOnUrlChange,
        );
      } else {
        return Image.network(
          "$image",
          width: width,
          height: height,
          fit: scaleType,
          color: tint,
          colorBlendMode: tintMode,
        );
      }
    } else if (type == AndrossyImageType.file) {
      return Image.file(
        image,
        width: width,
        height: height,
        fit: scaleType,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type == AndrossyImageType.memory) {
      return Image.memory(
        image,
        width: width,
        height: height,
        fit: scaleType,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type == AndrossyImageType.svg) {
      return SvgPicture.asset(
        image,
        width: width,
        height: height,
        fit: scaleType ?? BoxFit.contain,
        colorFilter: tint != null
            ? ColorFilter.mode(
                tint!,
                tintMode ?? BlendMode.srcIn,
              )
            : null,
        theme: SvgTheme(
          currentColor: tint ?? const Color(0xFF808080),
        ),
      );
    } else if (type == AndrossyImageType.svgNetwork) {
      return SvgPicture.network(
        image,
        width: width,
        height: height,
        fit: scaleType ?? BoxFit.contain,
        colorFilter: tint != null
            ? ColorFilter.mode(
                tint!,
                tintMode ?? BlendMode.srcIn,
              )
            : null,
        theme: SvgTheme(
          currentColor: tint ?? const Color(0xFF808080),
        ),
      );
    } else if (type == AndrossyImageType.svgCode) {
      return SvgPicture.string(
        image,
        width: width,
        height: height,
        fit: scaleType ?? BoxFit.contain,
        colorFilter: tint != null
            ? ColorFilter.mode(
                tint!,
                tintMode ?? BlendMode.srcIn,
              )
            : null,
        theme: SvgTheme(
          currentColor: tint ?? const Color(0xFF808080),
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
      );
    }
  }
}

class AndrossyNetworkImageConfig {
  final Alignment alignment;
  final BaseCacheManager? cacheManager;
  final String? cacheKey;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final ValueChanged<Object>? errorListener;
  final Curve fadeInCurve;
  final Duration fadeInDuration;
  final Curve fadeOutCurve;
  final Duration? fadeOutDuration;
  final FilterQuality filterQuality;
  final Map<String, String>? httpHeaders;
  final ImageWidgetBuilder? imageBuilder;
  final ImageRenderMethodForWeb imageRenderMethodForWeb;
  final bool matchTextDirection;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressBuilder;
  final Duration? placeholderFadeInDuration;
  final ImageRepeat repeat;
  final bool useOldImageOnUrlChange;

  const AndrossyNetworkImageConfig({
    this.alignment = Alignment.center,
    this.cacheManager,
    this.cacheKey,
    this.errorBuilder,
    this.errorListener,
    this.fadeInCurve = Curves.easeIn,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeOutDuration,
    this.filterQuality = FilterQuality.low,
    this.httpHeaders,
    this.imageBuilder,
    this.imageRenderMethodForWeb = ImageRenderMethodForWeb.HtmlImage,
    this.matchTextDirection = false,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.memCacheHeight,
    this.memCacheWidth,
    this.placeholder,
    this.progressBuilder,
    this.placeholderFadeInDuration,
    this.repeat = ImageRepeat.noRepeat,
    this.useOldImageOnUrlChange = false,
  });
}

enum AndrossyImageType {
  unknown,
  detect,
  asset,
  file,
  memory,
  network,
  svg,
  svgCode,
  svgNetwork;

  factory AndrossyImageType.from(dynamic data) => AndrossyImageType._(data);

  factory AndrossyImageType._(
    dynamic data, [
    AndrossyImageType type = AndrossyImageType.detect,
  ]) {
    if (type == AndrossyImageType.detect || type == AndrossyImageType.unknown) {
      if (data is String) {
        if (data.isAsset) {
          if (data.isSvg) {
            return AndrossyImageType.svg;
          } else {
            return AndrossyImageType.asset;
          }
        } else if (data.isNetwork) {
          if (data.isSvg) {
            return AndrossyImageType.svgNetwork;
          } else {
            return AndrossyImageType.network;
          }
        } else if (data.isSvgCode) {
          return AndrossyImageType.svgCode;
        } else {
          return AndrossyImageType.unknown;
        }
      } else if (data is File) {
        return AndrossyImageType.file;
      } else if (data is Uint8List) {
        return AndrossyImageType.memory;
      } else {
        return AndrossyImageType.unknown;
      }
    } else {
      return type;
    }
  }
}

extension _AndrossyImageTypeExtension on String {
  bool get isAsset {
    return startsWith('assets/') || startsWith('asset/');
  }

  bool get isNetwork {
    return startsWith('https://') || startsWith('http://');
  }

  bool get isSvg {
    return endsWith(".svg");
  }

  bool get isSvgCode {
    var code = replaceAll("\n", "");
    return code.startsWith("<svg") && code.endsWith("/svg>");
  }
}
