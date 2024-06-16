import 'package:flutter/material.dart';

class AndrossyGuideline extends StatelessWidget {
  final bool visibility;
  final double x;
  final double y;
  final Widget child;

  const AndrossyGuideline({
    super.key,
    this.visibility = true,
    required this.x,
    required this.y,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isPositiveX = x > 0;
        bool isPositiveY = y > 0;
        double mX = constraints.maxWidth * (x / 50);
        double mY = constraints.maxHeight * (y / 50);
        return Padding(
          padding: EdgeInsets.only(
            left: isPositiveX ? mX : 0,
            right: !isPositiveX ? mX * -1 : 0,
            top: !isPositiveY ? mY * -1 : 0,
            bottom: isPositiveY ? mY : 0,
          ),
          child: child,
        );
      },
    );
  }
}
