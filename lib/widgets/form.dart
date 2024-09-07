import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'field.dart';

class AndrossyForm extends StatefulWidget {
  final AndrossyFormController controller;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final List<Widget> children;

  /// CHILDREN PROPERTIES
  /// FIELD PROPERTIES
  final Curve? animationCurve;
  final Duration? animationDuration;
  final AndrossyFieldProperty<Color?>? backgroundColor;
  final AndrossyFieldProperty<Color?>? borderColor;
  final AndrossyFieldProperty<BorderRadius?>? borderRadius;
  final AndrossyFieldTweenProperty<double?>? borderWidth;
  final BoxConstraints? constraints;
  final EdgeInsets? contentPadding;
  final AndrossyFieldProperty<TextStyle?>? counterStyle;
  final FloatingVisibility? counterVisibility;
  final AndrossyFieldProperty<BoxDecoration?>? decoration;
  final AndrossyFieldProperty<double?>? drawableEndSize;
  final AndrossyFieldProperty<double?>? drawableEndPadding;
  final AndrossyFieldProperty<Color?>? drawableEndTint;
  final AndrossyFieldProperty<double?>? drawableStartSize;
  final AndrossyFieldProperty<double?>? drawableStartPadding;
  final AndrossyFieldProperty<Color?>? drawableStartTint;
  final Color? errorColor;
  final AndrossyFieldProperty<TextStyle?>? errorStyle;
  final Alignment? floatingAlignment;
  final EdgeInsets? floatingPadding;
  final AndrossyFieldProperty<TextStyle?>? floatingStyle;
  final FloatingVisibility? floatingVisibility;
  final FocusNode? focusNode;
  final AndrossyFieldProperty<TextStyle?>? footerStyle;
  final FloatingVisibility? footerVisibility;
  final AndrossyFieldProperty<TextStyle?>? helperStyle;
  final Color? hintColor;
  final double? indicatorSize;
  final double? indicatorStrokeWidth;
  final AndrossyFieldProperty<Color?>? indicatorStrokeBackground;
  final AndrossyFieldProperty<Color?>? indicatorStrokeColor;
  final Color? primaryColor;
  final Color? secondaryColor;
  final StrutStyle? strutStyle;
  final AndrossyFieldProperty<Color?>? underlineColor;
  final AndrossyFieldProperty<double?>? underlineHeight;

  /// TEXT FIELD PROPERTIES
  final Clip? clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final AndrossyFieldContextMenuBuilder? contextMenuBuilder;
  final AndrossyFieldProperty<Color>? cursorColor;
  final double? cursorHeight;
  final bool? cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double? cursorWidth;
  final DragStartBehavior? dragStartBehavior;
  final bool? enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
  final bool? enableSuggestions;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final MouseCursor? mouseCursor;
  final String? obscuringCharacter;
  final bool? scribbleEnabled;
  final EdgeInsets? scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final BoxHeightStyle? selectionHeightStyle;
  final BoxWidthStyle? selectionWidthStyle;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextCapitalization? textCapitalization;
  final Brightness? keyboardAppearance;

  AndrossyForm({
    super.key,
    AndrossyFormController? controller,
    int? initialCheckTime,
    OnAndrossyFieldValid? onValid,
    this.children = const [],
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,

    /// FIELD PROPERTIES
    this.animationCurve,
    this.animationDuration,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.constraints,
    this.contentPadding,
    this.counterStyle,
    this.counterVisibility,
    this.decoration,
    this.drawableEndSize,
    this.drawableEndPadding,
    this.drawableEndTint,
    this.drawableStartSize,
    this.drawableStartPadding,
    this.drawableStartTint,
    this.errorColor,
    this.errorStyle,
    this.floatingAlignment,
    this.floatingPadding,
    this.floatingStyle,
    this.floatingVisibility,
    this.focusNode,
    this.footerStyle,
    this.footerVisibility,
    this.helperStyle,
    this.hintColor,
    this.indicatorSize,
    this.indicatorStrokeWidth,
    this.indicatorStrokeBackground,
    this.indicatorStrokeColor,
    this.primaryColor,
    this.secondaryColor,
    this.strutStyle,
    this.underlineColor,
    this.underlineHeight,

    /// TEXT FIELD PROPERTIES
    this.clipBehavior,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.cursorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth,
    this.dragStartBehavior,
    this.enableIMEPersonalizedLearning,
    this.enableInteractiveSelection,
    this.enableSuggestions,
    this.magnifierConfiguration,
    this.mouseCursor,
    this.obscuringCharacter,
    this.scribbleEnabled,
    this.scrollPadding,
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.style,
    this.textAlign,
    this.textCapitalization,
    this.keyboardAppearance,
  }) : controller = (controller ?? AndrossyFormController())._(
          initialCheckTime: initialCheckTime,
          valid: onValid,
          children: _extract(children),
        );

