import 'package:flutter/material.dart';

typedef AndrossyImageGridFrameRatioBuilder = double? Function(int layer);

class AndrossyImageGrid extends StatefulWidget {
  final double? frameRatio;
  final AndrossyImageGridFrameRatioBuilder? frameRatioBuilder;
  final Color? itemBackground;
  final double itemSpace;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const AndrossyImageGrid({
    super.key,
    required this.itemBuilder,
    this.frameRatio,
    this.frameRatioBuilder,
    this.itemBackground,
    this.itemSpace = 4,
    this.itemCount = 0,
  });

  @override
  State<AndrossyImageGrid> createState() => AndrossyImageGridState();
}

class AndrossyImageGridState extends State<AndrossyImageGrid> {
  @override
  Widget build(BuildContext context) {
    if (itemCount <= 0) return const SizedBox();
    switch (itemCount) {
      case 1:
        return _LayerX(controller: this);
      case 2:
        return _LayerX2(controller: this);
      case 3:
        return _LayerX3(controller: this);
      case 4:
        return _LayerX4(controller: this);
      case 5:
        return _LayerX5(controller: this);
      case 6:
        return _LayerX6(controller: this);
      default:
        return _LayerXn(controller: this);
    }
  }

  int get invisibleItemSize => itemCount - 5;

  int get itemCount => widget.itemCount;

  double? get spaceBetween => widget.itemSpace;

  IndexedWidgetBuilder get builder => widget.itemBuilder;

  double? ratioBuilder(int layer) {
    return widget.frameRatioBuilder?.call(layer) ?? widget.frameRatio;
  }
}

class _Builder extends StatelessWidget {
  final AndrossyImageGridState controller;
  final double? maxHeight;
  final Widget child;
  final double? dimension;
  final bool flexible, resizable;

  const _Builder({
    required this.controller,
    required this.child,
    this.flexible = false,
    this.resizable = false,
    this.maxHeight,
    this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      width: double.infinity,
      height: resizable ? null : double.infinity,
      child: this.child,
    );

    if (maxHeight != null && maxHeight! > 0) {
      child = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight!),
        child: child,
      );
    }

    if (controller.widget.itemBackground != null) {
      child = ColoredBox(
        color: controller.widget.itemBackground!,
        child: child,
      );
    }

    if (flexible) {
      child = Expanded(
        child: child,
      );
    }

    if (dimension != null && dimension! > 0) {
      child = AspectRatio(
        aspectRatio: dimension!,
        child: child,
      );
    }

    return child;
  }
}

class _LayerX extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(1);
    return aspectRatio != null && aspectRatio > 0
        ? _Builder(
            controller: controller,
            dimension: aspectRatio,
            child: controller.builder(context, 0),
          )
        : _Builder(
            controller: controller,
            maxHeight: 500,
            resizable: true,
            child: controller.builder(context, 0),
          );
  }
}

class _LayerX2 extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX2({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(2);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 3 / 1.8,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          _Builder(
            controller: controller,
            flexible: true,
            child: controller.builder(context, 0),
          ),
          SizedBox(
            width: controller.spaceBetween,
          ),
          _Builder(
            controller: controller,
            flexible: true,
            child: controller.builder(context, 1),
          ),
        ],
      ),
    );
  }
}

class _LayerX3 extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX3({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(3);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 3 / 2.2,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          _Builder(
            controller: controller,
            dimension: 0.8,
            child: controller.builder(context, 0),
          ),
          SizedBox(
            width: controller.spaceBetween,
          ),
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 1),
                ),
                SizedBox(
                  height: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerX4 extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX4({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(4);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  dimension: 1,
                  child: controller.builder(context, 0),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  dimension: 1,
                  child: controller.builder(context, 1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: controller.spaceBetween,
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  dimension: 1,
                  child: controller.builder(context, 2),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  dimension: 1,
                  child: controller.builder(context, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerX5 extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX5({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(5);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 0),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: controller.spaceBetween,
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 2),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 3),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerX6 extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerX6({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(6);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 0),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 1),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 2),
                ),
              ],
            ),
          ),
          SizedBox(
            height: controller.spaceBetween,
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 3),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 4),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerXn extends StatelessWidget {
  final AndrossyImageGridState controller;

  const _LayerXn({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.ratioBuilder(7);
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 0),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 1),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 2),
                ),
              ],
            ),
          ),
          SizedBox(
            height: controller.spaceBetween,
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 3),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                _Builder(
                  controller: controller,
                  flexible: true,
                  child: controller.builder(context, 4),
                ),
                SizedBox(
                  width: controller.spaceBetween,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _Builder(
                          controller: controller,
                          child: controller.builder(context, 5),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.35),
                          child: Text(
                            "+${controller.invisibleItemSize}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
