import 'dart:math';

import 'package:flutter/material.dart';

class AndrossyRatingIcon {
  const AndrossyRatingIcon({
    required this.full,
    required this.half,
    required this.empty,
  });

  final Widget full;

  final Widget half;

  final Widget empty;
}

class AndrossyRating extends StatefulWidget {
  const AndrossyRating({
    super.key,
    required AndrossyRatingIcon icon,
    this.onRatingChange,
    this.glowColor,
    this.maxRating,
    this.textDirection,
    this.unratedColor,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.glow = true,
    this.glowRadius = 2,
    this.ignoreGestures = false,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.minRating = 0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
  })  : _itemBuilder = null,
        _ratingWidget = icon;

  const AndrossyRating.builder({
    super.key,
    required IndexedWidgetBuilder itemBuilder,
    required this.onRatingChange,
    this.glowColor,
    this.maxRating,
    this.textDirection,
    this.unratedColor,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.glow = true,
    this.glowRadius = 2,
    this.ignoreGestures = false,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.minRating = 0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
  })  : _itemBuilder = itemBuilder,
        _ratingWidget = null;

  final ValueChanged<double>? onRatingChange;

  final Color? glowColor;

  final double? maxRating;

  final TextDirection? textDirection;

  final Color? unratedColor;

  final bool allowHalfRating;

  final Axis direction;

  final bool glow;

  final double glowRadius;

  final bool ignoreGestures;

  final double initialRating;

  final int itemCount;

  final EdgeInsetsGeometry itemPadding;

  final double itemSize;

  final double minRating;

  final bool tapOnlyMode;

  final bool updateOnDrag;

  final WrapAlignment wrapAlignment;

  final IndexedWidgetBuilder? _itemBuilder;
  final AndrossyRatingIcon? _ratingWidget;

  @override
  State<AndrossyRating> createState() => _AndrossyRatingState();
}

class _AndrossyRatingState extends State<AndrossyRating> {
  double _rating = 0.0;
  bool _isRTL = false;
  double iconRating = 0.0;

  late double _minRating, _maxRating;
  late final ValueNotifier<bool> _glow;

  @override
  void initState() {
    super.initState();
    _glow = ValueNotifier(false);
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(AndrossyRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = widget.textDirection ?? Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    iconRating = 0.0;

    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: textDirection,
        direction: widget.direction,
        children: List.generate(
          widget.itemCount,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    final ratingWidget = widget._ratingWidget;
    final item = widget._itemBuilder?.call(context, index);
    final ratingOffset = widget.allowHalfRating ? 0.5 : 1.0;

    Widget customRating;

    if (index >= _rating) {
      customRating = _NoRatingWidget(
        size: widget.itemSize,
        enableMask: ratingWidget == null,
        unratedColor: widget.unratedColor ?? Theme.of(context).disabledColor,
        child: ratingWidget?.empty ?? item!,
      );
    } else if (index >= _rating - ratingOffset && widget.allowHalfRating) {
      if (ratingWidget?.half == null) {
        customRating = _HalfRatingWidget(
          size: widget.itemSize,
          enableMask: ratingWidget == null,
          rtlMode: _isRTL,
          unratedColor: widget.unratedColor ?? Theme.of(context).disabledColor,
          child: item!,
        );
      } else {
        customRating = SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: ratingWidget!.half,
                  )
                : ratingWidget!.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      customRating = SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: FittedBox(
          fit: BoxFit.contain,
          child: ratingWidget?.full ?? item,
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTapDown: (details) {
          double value;
          if (index == 0 && (_rating == 1 || _rating == 0.5)) {
            value = 0;
          } else {
            final tappedPosition = details.localPosition.dx;
            final tappedOnFirstHalf = tappedPosition <= widget.itemSize / 2;
            value = index +
                (tappedOnFirstHalf && widget.allowHalfRating ? 0.5 : 1.0);
          }

          value = max(value, widget.minRating);
          if (widget.onRatingChange != null) widget.onRatingChange?.call(value);
          _rating = value;
          setState(() {});
        },
        onHorizontalDragStart: _isHorizontal ? _onDragStart : null,
        onHorizontalDragEnd: _isHorizontal ? _onDragEnd : null,
        onHorizontalDragUpdate: _isHorizontal ? _onDragUpdate : null,
        onVerticalDragStart: _isHorizontal ? null : _onDragStart,
        onVerticalDragEnd: _isHorizontal ? null : _onDragEnd,
        onVerticalDragUpdate: _isHorizontal ? null : _onDragUpdate,
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder<bool>(
            valueListenable: _glow,
            builder: (context, glow, child) {
              if (glow && widget.glow) {
                final glowColor =
                    widget.glowColor ?? Theme.of(context).colorScheme.secondary;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: child,
                );
              }
              return child!;
            },
            child: customRating,
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => widget.direction == Axis.horizontal;

  void _onDragUpdate(DragUpdateDetails dragDetails) {
    if (!widget.tapOnlyMode) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (widget.direction == Axis.horizontal) {
        i = pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      } else {
        i = pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      }
      var currentRating = widget.allowHalfRating ? i : i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget.direction == Axis.horizontal) {
        currentRating = widget.itemCount - currentRating;
      }

      _rating = currentRating.clamp(_minRating, _maxRating);
      if (widget.updateOnDrag && widget.onRatingChange != null) {
        widget.onRatingChange!(iconRating);
      }
      setState(() {});
    }
  }

  void _onDragStart(DragStartDetails details) {
    _glow.value = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _glow.value = false;
    if (widget.onRatingChange != null) widget.onRatingChange!(iconRating);
    iconRating = 0.0;
  }
}

class _HalfRatingWidget extends StatelessWidget {
  const _HalfRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.rtlMode,
    required this.unratedColor,
  });

  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingWidget(
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                    child: child,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              fit: BoxFit.contain,
              child: child,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  _HalfClipper({required this.rtlMode});

  final bool rtlMode;

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _NoRatingWidget extends StatelessWidget {
  const _NoRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.unratedColor,
  });

  final double size;
  final Widget child;
  final bool enableMask;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  unratedColor,
                  BlendMode.srcIn,
                ),
                child: child,
              )
            : child,
      ),
    );
  }
}
