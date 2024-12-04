import 'package:flutter/material.dart';

import 'gesture.dart';
import 'icon.dart';
import 'image.dart';

class AndrossyThumbnail extends StatelessWidget {
  final double frameRatio;
  final dynamic data;
  final BoxFit fit;
  final Color frameColor;
  final Color? foregroundColor;
  final Color? buttonBackgroundColor;
  final Color? buttonForegroundColor;
  final Color? buttonShadowColor;
  final double buttonRadius;
  final Widget? button;
  final VoidCallback? onPlay;

  const AndrossyThumbnail(
    this.data, {
    super.key,
    this.frameRatio = 12 / 9,
    this.fit = BoxFit.cover,
    this.frameColor = Colors.black,
    this.foregroundColor,
    this.button,
    this.buttonBackgroundColor,
    this.buttonForegroundColor,
    this.buttonShadowColor,
    this.buttonRadius = 20,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: frameRatio,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          ColoredBox(color: frameColor),
          AndrossyImage(
            data,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          if (foregroundColor != null) ColoredBox(color: foregroundColor!),
          button ??
              Center(
                child: AndrossyGesture(
                  onTap: onPlay,
                  clickEffect: AndrossyGestureEffect.bounce(),
                  child: Container(
                    padding: EdgeInsets.all(buttonRadius / 2),
                    decoration: BoxDecoration(
                      color: buttonBackgroundColor ??
                          Colors.black.withOpacity(0.75),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              buttonShadowColor ?? Colors.grey.withOpacity(0.1),
                          blurRadius: (buttonRadius / 2) * 5,
                        )
                      ],
                    ),
                    child: AndrossyIcon(
                      Icons.play_arrow_rounded,
                      size: buttonRadius * 2,
                      color: buttonForegroundColor ??
                          Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
