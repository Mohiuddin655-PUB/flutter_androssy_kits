import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';

/// Provides shared defaults and validation coordination for a group of
/// [AndrossyField] widgets.
///
/// Use [AndrossyForm] when multiple fields in the same page or section should
/// share the same Androssy styling, keyboard behavior, counter rules, cursor
/// styling, or selection configuration. A child field's explicitly provided
/// value always wins over the form default, so local one-off customization
/// stays simple.
///
/// Common use cases:
///
/// Shared authentication form styling:
///
/// ```dart
/// final formController = AndrossyFormController();
///
/// AndrossyForm(
///   controller: formController,
///   borderColor: const AndrossyFieldProperty.auto(),
///   borderRadius: AndrossyFieldProperty.all(BorderRadius.circular(12)),
///   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
///   floatingVisibility: FloatingVisibility.always,
///   autoDismissKeyboard: true,
///   onValid: (valid) => submitButtonKey.currentState?.setEnabled(valid),
///   children: [
///     AndrossyField(
///       key: emailKey,
///       hintText: 'Email',
///       inputType: TextInputType.emailAddress,
///       onValidator: isValidEmail,
///     ),
///     const SizedBox(height: 16),
///     AndrossyField(
///       key: passwordKey,
///       hintText: 'Password',
///       obscureText: true,
///       onValidator: isValidPassword,
///     ),
///   ],
/// )
/// ```
///
/// Shared counter/footer behavior:
///
/// ```dart
/// AndrossyForm(
///   maxLengthEnforcement: MaxLengthEnforcement.none,
///   counterVisibility: FloatingVisibility.always,
///   buildCounter: (context, {
///     required currentLength,
///     required maxLength,
///     required isFocused,
///   }) {
///     return Text('$currentLength/${maxLength ?? '-'}');
///   },
///   children: const [
///     AndrossyField(maxCharacters: 140),
///     AndrossyField(maxCharacters: 80),
///   ],
/// )
/// ```
///
/// Nested forms:
///
/// Parent form defaults are inherited by nested forms only when the nested form
/// has not provided its own value. This keeps app-level defaults reusable while
/// allowing smaller sections to override spacing, colors, counters, or keyboard
/// behavior.
class AndrossyForm extends StatefulWidget {
  final AndrossyFormController controller;
  final int? initialCheckTime;
  final OnAndrossyFieldValid? onValid;
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
  final double? width;
  final double? height;
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
  final IndicatorAlignment? indicatorAlignment;
  final double? indicatorSize;
  final double? indicatorStrokeWidth;
  final AndrossyFieldProperty<Color?>? indicatorStrokeBackground;
  final AndrossyFieldProperty<Color?>? indicatorStrokeColor;
  final String? loadingText;
  final Color? primaryColor;
  final Color? secondaryColor;
  final StrutStyle? strutStyle;
  final AndrossyFieldProperty<Color?>? underlineColor;
  final AndrossyFieldProperty<double?>? underlineHeight;

  /// TEXT FIELD PROPERTIES
  final Clip? clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final AndrossyFieldContextMenuBuilder? contextMenuBuilder;
  final Object? groupId;
  final WidgetStatesController? statesController;
  final TextAlignVertical? textAlignVertical;
  final AndrossyFieldProperty<Color?>? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final bool? cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double? cursorWidth;
  final DragStartBehavior? dragStartBehavior;
  final bool? enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
  final bool? enableSuggestions;
  final List<Locale>? hintLocales;
  final bool? ignorePointers;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final String? obscuringCharacter;
  final bool? scribbleEnabled;
  final bool? stylusHandwritingEnabled;
  final EdgeInsets? scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final bool? selectAllOnFocus;
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

  /// Shared focus behavior for children that do not override it locally.
  final bool? autoDismissKeyboard;
  final bool? canRequestFocus;

