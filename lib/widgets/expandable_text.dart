import 'package:flutter/material.dart';

class AndrossyExpandableText extends StatefulWidget {
  final Locale? locale;

  final Color? selectionColor;
  final String? semanticsLabel;
  final StrutStyle? strutStyle;

  final String data;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final TextScaler? textScaler;
  final TextStyle? style;
  final TextWidthBasis textWidthBasis;

  final int initial;
  final String expandedText;
  final String unexpandedText;
  final TextStyle? expandableStyle;
  final Duration duration;
  final Curve curve;

  const AndrossyExpandableText(
    this.data, {
    this.locale,
    this.selectionColor,
    this.semanticsLabel,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaler,
    this.style,
    this.textWidthBasis = TextWidthBasis.parent,
    super.key,
    this.initial = 50,
    this.expandedText = "...less",
    this.unexpandedText = "...more",
    this.expandableStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    this.duration = const Duration(microseconds: 250),
    this.curve = Curves.linear,
  }) : assert(initial >= 0, 'initial must not be negative');

  @override
  State<AndrossyExpandableText> createState() {
    return _AndrossyExpandableTextState();
  }
}

class _AndrossyExpandableTextState extends State<AndrossyExpandableText>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AndrossyExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration ||
        widget.curve != oldWidget.curve ||
        widget.initial != oldWidget.initial ||
        widget.data != oldWidget.data) {
      _disposeController();
      _controller = null;
      _animation = null;
      if (widget.data != oldWidget.data ||
          widget.initial != oldWidget.initial) {
        _expanded = false;
      }
      _init();
    }
  }

  int get _characterCount => widget.data.characters.length;

  int get _initialCount => widget.initial.clamp(0, _characterCount).toInt();

  Duration get _effectiveDuration {
    return widget.duration.isNegative ? Duration.zero : widget.duration;
  }

  void _init() {
    final duration = _effectiveDuration;
    if (_isExpansion && duration != Duration.zero) {
      _controller = AnimationController(
        duration: duration * _characterCount,
        lowerBound: (_initialCount / _characterCount).clamp(0.0, 1.0),
        vsync: this,
      );
      _animation = CurveTween(curve: widget.curve).animate(_controller!);
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _disposeController() {
    _controller?.dispose();
  }

  bool get _isExpansion => _characterCount > (_initialCount * 2);

  bool _expanded = false;

  Characters get text {
    if (!_isExpansion) return widget.data.characters;
    final chars = widget.data.characters;
    if (_animation != null) {
      final count = (_animation!.value.clamp(0, 1) * chars.length).round();
      return chars.take(count);
    }
    return chars.take(_expanded ? chars.length : _initialCount);
  }

  void _toggle() {
    if (!_isExpansion) return;
    if (_controller != null) {
      _expanded ? _controller!.reverse() : _controller!.forward();
    }
    _expanded = !_expanded;
    if (_controller == null) {
      setState(() {});
    }
  }

  Widget get _text {
    final extra = _expanded ? widget.expandedText : widget.unexpandedText;
    return Text.rich(
      TextSpan(
        text: text.toString(),
        children: _isExpansion &&
                extra.isNotEmpty &&
                !(_controller?.isAnimating ?? false)
            ? [TextSpan(text: extra, style: widget.expandableStyle)]
            : null,
      ),
      locale: widget.locale,
      selectionColor: widget.selectionColor,
      semanticsLabel: widget.semanticsLabel,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      textHeightBehavior: widget.textHeightBehavior,
      textScaler: widget.textScaler,
      textWidthBasis: widget.textWidthBasis,
      style: widget.style,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: _animation != null
          ? AnimatedBuilder(
              animation: _animation!,
              builder: (_, __) => _text,
            )
          : ColoredBox(color: Colors.transparent, child: _text),
    );
  }
}
