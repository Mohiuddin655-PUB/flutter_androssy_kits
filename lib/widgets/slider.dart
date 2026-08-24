import 'package:flutter/material.dart';

enum PositionType {
  /// Left positions
  left(left: 0),
  leftTop(left: 0, top: 0),
  leftBottom(left: 0, bottom: 0),
  leftFlex(left: 0, top: 0, bottom: 0),

  /// Right positions
  right(right: 0),
  rightTop(right: 0, top: 0),
  rightBottom(right: 0, bottom: 0),
  rightFlex(right: 0, top: 0, bottom: 0),

  /// Top positions
  top(top: 0),
  topLeft(top: 0, left: 0),
  topRight(top: 0, right: 0),
  topFlex(top: 0, left: 0, right: 0),

  /// Bottom positions
  bottom(bottom: 0),
  bottomLeft(bottom: 0, left: 0),
  bottomRight(bottom: 0, right: 0),
  bottomFlex(bottom: 0, left: 0, right: 0),

  /// Center positions
  center,
  fill(left: 0, right: 0, top: 0, bottom: 0),
  fillX(left: 0, right: 0),
  fillY(top: 0, bottom: 0);

  final double? _left, _right, _top, _bottom;

  const PositionType({double? left, double? right, double? top, double? bottom})
      : _left = left,
        _right = right,
        _top = top,
        _bottom = bottom;
}

class AndrossySlider extends StatefulWidget {
  final double frameRatio;
  final int index;
  final int itemCount;
  final ValueChanged<int>? onChanged;
  final IndexedWidgetBuilder builder;
  final IndexedWidgetBuilder? counterBuilder;
  final PositionType counterPosition;
  final bool showCounter;

  const AndrossySlider({
    super.key,
    this.counterBuilder,
    this.counterPosition = PositionType.topRight,
    this.showCounter = true,
    this.frameRatio = 1,
    this.index = 0,
    this.onChanged,
    required this.itemCount,
    required this.builder,
  })  : assert(frameRatio > 0, 'frameRatio must be greater than zero'),
        assert(index >= 0, 'index must not be negative'),
        assert(itemCount >= 0, 'itemCount must not be negative');

  @override
  State<AndrossySlider> createState() => _AndrossySliderState();
}

class _AndrossySliderState extends State<AndrossySlider> {
  late final _pager = PageController(initialPage: _clampIndex(widget.index));
  late final _index = ValueNotifier(_clampIndex(widget.index));

  bool get isCounterMode => widget.showCounter && widget.itemCount > 1;

  void _changeIndex(int value) {
    if (isCounterMode) _index.value = value;
    if (widget.onChanged != null) widget.onChanged!(value);
  }

  int _clampIndex(int value) {
    if (widget.itemCount <= 0) return 0;
    return value.clamp(0, widget.itemCount - 1).toInt();
  }

  @override
  void didUpdateWidget(covariant AndrossySlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextIndex = _clampIndex(widget.index);
    if (oldWidget.index != widget.index ||
        oldWidget.itemCount != widget.itemCount) {
      _index.value = nextIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_pager.hasClients) return;
        final page = _pager.page?.round() ?? _pager.initialPage;
        if (page != nextIndex) _pager.jumpToPage(nextIndex);
      });
    }
  }

  @override
  void dispose() {
    _pager.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.frameRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: PageView.builder(
              controller: _pager,
              itemCount: widget.itemCount,
              onPageChanged: _changeIndex,
              itemBuilder: (context, index) {
                return widget.builder(context, index);
              },
            ),
          ),
          if (isCounterMode)
            Positioned(
              top: widget.counterPosition._top,
              bottom: widget.counterPosition._bottom,
              left: widget.counterPosition._left,
              right: widget.counterPosition._right,
              child: ValueListenableBuilder(
                valueListenable: _index,
                builder: (context, value, child) {
                  if (widget.counterBuilder != null) {
                    return widget.counterBuilder!(context, value);
                  }
                  return AndrossySlideCounter(
                    text: "${value + 1} / ${widget.itemCount}",
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class AndrossySlideCounter extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle style;
  final String text;

  const AndrossySlideCounter({
    super.key,
    required this.text,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.backgroundColor = Colors.black54,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.margin = const EdgeInsets.all(12),
    this.style = const TextStyle(fontSize: 12, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      padding: padding,
      margin: margin,
      child: Text(text, maxLines: 1, style: style),
    );
  }
}