  AndrossyForm({
    super.key,
    AndrossyFormController? controller,
    this.initialCheckTime,
    this.onValid,
    this.children = const [],
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,

    /// FIELD PROPERTIES
    this.width,
    this.height,
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
    this.indicatorAlignment,
    this.indicatorSize,
    this.indicatorStrokeWidth,
    this.indicatorStrokeBackground,
    this.indicatorStrokeColor,
    this.loadingText,
    this.primaryColor,
    this.secondaryColor,
    this.strutStyle,
    this.underlineColor,
    this.underlineHeight,

    /// TEXT FIELD PROPERTIES
    this.clipBehavior,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.groupId,
    this.statesController,
    this.textAlignVertical,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth,
    this.dragStartBehavior,
    this.enableIMEPersonalizedLearning,
    this.enableInteractiveSelection,
    this.enableSuggestions,
    this.hintLocales,
    this.ignorePointers,
    this.magnifierConfiguration,
    this.maxLengthEnforcement,
    this.mouseCursor,
    this.buildCounter,
    this.obscuringCharacter,
    this.scribbleEnabled,
    this.stylusHandwritingEnabled,
    this.scrollPadding,
    this.scrollPhysics,
    this.selectAllOnFocus,
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
    this.autoDismissKeyboard,
    this.canRequestFocus,
  }) : controller = (controller ?? AndrossyFormController())._(
          initialCheckTime: initialCheckTime,
          valid: onValid,
          children: _extract(children),
        );

  AndrossyForm copyWith({
    Key? key,
    AndrossyFormController? controller,
    int? initialCheckTime,
    OnAndrossyFieldValid? onValid,
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
    double? width,
    double? height,
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
    IndicatorAlignment? indicatorAlignment,
    double? indicatorSize,
    double? indicatorStrokeWidth,
    AndrossyFieldProperty<Color?>? indicatorStrokeBackground,
    AndrossyFieldProperty<Color?>? indicatorStrokeColor,
    String? loadingText,
    Color? primaryColor,
    Color? secondaryColor,
    StrutStyle? strutStyle,
    AndrossyFieldProperty<Color?>? underlineColor,
    AndrossyFieldProperty<double?>? underlineHeight,

    /// TEXT FIELD PROPERTIES
    Clip? clipBehavior,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    AndrossyFieldContextMenuBuilder? contextMenuBuilder,
    Object? groupId,
    WidgetStatesController? statesController,
    TextAlignVertical? textAlignVertical,
    AndrossyFieldProperty<Color?>? cursorColor,
    Color? cursorErrorColor,
    double? cursorHeight,
    bool? cursorOpacityAnimates,
    Radius? cursorRadius,
    double? cursorWidth,
    DragStartBehavior? dragStartBehavior,
    bool? enableIMEPersonalizedLearning,
    bool? enableInteractiveSelection,
    bool? enableSuggestions,
    List<Locale>? hintLocales,
    bool? ignorePointers,
    TextMagnifierConfiguration? magnifierConfiguration,
    MaxLengthEnforcement? maxLengthEnforcement,
    MouseCursor? mouseCursor,
    InputCounterWidgetBuilder? buildCounter,
    String? obscuringCharacter,
    bool? scribbleEnabled,
    bool? stylusHandwritingEnabled,
    EdgeInsets? scrollPadding,
    ScrollPhysics? scrollPhysics,
    bool? selectAllOnFocus,
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
    bool? autoDismissKeyboard,
    bool? canRequestFocus,
  }) {
    return AndrossyForm(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      initialCheckTime: initialCheckTime ?? this.initialCheckTime,
      onValid: onValid ?? this.onValid,
      direction: direction ?? this.direction,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      textBaseline: textBaseline ?? this.textBaseline,
      textDirection: textDirection ?? this.textDirection,
      verticalDirection: verticalDirection ?? this.verticalDirection,

      /// FIELD PROPERTIES
      width: width ?? this.width,
      height: height ?? this.height,
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
      indicatorAlignment: indicatorAlignment ?? this.indicatorAlignment,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorStrokeWidth: indicatorStrokeWidth ?? this.indicatorStrokeWidth,
      indicatorStrokeBackground:
          indicatorStrokeBackground ?? this.indicatorStrokeBackground,
      indicatorStrokeColor: indicatorStrokeColor ?? this.indicatorStrokeColor,
      loadingText: loadingText ?? this.loadingText,
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
      groupId: groupId ?? this.groupId,
      statesController: statesController ?? this.statesController,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
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
      hintLocales: hintLocales ?? this.hintLocales,
      ignorePointers: ignorePointers ?? this.ignorePointers,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      buildCounter: buildCounter ?? this.buildCounter,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      scribbleEnabled: scribbleEnabled ?? this.scribbleEnabled,
      stylusHandwritingEnabled:
          stylusHandwritingEnabled ?? this.stylusHandwritingEnabled,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      selectAllOnFocus: selectAllOnFocus ?? this.selectAllOnFocus,
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
      autoDismissKeyboard: autoDismissKeyboard ?? this.autoDismissKeyboard,
      canRequestFocus: canRequestFocus ?? this.canRequestFocus,
      children: children ?? this.children,
    );
  }

