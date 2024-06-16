import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';

typedef OnViewClickListener = void Function(BuildContext context);

class AndrossyView extends StatelessWidget {
  // ANIMATION
  final int animation;
  final Curve animationCurve;

  // BACKDROP
  final ImageFilter? backdropFilter;
  final BlendMode? backdropMode;

  // DECORATION
  final Color? color;
  final BoxDecoration? decoration;
  final ShapeBorder? decorationShape;
  final BoxDecoration? foregroundDecoration;
  final ShapeBorder? foregroundDecorationShape;

  // CLIPPER
  final CustomClipper? clipper;
  final Clip? clipBehavior;
  final AndrossyPainterConfig? clipConfig;

  // DIMENSION
  final double? aspectRatio;
  final int? flex;

  // OPACITY AND VISIBILITY
  final double? opacity;
  final bool opacityAlwaysIncludeSemantics;
  final bool visibility;

  // PAINTER
  final CustomPainter? painter;
  final AndrossyPainterConfig? painterConfig;

  // POINTER
  final bool absorbPointer;
  final bool ignorePointer;

  // POSITION
  final Alignment? alignment;
  final ViewPosition? position;
  final ViewPositionType? positionType;

  // RENDER
  final void Function(Size)? onRenderedSize;

  // SHADER
  final BlendMode shaderBlendMode;
  final ShaderCallback? shaderCallback;
  final Gradient? shaderGradient;

  // SHADOW
  final List<BoxShadow>? shadows;

  // SIZE
  final BoxConstraints? constraints;
  final double? width;
  final double? height;

  // SPACER
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  // TRANSFORM
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  // GESTURE
  final double elevation;
  final bool enabled;
  final bool haptic;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? splashColor;
  final GestureClickEffect? clickEffect;
  final OnAndrossyGestureClickListener? onClick;
  final OnAndrossyGestureClickListener? onDoubleClick;
  final OnAndrossyGestureClickListener? onLongClick;
  final void Function(bool status)? onHover;

  // BASE
  final Widget? child;

  const AndrossyView({
    super.key,
    // ANIMATION
    this.animation = 0,
    this.animationCurve = Curves.linear,
    // BACKDROP
    this.backdropFilter,
    this.backdropMode,
    // DECORATION
    this.color,
    this.decoration,
    this.decorationShape,
    this.foregroundDecoration,
    this.foregroundDecorationShape,
    // CLIPPER
    this.clipper,
    this.clipConfig,
    this.clipBehavior,
    // DIMENSION
    this.aspectRatio,
    this.flex,
    // OPACITY AND VISIBILITY
    this.opacity,
    this.opacityAlwaysIncludeSemantics = false,
    this.visibility = true,
    // PAINTER
    this.painter,
    this.painterConfig,
    // POINTER
    this.absorbPointer = false,
    this.ignorePointer = false,
    // POSITION
    this.alignment,
    this.position,
    this.positionType,
    // RENDER
    this.onRenderedSize,
    // SHADER
    this.shaderBlendMode = BlendMode.modulate,
    this.shaderCallback,
    this.shaderGradient,
    // SHADOW
    this.shadows,
    // SIZE
    this.constraints,
    this.height,
    this.width,
    // SPACER
    this.margin,
    this.padding,
    // TRANSFORM
    this.transform,
    this.transformAlignment,
    // GESTURE
    this.elevation = 0,
    this.enabled = true,
    this.haptic = true,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.clickEffect,
    this.onClick,
    this.onDoubleClick,
    this.onLongClick,
    this.onHover,

    // BASE
    this.child,
  });

  /// ALIGNMENT
  Alignment? get _alignment {
    return _height != null ? alignment ?? Alignment.center : alignment;
  }

  /// PADDING
  EdgeInsetsGeometry? get _padding => padding;

  /// SIZED_BOX
  double? get _width => width;

  double? get _height => height;

  Color? get _color => _decoration == null ? color : null;

