import 'package:flutter/material.dart';

enum AndrossyFadePosition { background, foreground }

enum AndrossyFadeType { inside, outside }

class AndrossyFade extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final double thickness;
  final bool top;
  final bool left;
  final bool right;
  final bool bottom;
  final AndrossyFadePosition position;
  final AndrossyFadeType type;
  final Widget? child;
  final Axis axis;

  const AndrossyFade({
    super.key,
    this.width = double.infinity,
    this.height,
    this.type = AndrossyFadeType.inside,
    this.thickness = 25.0,
    this.color = Colors.white,
    this.child,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
    this.position = AndrossyFadePosition.foreground,
    this.axis = Axis.vertical,
  });

  bool get isInside => type == AndrossyFadeType.inside;

  bool get isForeground => position == AndrossyFadePosition.foreground;

  bool get isVertical => axis == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? thickness,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (child != null && isForeground) child!,
          if (left && !isVertical)
            Positioned(left: 0, top: 0, bottom: 0, child: _fader(1)),
          if (right && !isVertical)
            Positioned(right: 0, top: 0, bottom: 0, child: _fader(2)),
          if (top && isVertical)
            Positioned(top: 0, left: 0, right: 0, child: _fader(3)),
          if (bottom && isVertical)
            Positioned(bottom: 0, left: 0, right: 0, child: _fader(4)),
          if (child != null && !isForeground) child!,
        ],
      ),
    );
  }

  Widget _fader(int type) {
    final leftMode = type == 1;
    final rightMode = type == 2;
    final topMode = type == 3;
    final bottomMode = type == 4;
    final colors = [
      color,
      color.withAlpha(127),
      color.withAlpha(127).withAlpha(50),
    ];
    return Container(
      width: left || right ? thickness : null,
      height: top || bottom ? thickness : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: top || bottom ? Alignment.topCenter : Alignment.centerLeft,
          end: top || bottom ? Alignment.bottomCenter : Alignment.centerRight,
          tileMode: TileMode.clamp,
          stops: const [0.0, 0.35, 0.65, 1],
          colors: [
            if (topMode || leftMode) ...(isInside ? colors : colors.reversed),
            color.withAlpha(0),
            if (bottomMode || rightMode)
              ...(isInside ? colors.reversed : colors),
          ],
        ),
      ),
    );
  }
}
