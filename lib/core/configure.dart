import 'package:flutter/material.dart';

import 'androssy.dart';
import 'cached_network_image.dart';
import 'svg_picture.dart';

class AndrossyConfigure extends StatefulWidget {
  final AndrossyBuilder<AndrossyNetworkImageConfig>? cachedNetworkImageBuilder;
  final AndrossyBuilder<AndrossySvgPictureConfig>? svgImageBuilder;
  final AndrossyConverter<String>? textConverter;
  final Widget child;

  const AndrossyConfigure({
    super.key,
    required this.child,
    this.cachedNetworkImageBuilder,
    this.svgImageBuilder,
    this.textConverter,
  });

  @override
  State<AndrossyConfigure> createState() => _AndrossyConfigureState();
}

class _AndrossyConfigureState extends State<AndrossyConfigure> {
  @override
  void initState() {
    super.initState();
    Androssy.init(
      cachedNetworkImageBuilder: widget.cachedNetworkImageBuilder,
      svgBuilder: widget.svgImageBuilder,
      textConverter: widget.textConverter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