  AndrossyForm copyWith({
    AndrossyFormController? controller,
    Axis? direction,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextBaseline? textBaseline,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    List<Widget>? children,

    /// CHILDREN PROPERTIES
    /// FIELD PROPERTIES
    Curve? animationCurve,
    Duration? animationDuration,
    AndrossyFieldProperty<Color?>? backgroundColor,
    AndrossyFieldProperty<Color?>? borderColor,
    AndrossyFieldProperty<BorderRadius?>? borderRadius,
    AndrossyFieldTweenProperty<double?>? borderWidth,
    BoxConstraints? constraints,
    EdgeInsets? contentPadding,
    AndrossyFieldProperty<TextStyle?>? counterStyle,
    FloatingVisibility? counterVisibility,
    AndrossyFieldProperty<BoxDecoration?>? decoration,
    AndrossyFieldProperty<double?>? drawableEndSize,
    AndrossyFieldProperty<double?>? drawableEndPadding,
    AndrossyFieldProperty<Color?>? drawableEndTint,
    AndrossyFieldProperty<double?>? drawableStartSize,
    AndrossyFieldProperty<double?>? drawableStartPadding,
    AndrossyFieldProperty<Color?>? drawableStartTint,
    Color? errorColor,
    AndrossyFieldProperty<TextStyle?>? errorStyle,
    Alignment? floatingAlignment,
    EdgeInsets? floatingPadding,
    AndrossyFieldProperty<TextStyle?>? floatingStyle,
    FloatingVisibility? floatingVisibility,
    FocusNode? focusNode,
    AndrossyFieldProperty<TextStyle?>? footerStyle,
    FloatingVisibility? footerVisibility,
    AndrossyFieldProperty<TextStyle?>? helperStyle,
    Color? hintColor,
    double? indicatorSize,
    double? indicatorStrokeWidth,
    AndrossyFieldProperty<Color?>? indicatorStrokeBackground,
    AndrossyFieldProperty<Color?>? indicatorStrokeColor,
    Color? primaryColor,
    Color? secondaryColor,
    StrutStyle? strutStyle,
    AndrossyFieldProperty<Color?>? underlineColor,
    AndrossyFieldProperty<double?>? underlineHeight,

    /// TEXT FIELD PROPERTIES
    Clip? clipBehavior,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    AndrossyFieldContextMenuBuilder? contextMenuBuilder,
    AndrossyFieldProperty<Color>? cursorColor,
    double? cursorHeight,
    bool? cursorOpacityAnimates,
    Radius? cursorRadius,
    double? cursorWidth,
    DragStartBehavior? dragStartBehavior,
    bool? enableIMEPersonalizedLearning,
    bool? enableInteractiveSelection,
    bool? enableSuggestions,
    TextMagnifierConfiguration? magnifierConfiguration,
    MouseCursor? mouseCursor,
    String? obscuringCharacter,
    bool? scribbleEnabled,
    EdgeInsets? scrollPadding,
    ScrollPhysics? scrollPhysics,
    TextSelectionControls? selectionControls,
    BoxHeightStyle? selectionHeightStyle,
    BoxWidthStyle? selectionWidthStyle,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextStyle? style,
    TextAlign? textAlign,
    TextCapitalization? textCapitalization,
    Brightness? keyboardAppearance,
  }) {
    return AndrossyForm(
      controller: controller ?? this.controller,
      direction: direction ?? this.direction,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      textBaseline: textBaseline ?? this.textBaseline,
      textDirection: textDirection ?? this.textDirection,
      verticalDirection: verticalDirection ?? this.verticalDirection,

      /// FIELD PROPERTIES
      animationCurve: animationCurve ?? this.animationCurve,
      animationDuration: animationDuration ?? this.animationDuration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      constraints: constraints ?? this.constraints,
      contentPadding: contentPadding ?? this.contentPadding,
      counterStyle: counterStyle ?? this.counterStyle,
      counterVisibility: counterVisibility ?? this.counterVisibility,
      decoration: decoration ?? this.decoration,
      drawableEndSize: drawableEndSize ?? this.drawableEndSize,
      drawableEndPadding: drawableEndPadding ?? this.drawableEndPadding,
      drawableEndTint: drawableEndTint ?? this.drawableEndTint,
      drawableStartSize: drawableStartSize ?? this.drawableStartSize,
      drawableStartPadding: drawableStartPadding ?? this.drawableStartPadding,
      drawableStartTint: drawableStartTint ?? this.drawableStartTint,
      errorColor: errorColor ?? this.errorColor,
      errorStyle: errorStyle ?? this.errorStyle,
      floatingAlignment: floatingAlignment ?? this.floatingAlignment,
      floatingPadding: floatingPadding ?? this.floatingPadding,
      floatingStyle: floatingStyle ?? this.floatingStyle,
      floatingVisibility: floatingVisibility ?? this.floatingVisibility,
      focusNode: focusNode ?? this.focusNode,
      footerStyle: footerStyle ?? this.footerStyle,
      footerVisibility: footerVisibility ?? this.footerVisibility,
      helperStyle: helperStyle ?? this.helperStyle,
      hintColor: hintColor ?? this.hintColor,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorStrokeWidth: indicatorStrokeWidth ?? this.indicatorStrokeWidth,
      indicatorStrokeBackground:
          indicatorStrokeBackground ?? this.indicatorStrokeBackground,
      indicatorStrokeColor: indicatorStrokeColor ?? this.indicatorStrokeColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      strutStyle: strutStyle ?? this.strutStyle,
      underlineColor: underlineColor ?? this.underlineColor,
      underlineHeight: underlineHeight ?? this.underlineHeight,

      /// TEXT FIELD PROPERTIES
      clipBehavior: clipBehavior ?? this.clipBehavior,
      contentInsertionConfiguration:
          contentInsertionConfiguration ?? this.contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder ?? this.contextMenuBuilder,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      scribbleEnabled: scribbleEnabled ?? this.scribbleEnabled,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      selectionControls: selectionControls ?? this.selectionControls,
      selectionHeightStyle: selectionHeightStyle ?? this.selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle ?? this.selectionWidthStyle,
      smartDashesType: smartDashesType ?? this.smartDashesType,
      smartQuotesType: smartQuotesType ?? this.smartQuotesType,
      spellCheckConfiguration:
          spellCheckConfiguration ?? this.spellCheckConfiguration,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      children: children ?? this.children,
    );
  }