  /// BOX_DECORATION
  Decoration? get _decoration {
    if (_painter != null) return null;
    if (decorationShape != null) {
      return ShapeDecoration(
        shape: decorationShape!,
        color: decoration?.color ?? color,
        image: decoration?.image,
        gradient: decoration?.gradient,
        shadows: decoration?.boxShadow,
      );
    }
    return decoration;
  }

  Decoration? get _foregroundDecoration {
    if (_painter != null) return null;
    if (foregroundDecorationShape != null) {
      return ShapeDecoration(
        shape: foregroundDecorationShape!,
        color: foregroundDecoration?.color ?? color,
        image: foregroundDecoration?.image,
        gradient: foregroundDecoration?.gradient,
        shadows: foregroundDecoration?.boxShadow,
      );
    }
    return foregroundDecoration;
  }

  /// CONSTRAINED_BOX
  BoxConstraints? get _constraints {
    return constraints;
  }

  /// PADDING AS MARGIN
  EdgeInsetsGeometry? get _margin => margin;

  /// TRANSFORM
  Matrix4? get _transform {
    return transform;
  }

  /// PAINTER
  CustomPainter? get _painter {
    if (painter != null) return painter;
    if (painterConfig != null) {
      final config = painterConfig;
      if (config is AndrossyStarConfig) {
        return AndrossyStarPainter(config: config);
      } else if (config is AndrossyDockConfig) {
        return AndrossyDockPainter(config: config);
      }
    }
    return painter;
  }

  /// CLIPPER
  CustomClipper? get _clipper {
    if (clipper != null) return clipper;
    if (clipConfig != null) {
      final config = clipConfig;
      if (config is AndrossyStarConfig) {
        return AndrossyStarClipper(config: config);
      } else if (config is AndrossyDockConfig) {
        return AndrossyDockClipper(config: config);
      }
    }
    return clipper;
  }

  ImageFilter? get _backdropFilter => backdropFilter;

  Clip? get _clipBehavior => backdropFilter != null ? null : clipBehavior;

  /// ASPECT RATION
  double? get _aspectRatio => aspectRatio;

  /// EXPANDED
  int? get _flex => flex;

  /// POSITION
  ViewPosition? get _position => position ?? positionType?.position;

  /// GESTURE

  bool get _inkwell {
    return highlightColor != null || hoverColor != null || splashColor != null;
  }

  Color? get _background => decoration?.color;

  BorderRadiusGeometry? get _borderRadius => decoration?.borderRadius;

  Widget attach(BuildContext context) => child ?? const SizedBox.shrink();

  ViewTheme defaultTheme(BuildContext context) => const ViewTheme();

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();
    final theme = defaultTheme(context);

    Widget child = attach(context);

