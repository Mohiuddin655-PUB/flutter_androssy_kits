import 'package:flutter/material.dart';

enum FadeSide {
  top,
  bottom,
  left,
  right,
  vertical,
  horizontal;

  bool get both => this == horizontal || this == vertical;

  Alignment get _begin {
    return switch (this) {
      top || bottom || vertical => Alignment.topCenter,
      left || right || horizontal => Alignment.centerLeft,
    };
  }

  Alignment get _end {
    return switch (this) {
      top || bottom || vertical => Alignment.bottomCenter,
      left || right || horizontal => Alignment.centerRight,
    };
  }

  List<Color> get _fader {
    bool a = this == top || this == left || both;
    bool b = this == bottom || this == right || both;
    return [
      a ? Colors.transparent : Colors.black,
      Colors.black,
      Colors.black,
      b ? Colors.transparent : Colors.black,
    ];
  }
}

class AndrossyFade extends StatelessWidget {
  final double fadeWidthFraction;
  final FadeSide side;
  final Widget child;

  const AndrossyFade({
    super.key,
    this.fadeWidthFraction = 0.1,
    this.side = FadeSide.horizontal,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double fadeWidth = width * fadeWidthFraction;
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: side._begin,
              end: side._end,
              colors: side._fader,
              stops: [
                0.0,
                fadeWidth / width,
                1.0 - fadeWidth / width,
                1.0,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: child,
        );
      },
    );
  }
}