  static List<Widget> _extract(List<Widget> widgets) {
    List<Widget> children = [];

    void lookup(Widget? widget) {
      if (widget == null) return;
      if (widget is AndrossyField &&
          widget.key is GlobalKey<AndrossyFieldState> &&
          widget.onValidator != null) {
        children.add(widget);
      } else if (widget is AndrossyForm) {
        children.add(widget);
      } else if (widget is MultiChildRenderObjectWidget) {
        for (var child in widget.children) {
          lookup(child);
        }
      } else if (widget is SingleChildRenderObjectWidget) {
        lookup(widget.child);
      } else if (widget is ProxyWidget) {
        lookup(widget.child);
      } else if (widget is Container) {
        lookup(widget.child);
      }
    }

    for (var widget in widgets) {
      lookup(widget);
    }

    return children;
  }

  @override
  State<AndrossyForm> createState() => AndrossyFormState();
}

class AndrossyFormState extends State<AndrossyForm> {
  late final controller = widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller._config());
  }

  @override
  Widget build(BuildContext context) {
    return widget.direction == Axis.vertical
        ? Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            crossAxisAlignment: widget.crossAxisAlignment,
            textBaseline: widget.textBaseline,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: _children,
          )
        : Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            crossAxisAlignment: widget.crossAxisAlignment,
            textBaseline: widget.textBaseline,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: _children,
          );
  }

  List<Widget> get _children {
    return widget.children.map((e) {
      return _lookup(e, (field) {
        return field.defaultWith(
          /// FIELD PROPERTIES
          animationCurve: widget.animationCurve,
          animationDuration: widget.animationDuration,
          backgroundColor: widget.backgroundColor,
          borderColor: widget.borderColor,
          borderRadius: widget.borderRadius,
          borderWidth: widget.borderWidth,
          constraints: widget.constraints,
          contentPadding: widget.contentPadding,
          counterStyle: widget.counterStyle,
          counterVisibility: widget.counterVisibility,
          decoration: widget.decoration,
          drawableEndSize: widget.drawableEndSize,
          drawableEndPadding: widget.drawableEndPadding,
          drawableEndTint: widget.drawableEndTint,
          drawableStartSize: widget.drawableStartSize,
          drawableStartPadding: widget.drawableStartPadding,
          drawableStartTint: widget.drawableStartTint,
          errorColor: widget.errorColor,
          errorStyle: widget.errorStyle,
          floatingAlignment: widget.floatingAlignment,
          floatingPadding: widget.floatingPadding,
          floatingStyle: widget.floatingStyle,
          floatingVisibility: widget.floatingVisibility,
          focusNode: widget.focusNode,
          footerStyle: widget.footerStyle,
          footerVisibility: widget.footerVisibility,
          helperStyle: widget.helperStyle,
          hintColor: widget.hintColor,
          indicatorSize: widget.indicatorSize,
          indicatorStrokeWidth: widget.indicatorStrokeWidth,
          indicatorStrokeBackground: widget.indicatorStrokeBackground,
          indicatorStrokeColor: widget.indicatorStrokeColor,
          primaryColor: widget.primaryColor,
          secondaryColor: widget.secondaryColor,
          strutStyle: widget.strutStyle,
          underlineColor: widget.underlineColor,
          underlineHeight: widget.underlineHeight,

          /// TEXT FIELD PROPERTIES
          clipBehavior: widget.clipBehavior,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          cursorColor: widget.cursorColor,
          cursorHeight: widget.cursorHeight,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          cursorRadius: widget.cursorRadius,
          cursorWidth: widget.cursorWidth,
          dragStartBehavior: widget.dragStartBehavior,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          enableSuggestions: widget.enableSuggestions,
          magnifierConfiguration: widget.magnifierConfiguration,
          mouseCursor: widget.mouseCursor,
          obscuringCharacter: widget.obscuringCharacter,
          scribbleEnabled: widget.scribbleEnabled,
          scrollPadding: widget.scrollPadding,
          scrollPhysics: widget.scrollPhysics,
          selectionControls: widget.selectionControls,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          style: widget.style,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          textDirection: widget.textDirection,
          keyboardAppearance: widget.keyboardAppearance,
        );
      });
    }).toList();
  }

  Widget _lookup(
    Widget widget,
    Widget Function(AndrossyField field)? modifier,
  ) {
    if (widget is AndrossyField) {
      return modifier?.call(widget) ?? widget;
    } else if (widget is AndrossyForm) {
      List<Widget> children = widget.children.map((e) {
        return _lookup(e, modifier);
      }).toList();
      return widget.copyWith(children: children);
    } else if (widget is SizedBox && widget.child != null) {
      final child = _lookup(widget.child!, modifier);
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: child,
      );
    } else if (widget is Expanded) {
      final child = _lookup(widget.child, modifier);
      return Expanded(
        flex: widget.flex,
        child: child,
      );
    } else if (widget is Container && widget.child != null) {
      final child = _lookup(widget.child!, modifier);
      return Container(
        alignment: widget.alignment,
        color: widget.color,
        clipBehavior: widget.clipBehavior,
        constraints: widget.constraints,
        decoration: widget.decoration,
        foregroundDecoration: widget.foregroundDecoration,
        key: widget.key,
        margin: widget.margin,
        padding: widget.padding,
        transform: widget.transform,
        transformAlignment: widget.transformAlignment,
        child: child,
      );
    } else {
      return widget;
    }
  }

  void update() => setState(() {});
}

