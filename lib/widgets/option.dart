import 'package:flutter/material.dart';

typedef AndrossyOptionCallback = Widget Function(
    BuildContext context, Widget child, VoidCallback callback);

typedef AndrossyOptionBuilder<T> = Widget Function(
    BuildContext context, int index, bool selected);

typedef AndrossyOptionChanged<T> = void Function(int index);

class AndrossyOptionProperty<T extends Object?> {
  final T? active;
  final T? inactive;

  const AndrossyOptionProperty({T? active, this.inactive})
      : active = active ?? inactive;

  const AndrossyOptionProperty.all(T? value) : this(inactive: value);

  T? detect(bool active) => active ? this.active : inactive;
}

class AndrossyOption extends StatefulWidget {
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;

  final AndrossyOptionProperty<int>? flex;
  final int currentIndex;
  final int itemCount;
  final double spaceBetween;
  final AndrossyOptionCallback? gesture;
  final AndrossyOptionBuilder builder;
  final AndrossyOptionChanged? onChanged;

  const AndrossyOption({
    super.key,
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.flex,
    required this.builder,
    this.currentIndex = 0,
    this.itemCount = 0,
    this.spaceBetween = 0,
    this.gesture,
    this.onChanged,
  })  : assert(itemCount >= 0, 'itemCount must not be negative'),
        assert(currentIndex >= 0, 'currentIndex must not be negative');

  @override
  State<AndrossyOption> createState() => AndrossyOptionState();
}

class AndrossyOptionState extends State<AndrossyOption> {
  late int currentIndex = _clampIndex(widget.currentIndex);

  bool get isVerticalMode => widget.direction == Axis.vertical;

  @override
  void didUpdateWidget(covariant AndrossyOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex ||
        widget.itemCount != oldWidget.itemCount) {
      currentIndex = _clampIndex(widget.currentIndex);
    }
  }

  void changeIndex(int index) {
    if (index < 0 || index >= widget.itemCount || index == currentIndex) {
      return;
    }
    setState(() => currentIndex = index);
    widget.onChanged?.call(index);
  }

  int _clampIndex(int index) {
    if (widget.itemCount <= 0) return 0;
    return index.clamp(0, widget.itemCount - 1).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.itemCount;
    if (itemCount <= 0) return const SizedBox();
    return Flex(
      direction: widget.direction,
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      verticalDirection: widget.verticalDirection,
      clipBehavior: widget.clipBehavior,
      textDirection: widget.textDirection,
      textBaseline: widget.textBaseline,
      children: List.generate(itemCount, (index) {
        final flex = widget.flex?.detect(index == currentIndex) ?? 0;
        final isExpandable = flex > 0 && !isVerticalMode;
        var child = widget.builder(context, index, index == currentIndex);
        if (widget.spaceBetween > 0 && itemCount - 1 != index) {
          child = Flex(
            direction: widget.direction,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            verticalDirection: widget.verticalDirection,
            clipBehavior: widget.clipBehavior,
            textDirection: widget.textDirection,
            textBaseline: widget.textBaseline,
            children: [
              if (isExpandable)
                Flexible(fit: FlexFit.tight, child: child)
              else
                child,
              SizedBox(
                width: isVerticalMode ? null : widget.spaceBetween,
                height: isVerticalMode ? widget.spaceBetween : null,
              ),
            ],
          );
        }
        Widget root;
        if (widget.gesture != null) {
          root = widget.gesture!(context, child, () => changeIndex(index));
        } else {
          root = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => changeIndex(index),
            child: AbsorbPointer(child: child),
          );
        }
        return flex > 0 ? Expanded(flex: flex, child: root) : root;
      }),
    );
  }
}
