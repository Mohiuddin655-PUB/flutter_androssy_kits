import 'package:flutter/material.dart';

import 'cached_network_image.dart';
import 'svg_picture.dart';

typedef AndrossyBuilder<Config> = Widget Function(
  BuildContext context,
  Config config,
);

typedef AndrossyConverter<Config> = String Function(
  BuildContext context,
  String raw,
);

class Androssy {
  final AndrossyBuilder<AndrossyNetworkImageConfig>? cachedNetworkImageBuilder;
  final AndrossyBuilder<AndrossySvgPictureConfig>? svgImageBuilder;
  final AndrossyConverter<String>? textConverter;

  const Androssy._({
    this.cachedNetworkImageBuilder,
    this.svgImageBuilder,
    this.textConverter,
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
    AndrossyBuilder<AndrossyNetworkImageConfig>? cachedNetworkImageBuilder,
    AndrossyBuilder<AndrossySvgPictureConfig>? svgBuilder,
    AndrossyConverter<String>? textConverter,
  }) {
    _i = Androssy._(
      cachedNetworkImageBuilder: cachedNetworkImageBuilder,
      svgImageBuilder: svgBuilder,
      textConverter: textConverter,
    );
  }
}