class AndrossyFormController {
  late int? _initialCheckTime;
  late List<Widget> _children;
  late OnAndrossyFieldValid? _valid;

  AndrossyFormController();

  AndrossyFormController _({
    required int? initialCheckTime,
    required void Function(bool)? valid,
    required List<Widget> children,
  }) {
    _initialCheckTime = initialCheckTime;
    _valid = valid;
    _children = children;
    return this;
  }

  Iterable _checks = const [];

  bool get isValid => _validations.length == _children.length;

  Iterable get _validations {
    return _checks.where((i) {
      if (i is GlobalKey<AndrossyFieldState>) {
        final state = i.currentState;
        if (state != null) {
          return state.isValid && state.isChecked;
        } else {
          return false;
        }
      } else if (i is AndrossyFormController) {
        return i.isValid;
      }
      return false;
    });
  }

  void _config() {
    _checks = _children.map((e) {
      return e is AndrossyForm ? e.controller : e.key;
    });

    for (var i in _children) {
      if (i is AndrossyField && i.key is GlobalKey<AndrossyFieldState>) {
        final key = i.key as GlobalKey<AndrossyFieldState>;
        key.currentState?.setOnValidListener((_) => validate());
      }
    }
    _initialValidate();
  }

  bool _initial = true;

  void _initialValidate() async {
    if (_initialCheckTime != null && _initial && _valid != null) {
      await Future.delayed(Duration(milliseconds: _initialCheckTime ?? 0));
      _initial = false;
      validate();
    }
  }

  void validate() {
    if (_valid != null) _valid?.call(isValid);
  }
}