  static List<Widget> _extract(List<Widget> widgets) {
    final children = <Widget>[];

    void lookup(Widget? widget) {
      if (widget == null) return;
      if (widget is AndrossyField && _isTrackableField(widget)) {
        children.add(widget);
      } else if (widget is AndrossyForm) {
        children.add(widget);
      } else if (widget is MultiChildRenderObjectWidget) {
        for (final child in widget.children) {
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

    for (final widget in widgets) {
      lookup(widget);
    }

    return children;
  }

  static bool _isTrackableField(AndrossyField field) {
    return field.key is GlobalKey<AndrossyFieldState> &&
        (field.onValidator != null || field.onCheck != null);
  }

  @override
  State<AndrossyForm> createState() => AndrossyFormState();
}

class AndrossyFormState extends State<AndrossyForm> {
  List<Widget>? _inheritedChildren;
  bool _configScheduled = false;

  @override
  void initState() {
    super.initState();
    _scheduleConfig();
  }

  @override
  void didUpdateWidget(covariant AndrossyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _inheritedChildren = null;
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach();
    }
    _scheduleConfig();
  }

  @override
  void dispose() {
    _inheritedChildren = null;
    widget.controller._detach();
    super.dispose();
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
    return _inheritedChildren ??=
        widget.children.map(_inheritWidget).toList(growable: false);
  }

  void _scheduleConfig() {
    if (_configScheduled) return;
    _configScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _configScheduled = false;
      if (!mounted) return;
      widget.controller._config();
    });
  }