    if (shaderCallback != null || shaderGradient != null) {
      child = ShaderMask(
        blendMode: shaderBlendMode,
        shaderCallback: (bounds) {
          if (shaderCallback != null) {
            return shaderCallback!(bounds);
          }
          return shaderGradient!.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: child,
      );
    }

    if (_alignment != null ||
        _clipBehavior != null ||
        _constraints != null ||
        _decoration != null ||
        _foregroundDecoration != null ||
        _height != null ||
        _padding != null ||
        _width != null ||
        theme.alignment != null ||
        theme.constraints != null ||
        theme.decoration != null ||
        theme.padding != null ||
        theme.height != null ||
        theme.width != null) {
      if (animation > 0) {
        child = AnimatedContainer(
          duration: Duration(milliseconds: animation),
          alignment: _alignment ?? theme.alignment,
          clipBehavior: _clipBehavior ?? Clip.none,
          color: _color,
          constraints: _constraints ?? theme.constraints,
          curve: animationCurve,
          decoration: _decoration ?? theme.decoration,
          foregroundDecoration: _foregroundDecoration,
          height: height ?? theme.height,
          padding: _padding ?? theme.padding,
          transformAlignment: transformAlignment,
          width: width ?? theme.width,
          child: child,
        );
      } else {
        child = Container(
          alignment: _alignment ?? theme.alignment,
          clipBehavior: _clipBehavior ?? Clip.none,
          color: _color,
          constraints: _constraints ?? theme.constraints,
          decoration: _decoration ?? theme.decoration,
          foregroundDecoration: _foregroundDecoration,
          height: height ?? theme.height,
          padding: _padding ?? theme.padding,
          transformAlignment: transformAlignment,
          width: width ?? theme.width,
          child: child,
        );
      }
    }

    if (_painter != null) {
      child = CustomPaint(
        painter: _painter,
        child: child,
      );
    }

    if (_backdropFilter != null) {
      child = BackdropFilter(
        filter: _backdropFilter!,
        blendMode: backdropMode ?? BlendMode.srcOver,
        child: child,
      );
    }

    /// BACKDROP FILTER
    if (_clipper != null || _backdropFilter != null) {
      final clipper = _clipper;
      if (clipper is CustomClipper<Rect>) {
        child = ClipRect(
          clipper: clipper,
          child: child,
        );
      } else {
        child = ClipPath(
          clipper: clipper is CustomClipper<Path> ? clipper : null,
          child: child,
        );
      }
    }

    if (_transform != null) {
      child = Transform(
        transform: _transform!,
        alignment: transformAlignment,
        child: child,
      );
    }

    if (_margin != null) {
      child = Padding(
        padding: _margin!,
        child: child,
      );
    }

    /// RENDERER
    if (onRenderedSize != null) {
      child = AndrossyRender(
        render: onRenderedSize!,
        child: child,
      );
    }

    /// OPACITY
    if (opacity != null && opacity! > 0) {
      child = Opacity(
        opacity: opacity ?? 0,
        alwaysIncludeSemantics: opacityAlwaysIncludeSemantics,
        child: child,
      );
    }

    /// ABSORBER
    if (absorbPointer && !ignorePointer) {
      child = AbsorbPointer(child: child);
    }

    /// IGNORE
    if (ignorePointer) {
      child = IgnorePointer(child: child);
    }

    /// CALLBACKS
    if (onClick != null || onDoubleClick != null || onLongClick != null) {
      final td = theme.decoration;
      child = AndrossyGesture(
        margin: _inkwell ? margin : null,
        background: _inkwell ? _background ?? td?.color : null,
        borderRadius: _inkwell ? _borderRadius ?? td?.borderRadius : null,
        shape: _inkwell ? decorationShape : null,
        clipBehavior: _clipBehavior,
        elevation: elevation,
        enabled: enabled,
        haptic: haptic,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        splashColor: splashColor,
        clickEffect: clickEffect,
        onClick: onClick,
        onDoubleClick: onDoubleClick,
        onLongClick: onLongClick,
        onHover: onHover,
        child: child,
      );
    }

    /// DIMENSION
    if (_aspectRatio != null && _aspectRatio! > 0) {
      child = AspectRatio(
        aspectRatio: _aspectRatio!,
        child: child,
      );
    }

    /// EXPENDABLE
    if (_flex != null && _flex! > 0) {
      child = Expanded(
        flex: _flex!,
        child: child,
      );
    }

    /// POSITION
    if (_position != null) {
      child = Positioned(
        top: _position?.top,
        bottom: _position?.bottom,
        left: _position?.left,
        right: _position?.right,
        child: child,
      );
    }

    return child;
  }
}

class ViewTheme {
  final Alignment? alignment;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const ViewTheme({
    this.alignment,
    this.decoration,
    this.constraints,
    this.padding,
    this.height,
    this.width,
  });
}

enum ViewScrollingType {
  always(physics: AlwaysScrollableScrollPhysics()),
  bouncing(physics: BouncingScrollPhysics()),
  clamping(physics: ClampingScrollPhysics()),
  fixed(physics: FixedExtentScrollPhysics()),
  never(physics: NeverScrollableScrollPhysics()),
  page(physics: PageScrollPhysics()),
  range(physics: RangeMaintainingScrollPhysics()),
  none;

