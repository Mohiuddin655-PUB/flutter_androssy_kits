import 'package:flutter/material.dart';

typedef AndrossySwipeCallback = void Function(AxisDirection direction);

class AndrossySwiper extends StatefulWidget {
  final AndrossySwipeConfig swipeConfig;
  final HitTestBehavior behavior;
  final AndrossySwipeCallback? onVerticalSwipe;
  final AndrossySwipeCallback? onHorizontalSwipe;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Widget child;

  const AndrossySwiper({
    super.key,
    this.swipeConfig = const AndrossySwipeConfig(),
    this.behavior = HitTestBehavior.deferToChild,
    this.onVerticalSwipe,
    this.onHorizontalSwipe,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    required this.child,
  });

  @override
  State<AndrossySwiper> createState() => _AndrossySwiperState();
}

class _AndrossySwiperState extends State<AndrossySwiper> {
  Offset? _initialSwipeOffset;
  Offset? _finalSwipeOffset;
  AxisDirection? _previousDirection;

  void _onVerticalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;

    if (widget.swipeConfig.swipeDetectionBehavior ==
        AndrossySwipeDetectionBehavior.singularOnEnd) {
      return;
    }

    final initialOffset = _initialSwipeOffset;
    final finalOffset = _finalSwipeOffset;

    if (initialOffset != null && finalOffset != null) {
      final offsetDifference = initialOffset.dy - finalOffset.dy;

      if (offsetDifference.abs() > widget.swipeConfig.verticalThreshold) {
        _initialSwipeOffset = widget.swipeConfig.swipeDetectionBehavior ==
                AndrossySwipeDetectionBehavior.singular
            ? null
            : _finalSwipeOffset;

        final direction =
            offsetDifference > 0 ? AxisDirection.up : AxisDirection.down;

        if (widget.swipeConfig.swipeDetectionBehavior ==
                AndrossySwipeDetectionBehavior.continuous ||
            _previousDirection == null ||
            direction != _previousDirection) {
          _previousDirection = direction;
          widget.onVerticalSwipe!(direction);
        }
      }
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (widget.swipeConfig.swipeDetectionBehavior ==
        AndrossySwipeDetectionBehavior.singularOnEnd) {
      final initialOffset = _initialSwipeOffset;
      final finalOffset = _finalSwipeOffset;

      if (initialOffset != null && finalOffset != null) {
        final offsetDifference = initialOffset.dy - finalOffset.dy;

        if (offsetDifference.abs() > widget.swipeConfig.verticalThreshold) {
          final direction =
              offsetDifference > 0 ? AxisDirection.up : AxisDirection.down;
          widget.onVerticalSwipe!(direction);
        }
      }
    }

    _initialSwipeOffset = null;
    _previousDirection = null;
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;

    if (widget.swipeConfig.swipeDetectionBehavior ==
        AndrossySwipeDetectionBehavior.singularOnEnd) {
      return;
    }

    final initialOffset = _initialSwipeOffset;
    final finalOffset = _finalSwipeOffset;

    if (initialOffset != null && finalOffset != null) {
      final offsetDifference = initialOffset.dx - finalOffset.dx;

      if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
        _initialSwipeOffset = widget.swipeConfig.swipeDetectionBehavior ==
                AndrossySwipeDetectionBehavior.singular
            ? null
            : _finalSwipeOffset;

        final direction =
            offsetDifference > 0 ? AxisDirection.left : AxisDirection.right;

        if (widget.swipeConfig.swipeDetectionBehavior ==
                AndrossySwipeDetectionBehavior.continuous ||
            _previousDirection == null ||
            direction != _previousDirection) {
          _previousDirection = direction;
          widget.onHorizontalSwipe!(direction);
        }
      }
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (widget.swipeConfig.swipeDetectionBehavior ==
        AndrossySwipeDetectionBehavior.singularOnEnd) {
      final initialOffset = _initialSwipeOffset;
      final finalOffset = _finalSwipeOffset;

      if (initialOffset != null && finalOffset != null) {
        final offsetDifference = initialOffset.dx - finalOffset.dx;

        if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
          final direction =
              offsetDifference > 0 ? AxisDirection.left : AxisDirection.right;
          widget.onHorizontalSwipe!(direction);
        }
      }
    }

    _initialSwipeOffset = null;
    _previousDirection = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onDoubleTap: widget.onDoubleTap,
      onVerticalDragStart:
          widget.onVerticalSwipe != null ? _onVerticalDragStart : null,
      onVerticalDragUpdate:
          widget.onVerticalSwipe != null ? _onVerticalDragUpdate : null,
      onVerticalDragEnd:
          widget.onVerticalSwipe != null ? _onVerticalDragEnd : null,
      onHorizontalDragStart:
          widget.onHorizontalSwipe != null ? _onHorizontalDragStart : null,
      onHorizontalDragUpdate:
          widget.onHorizontalSwipe != null ? _onHorizontalDragUpdate : null,
      onHorizontalDragEnd:
          widget.onHorizontalSwipe != null ? _onHorizontalDragEnd : null,
      child: widget.child,
    );
  }
}

enum AndrossySwipeDetectionBehavior {
  singular,
  singularOnEnd,
  continuous,
  continuousDistinct,
}

class AndrossySwipeConfig {
  final double verticalThreshold;

  final double horizontalThreshold;

  final AndrossySwipeDetectionBehavior swipeDetectionBehavior;

  const AndrossySwipeConfig({
    this.verticalThreshold = 50.0,
    this.horizontalThreshold = 50.0,
    this.swipeDetectionBehavior = AndrossySwipeDetectionBehavior.singularOnEnd,
  });
}
