import 'package:flutter/material.dart';

enum FlexPosition {
  centerX(left: 0, right: 0),
  centerY(top: 0, bottom: 0),
  start(left: 0, top: 0, bottom: 0),
  end(right: 0, top: 0, bottom: 0),
  above(top: 0, left: 0, right: 0),
  down(bottom: 0, left: 0, right: 0);

  final double? top, bottom, left, right;

  const FlexPosition({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });
}

class AndrossyFlex extends StatelessWidget {
  final FlexPosition flexPosition;
  final bool frontMode;
  final Widget? flexible;
  final Widget child;

  const AndrossyFlex({
    super.key,
    this.flexible,
    this.flexPosition = FlexPosition.start,
    this.frontMode = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (flexible == null) return child;
    return Stack(
      alignment: Alignment.center,
      children: [
        if (frontMode) child,
        Positioned(
          left: flexPosition.left,
          right: flexPosition.right,
          top: flexPosition.top,
          bottom: flexPosition.bottom,
          child: flexible!,
        ),
        if (!frontMode) child,
      ],
    );
  }
}