  Widget _inheritWidget(Widget child) {
    if (child is AndrossyField) return _inheritFieldDefaults(child);
    if (child is AndrossyForm) return _inheritFormDefaults(child);
    if (child is Container && child.child != null) {
      final inheritedChild = _inheritWidget(child.child!);
      return Container(
        key: child.key,
        alignment: child.alignment,
        color: child.color,
        isAntiAlias: child.isAntiAlias,
        clipBehavior: child.clipBehavior,
        constraints: child.constraints,
        decoration: child.decoration,
        foregroundDecoration: child.foregroundDecoration,
        margin: child.margin,
        padding: child.padding,
        transform: child.transform,
        transformAlignment: child.transformAlignment,
        child: inheritedChild,
      );
    }
    if (child is SizedBox && child.child != null) {
      return SizedBox(
        key: child.key,
        width: child.width,
        height: child.height,
        child: _inheritWidget(child.child!),
      );
    }
    if (child is Padding) {
      return Padding(
        key: child.key,
        padding: child.padding,
        child: _inheritNullableWidget(child.child),
      );
    }
    if (child is Center) {
      return Center(
        key: child.key,
        widthFactor: child.widthFactor,
        heightFactor: child.heightFactor,
        child: _inheritNullableWidget(child.child),
      );
    }
    if (child is Align) {
      return Align(
        key: child.key,
        alignment: child.alignment,
        widthFactor: child.widthFactor,
        heightFactor: child.heightFactor,
        child: _inheritNullableWidget(child.child),
      );
    }
    if (child is Expanded) {
      return Expanded(
        key: child.key,
        flex: child.flex,
        child: _inheritWidget(child.child),
      );
    }
    if (child is Flexible) {
      return Flexible(
        key: child.key,
        flex: child.flex,
        fit: child.fit,
        child: _inheritWidget(child.child),
      );
    }
    if (child is Row) {
      return Row(
        key: child.key,
        mainAxisAlignment: child.mainAxisAlignment,
        mainAxisSize: child.mainAxisSize,
        crossAxisAlignment: child.crossAxisAlignment,
        textDirection: child.textDirection,
        verticalDirection: child.verticalDirection,
        textBaseline: child.textBaseline,
        spacing: child.spacing,
        children: child.children.map(_inheritWidget).toList(),
      );
    }
    if (child is Column) {
      return Column(
        key: child.key,
        mainAxisAlignment: child.mainAxisAlignment,
        mainAxisSize: child.mainAxisSize,
        crossAxisAlignment: child.crossAxisAlignment,
        textDirection: child.textDirection,
        verticalDirection: child.verticalDirection,
        textBaseline: child.textBaseline,
        spacing: child.spacing,
        children: child.children.map(_inheritWidget).toList(),
      );
    }
    if (child is Flex) {
      return Flex(
        key: child.key,
        direction: child.direction,
        mainAxisAlignment: child.mainAxisAlignment,
        mainAxisSize: child.mainAxisSize,
        crossAxisAlignment: child.crossAxisAlignment,
        textDirection: child.textDirection,
        verticalDirection: child.verticalDirection,
        textBaseline: child.textBaseline,
        clipBehavior: child.clipBehavior,
        spacing: child.spacing,
        children: child.children.map(_inheritWidget).toList(),
      );
    }
    if (child is Wrap) {
      return Wrap(
        key: child.key,
        direction: child.direction,
        alignment: child.alignment,
        spacing: child.spacing,
        runAlignment: child.runAlignment,
        runSpacing: child.runSpacing,
        crossAxisAlignment: child.crossAxisAlignment,
        textDirection: child.textDirection,
        verticalDirection: child.verticalDirection,
        clipBehavior: child.clipBehavior,
        children: child.children.map(_inheritWidget).toList(),
      );
    }
    return child;
  }

  Widget? _inheritNullableWidget(Widget? child) {
    return child == null ? null : _inheritWidget(child);
  }

  AndrossyField _inheritFieldDefaults(AndrossyField field) {
    return field.defaultWith(
      /// FIELD PROPERTIES
      width: widget.width,
      height: widget.height,
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
      indicatorAlignment: widget.indicatorAlignment,
      indicatorSize: widget.indicatorSize,
      indicatorStrokeWidth: widget.indicatorStrokeWidth,
      indicatorStrokeBackground: widget.indicatorStrokeBackground,
      indicatorStrokeColor: widget.indicatorStrokeColor,
      loadingText: widget.loadingText,
      primaryColor: widget.primaryColor,
      secondaryColor: widget.secondaryColor,
      strutStyle: widget.strutStyle,
      underlineColor: widget.underlineColor,
      underlineHeight: widget.underlineHeight,

      /// TEXT FIELD PROPERTIES
      clipBehavior: widget.clipBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      contextMenuBuilder: widget.contextMenuBuilder,
      groupId: widget.groupId,
      statesController: widget.statesController,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      cursorHeight: widget.cursorHeight,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      dragStartBehavior: widget.dragStartBehavior,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableSuggestions: widget.enableSuggestions,
      hintLocales: widget.hintLocales,
      ignorePointers: widget.ignorePointers,
      magnifierConfiguration: widget.magnifierConfiguration,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      mouseCursor: widget.mouseCursor,
      buildCounter: widget.buildCounter,
      obscuringCharacter: widget.obscuringCharacter,
      scribbleEnabled: widget.scribbleEnabled,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      scrollPadding: widget.scrollPadding,
      scrollPhysics: widget.scrollPhysics,
      selectAllOnFocus: widget.selectAllOnFocus,
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
      autoDismissKeyboard: widget.autoDismissKeyboard,
      canRequestFocus: widget.canRequestFocus,
    );
  }

