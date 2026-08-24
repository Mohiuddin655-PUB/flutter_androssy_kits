import 'dart:async';

import 'package:flutter/material.dart';

import 'guideline.dart';

typedef OnAndrossySplashExecuteListener = Future Function(BuildContext context);
typedef OnAndrossySplashRouteListener = Function(BuildContext context);

class AndrossySplash extends StatefulWidget {
  final int duration;
  final double axisY;
  final double axisX;

  final Widget? content;
  final Widget? footer;

  final OnAndrossySplashExecuteListener? onExecute;
  final OnAndrossySplashRouteListener? onRoute;

  const AndrossySplash({
    super.key,
    this.duration = 5000,
    this.axisX = 0,
    this.axisY = 0,
    this.content,
    this.footer,
    this.onRoute,
    this.onExecute,
  });

  @override
  State<AndrossySplash> createState() => _AndrossySplashState();
}

class _AndrossySplashState extends State<AndrossySplash> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer?.cancel();
      _timer = Timer(Duration(milliseconds: widget.duration), () {
        if (!mounted) return;
        final onExecute = widget.onExecute;
        final onRoute = widget.onRoute;
        if (onExecute != null) {
          onExecute(context).whenComplete(() {
            if (!mounted) return;
            onRoute?.call(context);
          });
        } else {
          onRoute?.call(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AndrossyGuideline(
            x: widget.axisX,
            y: widget.axisY,
            child: widget.content ?? const SizedBox.shrink(),
          ),
          if (widget.footer != null)
            Positioned(bottom: 0, left: 0, right: 0, child: widget.footer!),
        ],
      ),
    );
  }
}
