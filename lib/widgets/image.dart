import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../core/androssy.dart';
import '../core/cached_network_image.dart';
import '../core/svg_picture.dart';

class AndrossyImage extends StatelessWidget {
  final dynamic data;
  final bool visibility;
  final AndrossyImageType type;
  final double? width, height;
  final BoxFit? fit;
  final bool cacheMode;
  final Color? tint;
  final BlendMode? tintMode;
  final AndrossyNetworkImageConfig? networkImageConfig;

  const AndrossyImage(
    this.data, {
    super.key,
    this.visibility = true,
    this.width,
    this.height,
    this.cacheMode = true,
    this.type = AndrossyImageType.detect,
    this.fit,
    this.tint,
    this.tintMode,
    this.networkImageConfig,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility || data == null) return const SizedBox.shrink();
    final androssy = Androssy.iOrNull;
    final type = AndrossyImageType._(data, this.type);
    if (type == AndrossyImageType.asset) {
      return Image.asset(
        "$data",
        width: width,
        height: height,
        fit: fit,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type == AndrossyImageType.network) {
      if (cacheMode && androssy?.cachedNetworkImageBuilder != null) {
        final config = networkImageConfig ?? const AndrossyNetworkImageConfig();
        return androssy!.cachedNetworkImageBuilder!(
          context,
          AndrossyNetworkImageConfig.adjust(
            imageUrl: "$data",
            width: width,
            height: height,
            fit: fit,
            color: tint,
            colorBlendMode: tintMode,
            alignment: config.alignment,
            cacheKey: config.cacheKey,
            cacheManager: config.cacheManager,
            errorWidget: config.errorWidget,
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
            progressIndicatorBuilder: config.progressIndicatorBuilder,
            repeat: config.repeat,
            useOldImageOnUrlChange: config.useOldImageOnUrlChange,
          ),
        );
      } else {
        return Image.network(
          "$data",
          width: width,
          height: height,
          fit: fit,
          color: tint,
          colorBlendMode: tintMode,
        );
      }
    } else if (type == AndrossyImageType.file) {
      return Image.file(
        data,
        width: width,
        height: height,
        fit: fit,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type == AndrossyImageType.memory) {
      return Image.memory(
        data,
        width: width,
        height: height,
        fit: fit,
        color: tint,
        colorBlendMode: tintMode,
      );
    } else if (type.isSvgPicture && androssy?.svgImageBuilder != null) {
      return androssy!.svgImageBuilder!(
        context,
        AndrossySvgPictureConfig(
          data,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          colorFilter: tint != null
              ? ColorFilter.mode(
                  tint!,
                  tintMode ?? BlendMode.srcIn,
                )
              : null,
          theme: AndrossySvgTheme(
            currentColor: tint ?? const Color(0xFF808080),
          ),
          source: type == AndrossyImageType.svg
              ? AndrossySvgSource.asset
              : type == AndrossyImageType.svgNetwork
                  ? AndrossySvgSource.network
                  : AndrossySvgSource.string,
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

  bool get isSvgPicture => this == svg || this == svgCode || this == svgNetwork;

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
