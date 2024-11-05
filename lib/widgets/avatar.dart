import 'package:flutter/material.dart';

import '../core/cached_network_image.dart';
import 'image.dart';

class AndrossyAvatar extends StatelessWidget {
  final dynamic data;
  final double size;
  final Border? border;
  final BoxShadow? shadow;
  final Color? backgroundColor;
  final AndrossyNetworkImageConfig? networkImageConfig;

  const AndrossyAvatar(
    this.data, {
    super.key,
    this.size = 40,
    this.border,
    this.backgroundColor,
    this.shadow,
    this.networkImageConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: border,
        shape: BoxShape.circle,
        boxShadow: shadow != null ? [shadow!] : null,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: AndrossyImage(
          image: data,
          scaleType: BoxFit.cover,
          networkImageConfig: networkImageConfig ??
              AndrossyNetworkImageConfig(
                errorWidget: (_, __, ___) => const SizedBox(),
              ),
        ),
      ),
    );
  }
}
