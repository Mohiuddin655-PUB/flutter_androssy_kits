import 'package:flutter/material.dart';

const kAndrossyShimmerDuration = Duration(milliseconds: 1500);

class AndrossyShimmer extends StatefulWidget {
  final Duration shimmerDuration;
  final Duration fadeDuration;
  final double fadeUpperBound;
  final double fadeLowerBound;
  final double fadeWeight;
  final Color baseColor;
  final Color highlightColor;
  final double loopCount;
  final Widget child;

  const AndrossyShimmer({
    super.key,
    required this.child,
    this.shimmerDuration = kAndrossyShimmerDuration,
    this.fadeUpperBound = 1.0,
    this.fadeLowerBound = 0.0,
    this.fadeWeight = 50.0,
    this.fadeDuration = kAndrossyShimmerDuration,
    this.baseColor = const Color(0x00E0E0E0),
    this.highlightColor = const Color(0x80F5F5F5),
    this.loopCount = double.infinity,
  });

  @override
  State<AndrossyShimmer> createState() => _AndrossyShimmerState();
}

class _AndrossyShimmerState extends State<AndrossyShimmer>
    with TickerProviderStateMixin {
  AnimationController? _shimmer;
  AnimationController? _fadeController;
  Animation<double>? _fader;
  late Gradient _gradient;

  @override
  void initState() {
    super.initState();
    _initFader();
    _initShimmer();
  }

  @override
  void didUpdateWidget(covariant AndrossyShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shimmerDuration != oldWidget.shimmerDuration ||
        widget.baseColor != oldWidget.baseColor ||
        widget.highlightColor != oldWidget.highlightColor) {
      if (_shimmer != null) _shimmer!.dispose();
      _shimmer = null;
      _initShimmer();
    }
    if (widget.fadeDuration != oldWidget.fadeDuration ||
        widget.fadeUpperBound != oldWidget.fadeUpperBound ||
        widget.fadeLowerBound != oldWidget.fadeLowerBound ||
        widget.fadeWeight != oldWidget.fadeWeight) {
      if (_fadeController != null) _fadeController!.dispose();
      _fadeController = null;
      _initFader();
    }
  }

  @override
  void dispose() {
    if (_isShimmer) _shimmer!.dispose();
    if (_isFader) _fadeController!.dispose();
    super.dispose();
  }

  void _initShimmer() {
    if (widget.shimmerDuration != Duration.zero) {
      _shimmer = AnimationController(
        duration: widget.shimmerDuration,
        vsync: this,
      )..repeat();

      _gradient = LinearGradient(
        colors: [
          widget.baseColor,
          widget.highlightColor,
          widget.baseColor,
        ],
        stops: const [
          0.1,
          0.3,
          0.4,
        ],
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
      );
    }
  }

  void _initFader() {
    if (widget.fadeDuration != Duration.zero) {
      _fadeController = AnimationController(
        duration: widget.fadeDuration,
        vsync: this,
      );
      _fader = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(
            begin: widget.fadeLowerBound,
            end: widget.fadeUpperBound,
          ),
          weight: widget.fadeWeight,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: widget.fadeUpperBound,
            end: widget.fadeLowerBound,
          ),
          weight: widget.fadeWeight,
        ),
      ]).animate(CurvedAnimation(
        parent: _fadeController!,
        curve: Curves.easeInOut,
      ));
      _fadeController!.repeat(reverse: true);
    }
  }

  bool get _isShimmer => _shimmer != null;

  bool get _isFader => _fadeController != null;

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (_isShimmer) {
      child = AnimatedBuilder(
        animation: _shimmer!,
        child: child,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return _gradient.createShader(
                Rect.fromLTWH(
                  -bounds.width + (bounds.width * 2) * _shimmer!.value,
                  0,
                  bounds.width * 2,
                  bounds.height,
                ),
              );
            },
            blendMode: BlendMode.srcATop,
            child: child,
          );
        },
      );
    }

    if (_isFader) {
      child = FadeTransition(opacity: _fader!, child: child);
    }

    return child;
  }
}