  AndrossyForm _inheritFormDefaults(AndrossyForm form) {
    return AndrossyForm(
      key: form.key,
      controller: form.controller,
      initialCheckTime: form.initialCheckTime,
      onValid: form.onValid,
      direction: form.direction,
      crossAxisAlignment: form.crossAxisAlignment,
      mainAxisAlignment: form.mainAxisAlignment,
      mainAxisSize: form.mainAxisSize,
      textBaseline: form.textBaseline,
      textDirection: form.textDirection ?? widget.textDirection,
      verticalDirection: form.verticalDirection,

      /// FIELD PROPERTIES
      width: form.width ?? widget.width,
      height: form.height ?? widget.height,
      animationCurve: form.animationCurve ?? widget.animationCurve,
      animationDuration: form.animationDuration ?? widget.animationDuration,
      backgroundColor: form.backgroundColor ?? widget.backgroundColor,
      borderColor: form.borderColor ?? widget.borderColor,
      borderRadius: form.borderRadius ?? widget.borderRadius,
      borderWidth: form.borderWidth ?? widget.borderWidth,
      constraints: form.constraints ?? widget.constraints,
      contentPadding: form.contentPadding ?? widget.contentPadding,
      counterStyle: form.counterStyle ?? widget.counterStyle,
      counterVisibility: form.counterVisibility ?? widget.counterVisibility,
      decoration: form.decoration ?? widget.decoration,
      drawableEndSize: form.drawableEndSize ?? widget.drawableEndSize,
      drawableEndPadding: form.drawableEndPadding ?? widget.drawableEndPadding,
      drawableEndTint: form.drawableEndTint ?? widget.drawableEndTint,
      drawableStartSize: form.drawableStartSize ?? widget.drawableStartSize,
      drawableStartPadding:
          form.drawableStartPadding ?? widget.drawableStartPadding,
      drawableStartTint: form.drawableStartTint ?? widget.drawableStartTint,
      errorColor: form.errorColor ?? widget.errorColor,
      errorStyle: form.errorStyle ?? widget.errorStyle,
      floatingAlignment: form.floatingAlignment ?? widget.floatingAlignment,
      floatingPadding: form.floatingPadding ?? widget.floatingPadding,
      floatingStyle: form.floatingStyle ?? widget.floatingStyle,
      floatingVisibility: form.floatingVisibility ?? widget.floatingVisibility,
      focusNode: form.focusNode ?? widget.focusNode,
      footerStyle: form.footerStyle ?? widget.footerStyle,
      footerVisibility: form.footerVisibility ?? widget.footerVisibility,
      helperStyle: form.helperStyle ?? widget.helperStyle,
      hintColor: form.hintColor ?? widget.hintColor,
      indicatorAlignment: form.indicatorAlignment ?? widget.indicatorAlignment,
      indicatorSize: form.indicatorSize ?? widget.indicatorSize,
      indicatorStrokeWidth:
          form.indicatorStrokeWidth ?? widget.indicatorStrokeWidth,
      indicatorStrokeBackground:
          form.indicatorStrokeBackground ?? widget.indicatorStrokeBackground,
      indicatorStrokeColor:
          form.indicatorStrokeColor ?? widget.indicatorStrokeColor,
      loadingText: form.loadingText ?? widget.loadingText,
      primaryColor: form.primaryColor ?? widget.primaryColor,
      secondaryColor: form.secondaryColor ?? widget.secondaryColor,
      strutStyle: form.strutStyle ?? widget.strutStyle,
      underlineColor: form.underlineColor ?? widget.underlineColor,
      underlineHeight: form.underlineHeight ?? widget.underlineHeight,

      /// TEXT FIELD PROPERTIES
      clipBehavior: form.clipBehavior ?? widget.clipBehavior,
      contentInsertionConfiguration: form.contentInsertionConfiguration ??
          widget.contentInsertionConfiguration,
      contextMenuBuilder: form.contextMenuBuilder ?? widget.contextMenuBuilder,
      groupId: form.groupId ?? widget.groupId,
      statesController: form.statesController ?? widget.statesController,
      textAlignVertical: form.textAlignVertical ?? widget.textAlignVertical,
      cursorColor: form.cursorColor ?? widget.cursorColor,
      cursorErrorColor: form.cursorErrorColor ?? widget.cursorErrorColor,
      cursorHeight: form.cursorHeight ?? widget.cursorHeight,
      cursorOpacityAnimates:
          form.cursorOpacityAnimates ?? widget.cursorOpacityAnimates,
      cursorRadius: form.cursorRadius ?? widget.cursorRadius,
      cursorWidth: form.cursorWidth ?? widget.cursorWidth,
      dragStartBehavior: form.dragStartBehavior ?? widget.dragStartBehavior,
      enableIMEPersonalizedLearning: form.enableIMEPersonalizedLearning ??
          widget.enableIMEPersonalizedLearning,
      enableInteractiveSelection:
          form.enableInteractiveSelection ?? widget.enableInteractiveSelection,
      enableSuggestions: form.enableSuggestions ?? widget.enableSuggestions,
      hintLocales: form.hintLocales ?? widget.hintLocales,
      ignorePointers: form.ignorePointers ?? widget.ignorePointers,
      magnifierConfiguration:
          form.magnifierConfiguration ?? widget.magnifierConfiguration,
      maxLengthEnforcement:
          form.maxLengthEnforcement ?? widget.maxLengthEnforcement,
      mouseCursor: form.mouseCursor ?? widget.mouseCursor,
      buildCounter: form.buildCounter ?? widget.buildCounter,
      obscuringCharacter: form.obscuringCharacter ?? widget.obscuringCharacter,
      scribbleEnabled: form.scribbleEnabled ?? widget.scribbleEnabled,
      stylusHandwritingEnabled:
          form.stylusHandwritingEnabled ?? widget.stylusHandwritingEnabled,
      scrollPadding: form.scrollPadding ?? widget.scrollPadding,
      scrollPhysics: form.scrollPhysics ?? widget.scrollPhysics,
      selectAllOnFocus: form.selectAllOnFocus ?? widget.selectAllOnFocus,
      selectionControls: form.selectionControls ?? widget.selectionControls,
      selectionHeightStyle:
          form.selectionHeightStyle ?? widget.selectionHeightStyle,
      selectionWidthStyle:
          form.selectionWidthStyle ?? widget.selectionWidthStyle,
      smartDashesType: form.smartDashesType ?? widget.smartDashesType,
      smartQuotesType: form.smartQuotesType ?? widget.smartQuotesType,
      spellCheckConfiguration:
          form.spellCheckConfiguration ?? widget.spellCheckConfiguration,
      style: form.style ?? widget.style,
      textAlign: form.textAlign ?? widget.textAlign,
      textCapitalization: form.textCapitalization ?? widget.textCapitalization,
      keyboardAppearance: form.keyboardAppearance ?? widget.keyboardAppearance,
      autoDismissKeyboard:
          form.autoDismissKeyboard ?? widget.autoDismissKeyboard,
      canRequestFocus: form.canRequestFocus ?? widget.canRequestFocus,
      children: form.children,
    );
  }