  final ScrollPhysics? physics;

  const ViewScrollingType({this.physics});
}

enum ViewPainterType { none, dottedBorder, gradientBorder }

class ViewPosition {
  final double? top, bottom, left, right;

  const ViewPosition({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });
}

enum ViewPositionType {
  /// Left positions
  left(ViewPosition(left: 0)),
  leftTop(ViewPosition(left: 0, top: 0)),
  leftBottom(ViewPosition(left: 0, bottom: 0)),
  leftFlex(ViewPosition(left: 0, top: 0, bottom: 0)),

  /// Right positions
  right(ViewPosition(right: 0)),
  rightTop(ViewPosition(right: 0, top: 0)),
  rightBottom(ViewPosition(right: 0, bottom: 0)),
  rightFlex(ViewPosition(right: 0, top: 0, bottom: 0)),

  /// Top positions
  top(ViewPosition(top: 0)),
  topLeft(ViewPosition(top: 0, left: 0)),
  topRight(ViewPosition(top: 0, right: 0)),
  topFlex(ViewPosition(top: 0, left: 0, right: 0)),

  /// Bottom positions
  bottom(ViewPosition(bottom: 0)),
  bottomLeft(ViewPosition(bottom: 0, left: 0)),
  bottomRight(ViewPosition(bottom: 0, right: 0)),
  bottomFlex(ViewPosition(bottom: 0, left: 0, right: 0)),

  /// Center positions
  center,
  centerFlexX(ViewPosition(left: 0, right: 0)),
  centerFlexY(ViewPosition(top: 0, bottom: 0)),
  centerFill(ViewPosition(left: 0, right: 0, top: 0, bottom: 0));

  final ViewPosition position;

  const ViewPositionType([
    this.position = const ViewPosition(),
  ]);

  /// Left positions
  bool get isLeft => this == ViewPositionType.left;

  bool get isLeftTop => this == ViewPositionType.leftTop;

  bool get isLeftBottom => this == ViewPositionType.leftBottom;

  bool get isLeftFlex => this == ViewPositionType.leftFlex;

  bool get isLeftMode {
    return isLeft || isLeftTop || isLeftBottom || isLeftFlex;
  }

  /// Right positions
  bool get isRight => this == ViewPositionType.right;

  bool get isRightTop => this == ViewPositionType.rightTop;

  bool get isRightBottom => this == ViewPositionType.rightBottom;

  bool get isRightFlex => this == ViewPositionType.rightFlex;

  bool get isRightMode {
    return isRight || isRightTop || isRightBottom || isRightFlex;
  }

  bool get isXMode => isLeftMode || isRightMode;

  /// Top positions
  bool get isTop => this == ViewPositionType.top;

  bool get isTopLeft => this == ViewPositionType.topLeft;

  bool get isTopRight => this == ViewPositionType.topRight;

  bool get isTopFlex => this == ViewPositionType.topFlex;

  bool get isTopMode {
    return isTop || isTopLeft || isTopRight || isTopFlex;
  }

  /// Bottom positions
  bool get isBottom => this == ViewPositionType.bottom;

  bool get isBottomLeft => this == ViewPositionType.bottomLeft;

  bool get isBottomRight => this == ViewPositionType.bottomRight;

  bool get isBottomFlex => this == ViewPositionType.bottomFlex;

  bool get isBottomMode {
    return isBottom || isBottomLeft || isBottomRight || isBottomFlex;
  }

  bool get isYMode => isTopMode || isBottomMode;

  /// Center positions
  bool get isCenter => this == ViewPositionType.center;

  bool get isCenterFlexX => this == ViewPositionType.centerFlexX;

  bool get isCenterFlexY => this == ViewPositionType.centerFlexY;

  bool get isCenterFill => this == ViewPositionType.centerFill;

  bool get isCenterMode {
    return isCenter || isCenterFlexX || isCenterFlexY || isCenterFill;
  }
}
