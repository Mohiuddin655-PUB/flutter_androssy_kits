import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';

class StarShapePage extends StatefulWidget {
  const StarShapePage({super.key});

  @override
  State<StarShapePage> createState() => _StarShapePageState();
}

class _StarShapePageState extends State<StarShapePage>
    with TickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    animation.repeat(reverse: true);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final points = max(animation.value * 100, 5).toInt();
            return Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: AndrossyStarPainter(
                      config: AndrossyStarConfig(
                        style: PaintingStyle.fill,
                        points: points,
                        gradient: const RadialGradient(
                          colors: Colors.primaries,
                          radius: 0.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "SOLID",
                        style: style.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: AndrossyStarPainter(
                      config: AndrossyStarConfig(
                        style: PaintingStyle.stroke,
                        strokeAlign: StrokeAlign.inside,
                        points: min(points, 25),
                        inverse: true,
                        strokeWidth: 2,
                        color: Colors.orange,
                        gradient: const RadialGradient(
                          colors: Colors.primaries,
                          radius: 0.5,
                        ),
                      ),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: AndrossyStarPainter(
                      config: AndrossyStarConfig(
                        style: PaintingStyle.stroke,
                        strokeAlign: StrokeAlign.inside,
                        points: points,
                        strokeWidth: 5,
                        gradient: const RadialGradient(
                          colors: Colors.primaries,
                          radius: 0.5,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text("STROKE", style: style),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: AndrossyStarPainter(
                      config: AndrossyStarConfig(
                        style: PaintingStyle.stroke,
                        strokeAlign: StrokeAlign.inside,
                        points: points,
                        strokeWidth: 5,
                        strokePoints: [10, 2.5],
                        gradient: const RadialGradient(
                          colors: Colors.primaries,
                          radius: 0.5,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text("DOTTED\nBORDER", style: style),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