  void update() {
    if (!mounted) return;
    _inheritedChildren = null;
    setState(() {});
  }
}

/// Runtime validation controller for an [AndrossyForm].
///
/// Keep one controller when a button, page state, or business layer needs to
/// read the current aggregate validity or ask the form to emit the latest
/// validity manually.
///
/// ```dart
/// final controller = AndrossyFormController();
///
/// AndrossyForm(
///   controller: controller,
///   onValid: (valid) => setState(() => canSubmit = valid),
///   children: [
///     AndrossyField(
///       key: emailKey,
///       onValidator: isValidEmail,
///     ),
///   ],
/// );
///
/// controller.validate();
/// final canSubmitNow = controller.isValid;
/// ```
class AndrossyFormController {
  int? _initialCheckTime;
  List<Widget> _children = const <Widget>[];
  OnAndrossyFieldValid? _valid;
  OnAndrossyFieldValid? _validListener;
  List<Object> _checks = const <Object>[];
  bool _attached = false;
  bool _initial = true;
  int _lifecycle = 0;

  AndrossyFormController();

  AndrossyFormController _({
    required int? initialCheckTime,
    required void Function(bool)? valid,
    required List<Widget> children,
  }) {
    if (_attached) _clearRemovedChildListeners(children);
    _initialCheckTime = initialCheckTime;
    _valid = valid;
    _children = children;
    return this;
  }

