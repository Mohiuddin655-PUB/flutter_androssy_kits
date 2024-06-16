import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_androssy_kits/painters.dart';

class DockedShapeExample extends StatefulWidget {
  const DockedShapeExample({super.key});

  @override
  State<DockedShapeExample> createState() => _DockedShapeExampleState();
}

class _DockedShapeExampleState extends State<DockedShapeExample>
    with TickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  double innerRadius = 0.5;
  int points = 5;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final value = animation.value;
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.fill,
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.inner,
                            bottom: DockedArcSide.inner,
                            left: DockedArcSide.inner,
                            right: DockedArcSide.inner,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.stroke,
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.inner,
                            bottom: DockedArcSide.inner,
                            left: DockedArcSide.inner,
                            right: DockedArcSide.inner,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.fill,
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.outer,
                            bottom: DockedArcSide.outer,
                            left: DockedArcSide.outer,
                            right: DockedArcSide.outer,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.stroke,
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.outer,
                            bottom: DockedArcSide.outer,
                            left: DockedArcSide.outer,
                            right: DockedArcSide.outer,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.fill,
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.inner,
                            bottom: DockedArcSide.inner,
                            left: DockedArcSide.outer,
                            right: DockedArcSide.outer,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      painter: AndrossyDockPainter(
                        config: AndrossyDockConfig(
                          style: PaintingStyle.stroke,
                          strokePoints: [5, 2.5],
                          borderRadius: BorderRadius.circular(value * 20),
                          sides: const DockedArcSides(
                            top: DockedArcSide.inner,
                            bottom: DockedArcSide.inner,
                            left: DockedArcSide.outer,
                            right: DockedArcSide.outer,
                            topLeft: DockedArcSide.inner,
                            topRight: DockedArcSide.inner,
                            bottomLeft: DockedArcSide.inner,
                            bottomRight: DockedArcSide.inner,
                          ),
                          gradient: const LinearGradient(
                            colors: Colors.primaries,
                          ),
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ],
            );
          },
          child: const SizedBox(
            width: 120,
            height: 100,
          ),
        ),
      ),
    );
  }
}