  bool get isValid {
    return _checks.length == _children.length && _checks.every(_isCheckValid);
  }

  bool _isCheckValid(Object check) {
    if (check is GlobalKey<AndrossyFieldState>) {
      final state = check.currentState;
      return state != null && state.isValid && state.isChecked;
    }
    if (check is AndrossyFormController) return check.isValid;
    return false;
  }

  void _config() {
    _attached = true;
    _checks = [
      for (final child in _children)
        if (_checkFor(child) case final check?) check,
    ];

    for (final child in _children) {
      _setChildValidListener(child, (_) => validate());
    }
    _initialValidate();
  }

  void _detach() {
    _clearChildListeners(_children);
    _attached = false;
    _initial = true;
    _lifecycle++;
    _checks = const <Object>[];
    _validListener = null;
  }

  Object? _checkFor(Widget child) {
    if (child is AndrossyForm) return child.controller;
    if (child is AndrossyField && child.key is GlobalKey<AndrossyFieldState>) {
      return child.key as GlobalKey<AndrossyFieldState>;
    }
    return null;
  }

  void _clearRemovedChildListeners(List<Widget> nextChildren) {
    final nextChecks = Set<Object>.identity();
    for (final child in nextChildren) {
      final check = _checkFor(child);
      if (check != null) nextChecks.add(check);
    }

    for (final child in _children) {
      final check = _checkFor(child);
      if (check != null && !nextChecks.contains(check)) {
        _clearChildValidListener(child);
      }
    }
  }

  void _clearChildListeners(List<Widget> children) {
    for (final child in children) {
      _clearChildValidListener(child);
    }
  }

  void _setChildValidListener(Widget child, OnAndrossyFieldValid listener) {
    if (child is AndrossyForm) {
      child.controller._setOnValidListener(listener);
    } else if (child is AndrossyField &&
        child.key is GlobalKey<AndrossyFieldState>) {
      final key = child.key as GlobalKey<AndrossyFieldState>;
      key.currentState?.setOnValidListener(listener);
    }
  }

  void _clearChildValidListener(Widget child) {
    if (child is AndrossyForm) {
      child.controller._clearOnValidListener();
    } else if (child is AndrossyField &&
        child.key is GlobalKey<AndrossyFieldState>) {
      final key = child.key as GlobalKey<AndrossyFieldState>;
      key.currentState?.setOnValidListener(null);
    }
  }

  void _setOnValidListener(OnAndrossyFieldValid value) {
    _validListener = value;
  }

  void _clearOnValidListener() {
    _validListener = null;
  }

  void _initialValidate() {
    if (_initialCheckTime == null ||
        !_initial ||
        (_valid == null && _validListener == null)) {
      return;
    }
    _initial = false;

    final lifecycle = _lifecycle;
    Future<void>.delayed(Duration(milliseconds: _initialCheckTime ?? 0)).then((
      _,
    ) {
      if (!_attached || lifecycle != _lifecycle) return;
      validate();
    });
  }

  void validate() {
    if (!_attached) return;
    final valid = isValid;
    _valid?.call(valid);
    _validListener?.call(valid);
  }
}
