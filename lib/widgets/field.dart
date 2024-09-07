import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icon.dart';

typedef OnAndrossyFieldErrorCheck = Future<AndrossyFieldError> Function(
  String value,
);
typedef OnAndrossyFieldChanged = void Function(String value);
typedef OnAndrossyFieldError = String? Function(AndrossyFieldError error);
typedef OnAndrossyFieldValid = void Function(bool value);
typedef OnAndrossyFieldValidator = bool Function(String value);

typedef AndrossyFieldDrawableBuilder = Widget Function(
  BuildContext context,
  AndrossyFieldState state,
);

typedef AndrossyFieldContextMenuBuilder = Widget Function(
  BuildContext context,
  EditableTextState state,
);

typedef AndrossyFieldPrivateCommandListener = void Function(
  String value,
  Map<String, dynamic> params,
);

typedef AndrossyFieldVoidListener = void Function();
typedef AndrossyFieldCheckListener = Function(String tag, bool valid);
typedef AndrossyFieldSelectionChangeListener = void Function(
  TextSelection selection,
  SelectionChangedCause? cause,
);
typedef AndrossyFieldSubmitListener = void Function(String value);
typedef AndrossyFieldTapOutsideListener = void Function(PointerDownEvent event);

class AndrossyField extends StatefulWidget {
  /// GLOBAL PROPERTIES
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

  /// TEXT FIELD GLOBAL PROPERTIES
  final Clip? clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final AndrossyFieldContextMenuBuilder? contextMenuBuilder;
  final AndrossyFieldProperty<Color?>? cursorColor;
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
  final TextDirection? textDirection;
  final Brightness? keyboardAppearance;

  /// LOCAL PROPERTIES
  final bool? enabled;
  final bool? autoDisposeMode;
  final String? characters;
  final AndrossyFieldProperty? drawableEnd;
  final AndrossyFieldDrawableBuilder? drawableEndBuilder;
  final bool? drawableEndVisible;
  final AndrossyFieldTweenProperty? drawableEye;
  final AndrossyFieldProperty? drawableStart;
  final AndrossyFieldDrawableBuilder? drawableStartBuilder;
  final bool? drawableStartVisible;
  final String? errorText;
  final String? floatingText;
  final String? helperText;
  final String? hintText;
  final Widget? indicator;
  final bool? indicatorVisible;
  final String? ignorableCharacters;
  final int? maxCharacters;
  final bool? maxCharactersAsLimit;
  final int? minCharacters;
  final List<TextInputFormatter>? inputFormatters;
  final String? text;

  /// TEXT FIELD LOCAL PROPERTIES
  final bool? autocorrect;
  final List<String>? autofillHints;
  final bool? autoFocus;
  final TextEditingController? controller;
  final bool? expands;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final int? maxLines;
  final int? minLines;
  final bool? obscureText;
  final bool? readOnly;
  final String? restorationId;
  final ScrollController? scrollController;
  final bool? showCursor;
  final UndoHistoryController? undoController;
  final AndrossyFieldPrivateCommandListener? onAppPrivateCommand;
  final AndrossyFieldVoidListener? onEditingComplete;
  final AndrossyFieldSubmitListener? onSubmitted;
  final AndrossyFieldTapOutsideListener? onTapOutside;

  /// CALLBACK LOCAL PROPERTIES
  final OnAndrossyFieldErrorCheck? onCheck;
  final OnAndrossyFieldChanged? onChanged;
  final OnAndrossyFieldError? onError;
  final OnAndrossyFieldValid? onValid;
  final OnAndrossyFieldValidator? onValidator;

  const AndrossyField({
    super.key,

    /// GLOBAL PROPERTIES
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

    /// TEXT FIELD GLOBAL PROPERTIES
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
    this.textDirection,
    this.keyboardAppearance,

    /// LOCAL PROPERTIES
    this.enabled,
    this.autoDisposeMode,
    this.characters,
    this.drawableEnd,
    this.drawableEndBuilder,
    this.drawableEndVisible,
    this.drawableEye,
    this.drawableStart,
    this.drawableStartBuilder,
    this.drawableStartVisible,
    this.errorText,
    this.floatingText,
    this.helperText,
    this.hintText,
    this.indicator,
    this.indicatorVisible,
    this.ignorableCharacters,
    this.maxCharacters,
    this.maxCharactersAsLimit,
    this.minCharacters,
    this.inputFormatters,
    this.text,

    /// TEXT FIELD LOCAL PROPERTIES
    this.autocorrect,
    this.autofillHints,
    this.autoFocus,
    this.controller,
    this.expands,
    this.inputAction,
    this.inputType,
    this.maxLines,
    this.minLines,
    this.obscureText,
    this.readOnly,
    this.restorationId,
    this.scrollController,
    this.showCursor,
    this.undoController,
    this.onAppPrivateCommand,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,

    /// CALLBACK LOCAL PROPERTIES
    this.onCheck,
    this.onChanged,
    this.onError,
    this.onValid,
    this.onValidator,
  });

  AndrossyField defaultWith({
    /// GLOBAL PROPERTIES
    Curve? animationCurve,
    Duration? animationDuration,
    AndrossyFieldProperty<Color?>? backgroundColor,
    AndrossyFieldProperty<Color?>? borderColor,
    AndrossyFieldProperty<BorderRadius?>? borderRadius,
    AndrossyFieldTweenProperty<double?>? borderWidth,
    BoxConstraints? constraints,
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
    EdgeInsets? contentPadding,
    Color? primaryColor,
    Color? secondaryColor,
    StrutStyle? strutStyle,
    AndrossyFieldProperty<Color?>? underlineColor,
    AndrossyFieldProperty<double?>? underlineHeight,

    /// TEXT FIELD GLOBAL PROPERTIES
    Clip? clipBehavior,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    AndrossyFieldContextMenuBuilder? contextMenuBuilder,
    AndrossyFieldProperty<Color?>? cursorColor,
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
    TextDirection? textDirection,
    Brightness? keyboardAppearance,

    /// LOCAL PROPERTIES
    bool? enabled,
    bool? autoDisposeMode,
    String? characters,
    AndrossyFieldProperty? drawableEnd,
    AndrossyFieldDrawableBuilder? drawableEndBuilder,
    bool? drawableEndVisible,
    AndrossyFieldTweenProperty? drawableEye,
    AndrossyFieldProperty? drawableStart,
    AndrossyFieldDrawableBuilder? drawableStartBuilder,
    bool? drawableStartVisible,
    String? errorText,
    String? floatingText,
    String? helperText,
    String? hintText,
    Widget? indicator,
    bool? indicatorVisible,
    String? ignorableCharacters,
    String? loadingText,
    int? maxCharacters,
    bool? maxCharactersAsLimit,
    int? minCharacters,
    List<TextInputFormatter>? inputFormatters,
    String? text,

    /// TEXT FIELD LOCAL PROPERTIES
    bool? autocorrect,
    List<String>? autofillHints,
    bool? autoFocus,
    TextEditingController? controller,
    bool? expands,
    TextInputAction? inputAction,
    TextInputType? inputType,
    int? maxLines,
    int? minLines,
    bool? obscureText,
    bool? readOnly,
    String? restorationId,
    ScrollController? scrollController,
    bool? showCursor,
    TextInputAction? textInputAction,
    UndoHistoryController? undoController,
    AndrossyFieldPrivateCommandListener? onAppPrivateCommand,
    AndrossyFieldVoidListener? onEditingComplete,
    AndrossyFieldSubmitListener? onSubmitted,
    AndrossyFieldTapOutsideListener? onTapOutside,

    /// CALLBACK LOCAL PROPERTIES
    OnAndrossyFieldErrorCheck? onCheck,
    OnAndrossyFieldChanged? onChanged,
    OnAndrossyFieldError? onError,
    OnAndrossyFieldValid? onValid,
    OnAndrossyFieldValidator? onValidator,
  }) {
    return AndrossyField(
      key: key,

      /// GLOBAL PROPERTIES
      animationCurve: this.animationCurve ?? animationCurve,
      animationDuration: this.animationDuration ?? animationDuration,
      backgroundColor: this.backgroundColor ?? backgroundColor,
      borderColor: this.borderColor ?? borderColor,
      borderRadius: this.borderRadius ?? borderRadius,
      borderWidth: this.borderWidth ?? borderWidth,
      constraints: this.constraints ?? constraints,
      contentPadding: this.contentPadding ?? contentPadding,
      counterStyle: this.counterStyle ?? counterStyle,
      counterVisibility: this.counterVisibility ?? counterVisibility,
      decoration: this.decoration ?? decoration,
      drawableEndSize: this.drawableEndSize ?? drawableEndSize,
      drawableEndPadding: this.drawableEndPadding ?? drawableEndPadding,
      drawableEndTint: this.drawableEndTint ?? drawableEndTint,
      drawableStartSize: this.drawableStartSize ?? drawableStartSize,
      drawableStartPadding: this.drawableStartPadding ?? drawableStartPadding,
      drawableStartTint: this.drawableStartTint ?? drawableStartTint,
      errorColor: this.errorColor ?? errorColor,
      errorStyle: this.errorStyle ?? errorStyle,
      floatingAlignment: this.floatingAlignment ?? floatingAlignment,
      floatingPadding: this.floatingPadding ?? floatingPadding,
      floatingStyle: this.floatingStyle ?? floatingStyle,
      floatingVisibility: this.floatingVisibility ?? floatingVisibility,
      focusNode: this.focusNode ?? focusNode,
      footerStyle: this.footerStyle ?? footerStyle,
      footerVisibility: this.footerVisibility ?? footerVisibility,
      helperStyle: this.helperStyle ?? helperStyle,
      hintColor: this.hintColor ?? hintColor,
      indicatorAlignment: this.indicatorAlignment ?? indicatorAlignment,
      indicatorSize: this.indicatorSize ?? indicatorSize,
      indicatorStrokeWidth: this.indicatorStrokeWidth ?? indicatorStrokeWidth,
      indicatorStrokeBackground:
          indicatorStrokeBackground ?? indicatorStrokeBackground,
      indicatorStrokeColor: this.indicatorStrokeColor ?? indicatorStrokeColor,
      loadingText: this.loadingText ?? loadingText,
      primaryColor: this.primaryColor ?? primaryColor,
      secondaryColor: this.secondaryColor ?? secondaryColor,
      strutStyle: this.strutStyle ?? strutStyle,
      underlineHeight: this.underlineHeight ?? underlineHeight,

      /// TEXT FIELD GLOBAL PROPERTIES
      clipBehavior: this.clipBehavior ?? clipBehavior,
      contentInsertionConfiguration:
          contentInsertionConfiguration ?? contentInsertionConfiguration,
      contextMenuBuilder: this.contextMenuBuilder ?? contextMenuBuilder,
      cursorColor: this.cursorColor ?? cursorColor,
      cursorHeight: this.cursorHeight ?? cursorHeight,
      cursorOpacityAnimates:
          this.cursorOpacityAnimates ?? cursorOpacityAnimates,
      cursorRadius: this.cursorRadius ?? cursorRadius,
      cursorWidth: this.cursorWidth ?? cursorWidth,
      dragStartBehavior: this.dragStartBehavior ?? dragStartBehavior,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? enableIMEPersonalizedLearning,
      enableInteractiveSelection:
          enableInteractiveSelection ?? enableInteractiveSelection,
      enableSuggestions: this.enableSuggestions ?? enableSuggestions,
      magnifierConfiguration:
          this.magnifierConfiguration ?? magnifierConfiguration,
      mouseCursor: this.mouseCursor ?? mouseCursor,
      obscuringCharacter: this.obscuringCharacter ?? obscuringCharacter,
      scribbleEnabled: this.scribbleEnabled ?? scribbleEnabled,
      scrollPadding: this.scrollPadding ?? scrollPadding,
      scrollPhysics: this.scrollPhysics ?? scrollPhysics,
      selectionControls: this.selectionControls ?? selectionControls,
      selectionHeightStyle: this.selectionHeightStyle ?? selectionHeightStyle,
      selectionWidthStyle: this.selectionWidthStyle ?? selectionWidthStyle,
      smartDashesType: this.smartDashesType ?? smartDashesType,
      smartQuotesType: this.smartQuotesType ?? smartQuotesType,
      spellCheckConfiguration:
          spellCheckConfiguration ?? spellCheckConfiguration,
      style: this.style ?? style,
      textAlign: this.textAlign ?? textAlign,
      textCapitalization: this.textCapitalization ?? textCapitalization,
      textDirection: this.textDirection ?? textDirection,
      keyboardAppearance: this.keyboardAppearance ?? keyboardAppearance,

      /// LOCAL PROPERTIES
      enabled: this.enabled ?? enabled,
      autoDisposeMode: this.autoDisposeMode ?? autoDisposeMode,
      characters: this.characters ?? characters,
      drawableEnd: this.drawableEnd ?? drawableEnd,
      drawableEndBuilder: this.drawableEndBuilder ?? drawableEndBuilder,
      drawableEndVisible: this.drawableEndVisible ?? drawableEndVisible,
      drawableEye: this.drawableEye ?? drawableEye,
      drawableStart: this.drawableStart ?? drawableStart,
      drawableStartBuilder: this.drawableStartBuilder ?? drawableStartBuilder,
      drawableStartVisible: this.drawableStartVisible ?? drawableStartVisible,
      errorText: this.errorText ?? errorText,
      floatingText: this.floatingText ?? floatingText,
      helperText: this.helperText ?? helperText,
      hintText: this.hintText ?? hintText,
      indicator: this.indicator ?? indicator,
      indicatorVisible: this.indicatorVisible ?? indicatorVisible,
      ignorableCharacters: this.ignorableCharacters ?? ignorableCharacters,
      maxCharacters: this.maxCharacters ?? maxCharacters,
      maxCharactersAsLimit: this.maxCharactersAsLimit ?? maxCharactersAsLimit,
      minCharacters: this.minCharacters ?? minCharacters,
      inputFormatters: this.inputFormatters ?? inputFormatters,
      text: this.text ?? text,

      /// TEXT FIELD LOCAL PROPERTIES
      autocorrect: this.autocorrect ?? autocorrect,
      autofillHints: this.autofillHints ?? autofillHints,
      autoFocus: this.autoFocus ?? autoFocus,
      controller: this.controller ?? controller,
      expands: this.expands ?? expands,
      inputAction: this.inputAction ?? inputAction,
      inputType: this.inputType ?? inputType,
      maxLines: this.maxLines ?? maxLines,
      minLines: this.minLines ?? minLines,
      obscureText: this.obscureText ?? obscureText,
      readOnly: this.readOnly ?? readOnly,
      restorationId: this.restorationId ?? restorationId,
      scrollController: this.scrollController ?? scrollController,
      showCursor: this.showCursor ?? showCursor,
      undoController: this.undoController ?? undoController,
      onAppPrivateCommand: this.onAppPrivateCommand ?? onAppPrivateCommand,
      onEditingComplete: this.onEditingComplete ?? onEditingComplete,
      onSubmitted: this.onSubmitted ?? onSubmitted,
      onTapOutside: this.onTapOutside ?? onTapOutside,

      /// CALLBACK LOCAL PROPERTIES
      onCheck: this.onCheck ?? onCheck,
      onChanged: this.onChanged ?? onChanged,
      onError: this.onError ?? onError,
      onValid: this.onValid ?? onValid,
      onValidator: this.onValidator ?? onValidator,
    );
  }

  @override
  State<AndrossyField> createState() => AndrossyFieldState();
}

class AndrossyFieldState extends State<AndrossyField> {
  /// WIDGET BUILDER START
  ///
  ///

  late TextEditingController controller;
  late FocusNode _focusNode;
  bool _widgetInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    controller.text = widget.text ?? controller.text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _widgetInitialized = true;
      addFocusListener();
      _handleEditingChange(text);
    });
  }

  void _dispose() {
    if (widget.autoDisposeMode ?? false) {
      removeFocusListener();
      controller.dispose();
      _focusNode.dispose();
    }
  }

  @override
  void dispose() {
    super.dispose();
    return _dispose();
  }

  late AndrossyFieldPropertyState state = AndrossyFieldPropertyState.from(this);

  late final theme = Theme.of(context);

  late final primaryColor = widget.primaryColor ?? theme.primaryColor;

  late final errorColor = widget.errorColor ??
      (theme.brightness == Brightness.dark
          ? Colors.red
          : const Color(0xFFFF7769));

  late final secondaryColor = widget.secondaryColor ??
      (Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF616161)
          : const Color(0xFFBBBBBB));

  late final defaultLabelStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  late final defaultFloatingStyle = widget.floatingStyle.use._defaults(
    enabled: defaultLabelStyle.copyWith(color: secondaryColor),
    focused: defaultLabelStyle.copyWith(color: primaryColor),
    disabled: defaultLabelStyle.copyWith(color: secondaryColor),
    error: defaultLabelStyle.copyWith(color: errorColor),
  );

  late final defaultFooterStyle = widget.footerStyle.use._defaults(
    enabled: defaultLabelStyle.copyWith(color: secondaryColor),
    focused: defaultLabelStyle.copyWith(color: primaryColor),
    disabled: defaultLabelStyle.copyWith(color: secondaryColor),
    error: defaultLabelStyle.copyWith(color: errorColor),
  );

  late final defaultBorderColor = widget.borderColor.use._defaults(
    enabled: primaryColor.withOpacity(0.1),
    focused: primaryColor,
    disabled: secondaryColor.withAlpha(20),
    errorFocused: errorColor,
    error: errorColor.withOpacity(0.25),
  );

  late final defaultCursorColor = AndrossyFieldProperty(
    enabled: secondaryColor,
    focused: primaryColor,
    error: errorColor,
    disabled: secondaryColor,
  );

  late final defaultDrawableStartColor = widget.drawableStartTint.use._defaults(
    enabled: secondaryColor,
    focused: primaryColor,
    disabled: secondaryColor,
    error: errorColor,
  );

  late final defaultDrawableEndColor = widget.drawableEndTint.use._defaults(
    enabled: secondaryColor,
    focused: primaryColor,
    disabled: secondaryColor,
    error: errorColor,
  );

  late final defaultIndicatorColor = widget.indicatorStrokeColor.use._defaults(
    enabled: secondaryColor,
    focused: primaryColor,
    disabled: secondaryColor,
    error: errorColor,
  );

  late final defaultIndicatorBackgroundColor =
      widget.indicatorStrokeBackground.use._defaults(
    enabled: secondaryColor.withAlpha(10),
    focused: primaryColor.withAlpha(20),
  );

  late final defaultUnderlineColor = widget.underlineColor.use._defaults(
    enabled: secondaryColor,
    focused: primaryColor,
    disabled: secondaryColor,
    error: errorColor,
  );

  late final animationCurve = widget.animationCurve ?? Curves.linear;

  late final animationDuration = widget.animationDuration;

  late final indicatorSize = widget.indicatorSize ?? 24;

  Border _border(AndrossyFieldPropertyState state) {
    final borderWidth = widget.borderWidth;
    final normalWidth = borderWidth?.inactive ?? 1.5;
    final focusedWidth = borderWidth?.active ?? 2.0;
    return Border.all(
      color: defaultBorderColor.fromState(state) ?? Colors.grey,
      width: isFocused ? focusedWidth : normalWidth,
    );
  }

  late final TextStyle _style = widget.style ?? const TextStyle();

  late TextStyle style = _style.copyWith(
    fontSize: widget.style?.fontSize ?? 18,
    height: 1.2,
    color: isEnabled ? null : _style.color?.withAlpha(150),
  );

  late TextStyle hintStyle = style.copyWith(
    color: text.isNotEmpty
        ? Colors.transparent
        : widget.hintColor ?? secondaryColor.withAlpha(100),
  );

  Widget defaultIndicator(AndrossyFieldPropertyState state) {
    final defaultColor = defaultIndicatorColor.fromState(state);
    return Container(
      width: indicatorSize,
      height: indicatorSize,
      padding: EdgeInsets.all(indicatorSize * 0.05),
      margin: drawableEndSpace,
      child: CircularProgressIndicator(
        strokeWidth: widget.indicatorStrokeWidth ?? 2,
        color: defaultColor,
        strokeCap: StrokeCap.round,
        backgroundColor: defaultIndicatorBackgroundColor.fromState(state) ??
            defaultColor?.withAlpha(20),
      ),
    );
  }

  Widget _attach(BuildContext context, AndrossyFieldPropertyState state) {
    var mHintStyle = style.copyWith(
      color: text.isNotEmpty
          ? Colors.transparent
          : widget.hintColor ?? secondaryColor.withAlpha(100),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: widget.textDirection,
      children: [
        if (isIndicatorVisible && indicatorAlignment.isStart)
          defaultIndicator(state)
        else if (widget.drawableStartBuilder != null)
          widget.drawableStartBuilder!(context, this)
        else
          _Icon(
            animationCurve: animationCurve,
            animationDuration: animationDuration,
            visibility: drawableStart != null,
            icon: drawableStart,
            size: drawableStartSize,
            tint: defaultDrawableStartColor.fromState(state),
            margin: drawableStartSpace,
          ),
        Expanded(
          child: TextField(
            canRequestFocus: true,
            enabled: isEnabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              isCollapsed: true,
              hintText: hintText,
              hintStyle: mHintStyle,
              hintTextDirection: widget.textDirection,
            ),
            autocorrect: widget.autocorrect ?? true,
            autofillHints: widget.autofillHints,
            autofocus: widget.autoFocus ?? false,
            clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
            controller: controller,
            cursorColor: defaultCursorColor.fromState(state) ?? primaryColor,
            cursorHeight: widget.cursorHeight,
            cursorOpacityAnimates: widget.cursorOpacityAnimates,
            cursorRadius: widget.cursorRadius,
            cursorWidth: widget.cursorWidth ?? 2,
            contentInsertionConfiguration: widget.contentInsertionConfiguration,
            contextMenuBuilder: widget.contextMenuBuilder,
            dragStartBehavior:
                widget.dragStartBehavior ?? DragStartBehavior.start,
            enableIMEPersonalizedLearning:
                widget.enableIMEPersonalizedLearning ?? true,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enableSuggestions: widget.enableSuggestions ?? true,
            expands: widget.expands ?? false,
            focusNode: _focusNode,
            inputFormatters: _formatter,
            keyboardAppearance: widget.keyboardAppearance,
            keyboardType: widget.inputType,
            maxLines: maxLines,
            magnifierConfiguration: widget.magnifierConfiguration,
            maxLength: null,
            minLines: widget.minLines,
            mouseCursor: widget.mouseCursor,
            obscureText: obscureText,
            obscuringCharacter: widget.obscuringCharacter ?? '•',
            onAppPrivateCommand: onAppPrivateCommand,
            onChanged: _handleEditingChange,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onTapOutside: onTapOutside,
            readOnly: isReadMode,
            restorationId: widget.restorationId,
            scribbleEnabled: widget.scribbleEnabled ?? true,
            scrollController: widget.scrollController,
            scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
            scrollPhysics: widget.scrollPhysics,
            selectionControls: widget.selectionControls,
            selectionHeightStyle:
                widget.selectionHeightStyle ?? BoxHeightStyle.tight,
            selectionWidthStyle:
                widget.selectionWidthStyle ?? BoxWidthStyle.tight,
            showCursor: widget.showCursor,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            spellCheckConfiguration: widget.spellCheckConfiguration,
            strutStyle: widget.strutStyle,
            style: style,
            textAlign: widget.textAlign ?? TextAlign.start,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            textDirection: widget.textDirection,
            textInputAction: widget.inputAction,
            undoController: widget.undoController,
          ),
        ),
        if (isIndicatorVisible && indicatorAlignment.isEnd)
          defaultIndicator(state)
        else if (widget.drawableEndBuilder != null)
          widget.drawableEndBuilder!(context, this)
        else
          _Icon(
            animationCurve: animationCurve,
            animationDuration: animationDuration,
            visibility: drawableEnd != null,
            icon: drawableEnd,
            size: drawableEndSize,
            tint: defaultDrawableEndColor.fromState(state),
            margin: drawableEndSpace,
            onToggleClick: widget.drawableEye != null ? onChangeEye : null,
          ),
      ],
    );
  }

  Widget _decorate(Widget child) {
    final decoration = isUnderlineHide
        ? widget.decoration?.fromState(state) ??
            BoxDecoration(
              border: _border(state),
              borderRadius: widget.borderRadius?.fromState(state),
              color: widget.backgroundColor?.fromState(state) ??
                  Colors.transparent,
            )
        : null;
    final clipBehavior = isUnderlineHide ? Clip.antiAlias : Clip.none;
    final padding =
        widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 8);
    final color = isUnderlineHide ? null : Colors.transparent;

    if (animationDuration != null) {
      return AnimatedContainer(
        duration: animationDuration!,
        curve: animationCurve,
        color: color,
        constraints: widget.constraints,
        decoration: decoration,
        clipBehavior: clipBehavior,
        padding: padding,
        child: child,
      );
    } else {
      return Container(
        decoration: decoration,
        clipBehavior: clipBehavior,
        color: color,
        constraints: widget.constraints,
        padding: padding,
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final floatingVisible = this.floatingVisible;
    final underlineVisible = !isUnderlineHide;
    final footerVisible = this.footerVisible;
    final state = this.state;

    final visible = floatingVisible || footerVisible || underlineVisible;

    Widget child = GestureDetector(
      onTap: () => showKeyboard(context),
      child: _decorate(_attach(context, state)),
    );

    return visible
        ? Column(
            textDirection: widget.textDirection,
            children: [
              if (floatingVisible)
                _Header(
                  animationDuration: widget.animationDuration,
                  animationCurve: animationCurve,
                  floatingAlignment: floatingAlignment,
                  floatingTextSpace: floatingPadding,
                  floatingText: floatingText,
                  textAlign: widget.textAlign,
                  textDirection: widget.textDirection,
                  floatingTextStyle: floatingTextStyle,
                ),
              child,
              if (underlineVisible)
                _Underline(
                  active: isFocused,
                  animationDuration: widget.animationDuration,
                  animationCurve: animationCurve,
                  color: defaultUnderlineColor.fromState(state),
                  height: underlineHeight,
                ),
              if (footerVisible)
                _Footer(
                  animationDuration: widget.animationDuration,
                  animationCurve: animationCurve,
                  counterVisibility: counterVisibility,
                  hasError: hasError,
                  floatingTextSpace: floatingPadding,
                  textDirection: widget.textDirection,
                  footerAlignment: footerAlignment,
                  textAlign: widget.textAlign,
                  counter: counter,
                  errorText: errorText,
                  helperText: isIndicatorVisible
                      ? widget.loadingText ?? ""
                      : helperText,
                  footerTextStyle: defaultFooterStyle.fromState(state),
                  counterTextStyle: widget.counterStyle?.fromState(state),
                  errorTextStyle: widget.errorStyle?.fromState(state),
                  helperTextStyle: widget.helperStyle?.fromState(state),
                  isFocused: isFocused,
                ),
            ],
          )
        : child;
  }

  EdgeInsets get floatingPadding {
    final padding = widget.floatingPadding ?? EdgeInsets.zero;
    return padding.copyWith(
      top: padding.top > 0 ? padding.top : 4,
      bottom: padding.bottom > 0 ? padding.bottom : 4,
    );
  }

  ///
  ///
  /// WIDGET BUILDER END
  /// PROPERTY STATE START
  ///
  ///

  late bool _enabled = widget.enabled ?? true;

  bool get isEnabled => _enabled;

  bool _error = false;

  bool get isError => _error;

  bool _focused = false;

  bool get isFocused => _enabled && _focused;

  bool _initial = true;

  bool get isInitial => _initial;

  bool _valid = false;

  bool get validate => onValidator != null ? onValidator!(text) : true;

  bool get isChecked => onCheck != null ? validate && _valid : true;

  bool get isValid => validate && _valid;

  late bool _readOnly = widget.readOnly ?? false;

  bool get isReadMode => _readOnly;

  bool get isUnderlineHide {
    return widget.backgroundColor != null ||
        widget.borderColor != null ||
        widget.decoration != null;
  }

  ///
  ///
  /// PROPERTY STATE END
  /// BASE CALLBACK START
  ///
  ///

  late int maxCharacters = widget.maxCharacters ?? 0;

  AndrossyFieldError errorType(String text, [bool? valid]) {
    if (text.isEmpty && !_initial) {
      return AndrossyFieldError.empty;
    } else if (!(valid ?? _valid)) {
      final length = text.length;
      if (maxCharacters > 0 && maxCharacters < length) {
        return AndrossyFieldError.maximum;
      } else if ((widget.minCharacters ?? 0) > 0 &&
          (widget.minCharacters ?? 0) > length) {
        return AndrossyFieldError.minimum;
      } else {
        return AndrossyFieldError.invalid;
      }
    } else {
      return AndrossyFieldError.none;
    }
  }

  ///
  ///
  /// BASE CALLBACKS END
  /// BASE NOTIFIER START
  ///
  ///

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      notify(() => _focused = _focusNode.hasFocus);
    }
  }

  final List<String> _queues = [];

  void _checker(String value) {
    if (_indicatorVisible) {
      _queues.add(value);
      return;
    }
    _indicatorVisible = true;
    onCheck?.call(value).then((futureError) {
      _indicatorVisible = false;
      if (_queues.isNotEmpty) {
        final proxy = _queues.last;
        _queues.clear();
        _checker(proxy);
      } else {
        notify(() {
          _valid = validate;
          if (_valid) {
            final x = _valid;
            _valid = futureError.isOk && x;
            _error = !futureError.isOk && text.isNotEmpty && x;
            if (onValid != null) onValid!(_valid);
            if (onError != null) {
              if (_error) {
                errorText = onError!(futureError) ?? "";
              } else {
                errorText = onError!(errorType(value, _valid)) ?? "";
              }
            }
          }
        });
      }
    });
  }

  void _handleEditingChange(String value) {
    _initial = false;
    _valid = false;
    _error = false;
    errorText = "";
    if (onChange != null) onChange!(value);
    if (onValid != null || onError != null || onCheck != null) {
      _valid = validate;
      if (_valid && onCheck != null && !_initial) {
        _valid = false;
        _error = false;
        _checker(value);
      } else {
        _indicatorVisible = false;
        _valid = _valid && isChecked;
        _error = !_valid && text.isNotEmpty;
        if (onValid != null) onValid!(_valid);
        if (onError != null) {
          errorText = onError!(errorType(value, _valid)) ?? "";
        }
      }
    }
    notify();
  }

  void addFocusListener([VoidCallback? callback]) {
    _focusNode.addListener(() {
      _handleFocusChange();
      if (callback != null) callback();
    });
  }

  void removeFocusListener([VoidCallback? callback]) {
    _focusNode.removeListener(() {
      _handleFocusChange();
      if (callback != null) callback();
    });
  }

  void showKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

  ///
  ///
  ///
  /// BASE NOTIFIER END
  /// NOTIFIERS START
  ///
  ///
  ///

  void update() {
    if (_widgetInitialized) {
      _handleEditingChange(text);
    }
  }

  void notify([VoidCallback? callback]) {
    if (_widgetInitialized) {
      setState(() {
        if (callback != null) callback();
        state = AndrossyFieldPropertyState.from(this);
      });
    }
  }

  void setEnabled(bool value) => notify(() => _enabled = value);

  void setError(bool value) => notify(() => _error = value);

  void setFocused(bool value) => notify(() => _focused = value);

  void setReadMode(bool value) => notify(() => _readOnly = value);

  void onChangeEye() {
    if (widget.drawableEye != null) {
      notify(() => _obscureText = !obscureText);
    }
  }

  bool get activated => isFocused;

  int? get maxLines {
    switch (widget.inputType) {
      case TextInputType.datetime:
      case TextInputType.emailAddress:
      case TextInputType.name:
      case TextInputType.number:
      case TextInputType.phone:
      case TextInputType.text:
      case TextInputType.visiblePassword:
        return 1;
      case TextInputType.streetAddress:
      case TextInputType.multiline:
      case TextInputType.url:
      default:
        return null;
    }
  }

  String get text => controller.text;

  FloatingVisibility get counterVisibility =>
      widget.counterVisibility ?? FloatingVisibility.hide;

  bool get counterVisible {
    return !counterVisibility.isHide && widget.textAlign != TextAlign.center;
  }

  Alignment get floatingAlignment {
    if (widget.textAlign == TextAlign.center) {
      return Alignment.center;
    } else {
      if (widget.floatingAlignment != null) {
        return widget.floatingAlignment!;
      }
      final isRTL = widget.textDirection == TextDirection.rtl;
      return isRTL ? Alignment.centerRight : Alignment.centerLeft;
    }
  }

  TextStyle get floatingTextStyle {
    final x = defaultFloatingStyle.fromState(state) ?? defaultLabelStyle;
    if (floatingVisibility.isAlways || text.isNotEmpty) {
      return x.copyWith(fontSize: x.fontSize ?? defaultLabelStyle.fontSize);
    } else {
      return x.copyWith(
        color: Colors.transparent,
        fontSize: x.fontSize ?? defaultLabelStyle.fontSize,
      );
    }
  }

  late String? _floatingText = widget.floatingText;

  String get floatingText => _floatingText ?? hintText;

  set floatingText(String? value) => _floatingText = value;

  FloatingVisibility get floatingVisibility {
    return widget.floatingVisibility ?? FloatingVisibility.hide;
  }

  bool get floatingVisible => !floatingVisibility.isHide;

  MainAxisAlignment get footerAlignment {
    if (floatingAlignment == Alignment.center) {
      return MainAxisAlignment.center;
    } else {
      if (widget.floatingAlignment == Alignment.centerRight) {
        return MainAxisAlignment.end;
      }
      if (widget.floatingAlignment == Alignment.centerLeft) {
        return MainAxisAlignment.start;
      }
      return MainAxisAlignment.spaceBetween;
    }
  }

  bool get footerVisible {
    return widget.footerVisibility != FloatingVisibility.hide &&
        (helperTextVisible || counterVisible);
  }

  bool get helperTextVisible => hasError || helperText.isNotEmpty;

  late String? _helperText = widget.helperText;

  String get helperText => _helperText ?? '';

  set helperText(String? value) => _hintText = value;

  void setHelperText(String value) => notify(() => _helperText = value);

  late String? _hintText = widget.hintText;

  String get hintText => _hintText ?? '';

  void setHintText(String value) {
    notify(() => _hintText = value);
  }

  bool get isIndicatorVisible => onCheck != null && _indicatorVisible;

  late bool _indicatorVisible = widget.indicatorVisible ?? false;

  void setIndicatorVisibility(bool visible) {
    notify(() => _indicatorVisible = visible);
  }

  IndicatorAlignment get indicatorAlignment {
    if (widget.indicatorAlignment != null) {
      return widget.indicatorAlignment!;
    }
    final isRTL = widget.textDirection == TextDirection.rtl;
    return isRTL ? IndicatorAlignment.start : IndicatorAlignment.end;
  }

  double get underlineHeight {
    return widget.underlineHeight?.fromState(state) ?? 1;
  }

  /// DRAWABLE PROPERTIES

  dynamic get drawableEnd {
    if (widget.drawableEye != null) {
      return widget.drawableEye?.detect(obscureText);
    }
    return widget.drawableEnd?.fromState(state);
  }

  late final _drawableEndSize =
      widget.drawableEndSize ?? const AndrossyFieldProperty.all(24);

  double get drawableEndSize {
    return _drawableEndSize.fromState(state) ?? 24;
  }

  EdgeInsets get drawableEndSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space = widget.drawableEndPadding?.fromState(state) ?? 12;
    return EdgeInsets.only(
      left: !isRTL ? space : 0,
      right: isRTL ? space : 0,
    );
  }

  dynamic get drawableStart {
    return widget.drawableStart?.fromState(state);
  }

  double get drawableStartSize {
    return widget.drawableStartSize?.fromState(state) ?? 24;
  }

  EdgeInsets get drawableStartSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space = widget.drawableStartPadding?.fromState(state) ?? 12;
    return EdgeInsets.only(
      left: isRTL ? space : 0,
      right: !isRTL ? space : 0,
    );
  }

  late String? errorText = widget.errorText;

  void setErrorText(String? value) {
    notify(() => errorText = value);
  }

  bool get hasError => (errorText ?? "").isNotEmpty;

  late bool? _obscureText = widget.obscureText;

  bool get obscureText {
    return _obscureText ?? (widget.inputType == TextInputType.visiblePassword);
  }

  /// OTHERS

  dynamic get iEnd => drawableEnd?.drawable(isFocused);

  dynamic get iStart => drawableStart?.drawable(isFocused);

  String get counter {
    var currentLength = text.length;
    final maxLength = maxCharacters;
    return maxLength > 0
        ? '$currentLength / $maxLength'
        : currentLength > 0
            ? "$currentLength"
            : "";
  }

  late String characters = widget.characters ?? '';
  late String ignorableCharacters = widget.ignorableCharacters ?? '';
  late bool maxCharactersAsLimit = widget.maxCharactersAsLimit ?? true;

  List<TextInputFormatter>? get _formatter {
    return [
      ...?widget.inputFormatters,
      if (characters.isNotEmpty)
        FilteringTextInputFormatter.allow(
          RegExp("[${widget.characters}]"),
        ),
      if (ignorableCharacters.isNotEmpty)
        FilteringTextInputFormatter.deny(
          RegExp("[${widget.ignorableCharacters}]"),
        ),
      if (maxCharactersAsLimit && maxCharacters > 0)
        LengthLimitingTextInputFormatter(widget.maxCharacters),
    ];
  }

  /// CALLBACK PROPERTIES

  OnAndrossyFieldErrorCheck? get onCheck => isEnabled ? widget.onCheck : null;

  OnAndrossyFieldChanged? get onChange => isEnabled ? widget.onChanged : null;

  OnAndrossyFieldError? get onError => isEnabled ? widget.onError : null;

  late OnAndrossyFieldValid? _onValid = widget.onValid;

  OnAndrossyFieldValid? get onValid => isEnabled ? _onValid : null;

  void setOnValidListener(OnAndrossyFieldValid value) => _onValid = value;

  OnAndrossyFieldValidator? get onValidator {
    return isEnabled ? widget.onValidator : null;
  }

  AndrossyFieldPrivateCommandListener? get onAppPrivateCommand {
    return isEnabled ? widget.onAppPrivateCommand : null;
  }

  AndrossyFieldVoidListener? get onEditingComplete {
    return isEnabled ? widget.onEditingComplete : null;
  }

  AndrossyFieldSubmitListener? get onSubmitted {
    return isEnabled ? widget.onSubmitted : null;
  }

  AndrossyFieldTapOutsideListener? get onTapOutside {
    return isEnabled ? widget.onTapOutside : null;
  }
}

class _Footer extends StatelessWidget {
  final Duration? animationDuration;
  final Curve animationCurve;
  final FloatingVisibility counterVisibility;
  final bool hasError;
  final EdgeInsets floatingTextSpace;
  final TextDirection? textDirection;
  final MainAxisAlignment footerAlignment;
  final TextAlign? textAlign;
  final String? counter;
  final String? errorText;
  final String helperText;
  final TextStyle? footerTextStyle;
  final TextStyle? counterTextStyle;
  final TextStyle? errorTextStyle;
  final TextStyle? helperTextStyle;
  final bool isFocused;

  const _Footer({
    required this.animationCurve,
    required this.animationDuration,
    required this.counterVisibility,
    required this.hasError,
    required this.floatingTextSpace,
    required this.textDirection,
    required this.footerAlignment,
    required this.textAlign,
    required this.counter,
    required this.errorText,
    required this.helperText,
    required this.footerTextStyle,
    required this.counterTextStyle,
    required this.errorTextStyle,
    required this.helperTextStyle,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    final cv = counterVisibility;
    final counterVisible = !cv.isHide;
    final hasError = this.hasError;

    final footerStyle = footerTextStyle?.copyWith(
      color: footerTextStyle?.color,
    );

    final counterStyle = counterTextStyle?.copyWith(
          color: cv.isAuto && !isFocused
              ? Colors.transparent
              : counterTextStyle?.color ?? footerTextStyle?.color,
        ) ??
        footerStyle;

    final errorStyle = errorTextStyle?.copyWith(
          color: errorTextStyle?.color ?? footerTextStyle?.color,
        ) ??
        footerStyle;

    final helperStyle = helperTextStyle?.copyWith(
          color: helperTextStyle?.color ?? footerTextStyle?.color,
        ) ??
        footerStyle;

    final footerMessage = _HighlightText(
      animationDuration: null,
      animationCurve: animationCurve,
      text: hasError ? errorText : helperText,
      textAlign: textAlign,
      textDirection: textDirection,
      textStyle: hasError ? errorStyle : helperStyle,
      valid: hasError || helperText.isNotEmpty,
    );

    final child = Row(
      textDirection: textDirection,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: footerAlignment,
      children: [
        Flexible(
          child: animationDuration != null
              ? AnimatedSize(
                  alignment: textDirection == TextDirection.ltr
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: animationDuration!,
                  curve: animationCurve,
                  reverseDuration: Duration.zero,
                  child: footerMessage,
                )
              : footerMessage,
        ),
        _HighlightText(
          visible: counterVisible && textAlign != TextAlign.center,
          animationDuration: null,
          animationCurve: animationCurve,
          text: " $counter",
          textAlign: TextAlign.end,
          textDirection: textDirection,
          textStyle: hasError ? errorStyle : counterStyle,
          valid: counterVisible && (isFocused || cv.isAlways),
        ),
      ],
    );
    if (animationDuration != null) {
      return AnimatedContainer(
        duration: animationDuration!,
        curve: animationCurve,
        width: double.infinity,
        padding: floatingTextSpace.copyWith(bottom: 0),
        child: child,
      );
    }
    return Container(
      width: double.infinity,
      padding: floatingTextSpace.copyWith(bottom: 0),
      child: child,
    );
  }
}

class _Header extends StatelessWidget {
  final Duration? animationDuration;
  final Curve animationCurve;
  final Alignment? floatingAlignment;
  final EdgeInsets floatingTextSpace;
  final String floatingText;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? floatingTextStyle;

  const _Header({
    required this.animationCurve,
    required this.animationDuration,
    required this.floatingAlignment,
    required this.floatingTextSpace,
    required this.floatingText,
    required this.textAlign,
    required this.textDirection,
    required this.floatingTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: floatingAlignment,
      padding: floatingTextSpace.copyWith(top: 0),
      child: _HighlightText(
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        text: floatingText,
        textAlign: textAlign,
        textDirection: textDirection,
        textStyle: floatingTextStyle,
      ),
    );
  }
}

class _HighlightText extends StatelessWidget {
  final Duration? animationDuration;
  final Curve animationCurve;
  final bool valid;
  final bool visible;
  final String? text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? textStyle;

  const _HighlightText({
    required this.animationCurve,
    required this.animationDuration,
    this.visible = true,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.textStyle,
    this.valid = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = textStyle ??
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: valid ? Colors.grey : Colors.transparent,
        );
    return Visibility(
      visible: visible,
      child: animationDuration != null
          ? AnimatedDefaultTextStyle(
              duration: animationDuration!,
              curve: animationCurve,
              style: style,
              child: Text(
                text ?? "",
                textAlign: textAlign,
                textDirection: textDirection,
              ),
            )
          : Text(
              text ?? "",
              textAlign: textAlign,
              textDirection: textDirection,
              style: style,
            ),
    );
  }
}

class _Icon extends StatelessWidget {
  final Duration? animationDuration;
  final Curve animationCurve;
  final bool visibility;
  final dynamic icon;
  final double size;
  final Color? tint;
  final EdgeInsets margin;
  final VoidCallback? onToggleClick;

  const _Icon({
    required this.animationCurve,
    required this.animationDuration,
    required this.visibility,
    required this.icon,
    required this.size,
    required this.tint,
    required this.margin,
    this.onToggleClick,
  });

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();

    Widget child = AndrossyIcon(
      key: ValueKey(tint.hashCode ^ icon.hashCode),
      icon: icon,
      size: size,
      color: tint,
    );

    if (animationDuration != null) {
      child = AnimatedSwitcher(
        duration: animationDuration!,
        switchInCurve: animationCurve,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: child,
      );
    }
    child = Padding(
      padding: margin,
      child: child,
    );
    if (onToggleClick != null) {
      child = GestureDetector(
        onTap: onToggleClick,
        child: child,
      );
    }
    return child;
  }
}

class _Underline extends StatelessWidget {
  final Duration? animationDuration;
  final Curve animationCurve;
  final Color? color;
  final bool active;
  final double height;

  const _Underline({
    required this.animationCurve,
    required this.animationDuration,
    required this.color,
    required this.active,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (animationDuration != null) {
      return AnimatedContainer(
        duration: animationDuration!,
        curve: animationCurve,
        margin: EdgeInsets.only(bottom: active ? 0 : height),
        decoration: BoxDecoration(color: color),
        height: active ? height * 2 : height,
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: active ? 0 : height),
      decoration: BoxDecoration(color: color),
      height: active ? height * 2 : height,
    );
  }
}

enum IndicatorAlignment {
  start,
  end;

  bool get isStart => this == start;

  bool get isEnd => this == end;
}

enum FloatingVisibility {
  auto,
  hide,
  always;

  bool get isAuto => this == auto;

  bool get isHide => this == hide;

  bool get isAlways => this == always;
}

enum AndrossyFieldError {
  none,
  alreadyFound,
  empty,
  error,
  invalid,
  maximum,
  minimum,
  networkError,
  unmodified;

  bool get isOk => this == AndrossyFieldError.none;

  bool get isAlreadyFound => this == AndrossyFieldError.alreadyFound;

  bool get isEmpty => this == AndrossyFieldError.empty;

  bool get isError => this == AndrossyFieldError.error;

  bool get isInvalid => this == AndrossyFieldError.invalid;

  bool get isMaximum => this == AndrossyFieldError.maximum;

  bool get isMinimum => this == AndrossyFieldError.minimum;

  bool get isNetworkError => this == AndrossyFieldError.networkError;

  bool get isUnmodified => this == AndrossyFieldError.unmodified;

  factory AndrossyFieldError.from(AndrossyFieldState state) {
    if (state.text.isEmpty && !state._initial) {
      return AndrossyFieldError.empty;
    } else if (!state._valid) {
      final length = state.text.length;
      if (state.maxCharacters > 0 && state.maxCharacters < length) {
        return AndrossyFieldError.maximum;
      } else if ((state.widget.minCharacters ?? 0) > 0 &&
          (state.widget.minCharacters ?? 0) > length) {
        return AndrossyFieldError.minimum;
      } else {
        return AndrossyFieldError.invalid;
      }
    } else {
      return AndrossyFieldError.none;
    }
  }
}

class AndrossyFieldTweenProperty<T> {
  final T active;
  final T inactive;

  const AndrossyFieldTweenProperty({
    required this.active,
    T? inactive,
  }) : inactive = inactive ?? active;

  const AndrossyFieldTweenProperty.all(T value) : this(active: value);

  T detect(bool activated) {
    return activated ? active : inactive;
  }
}

class AndrossyFieldProperty<T> {
  final T? enabled;
  final T? _disabled;
  final T? _error;
  final T? _errorFocused;
  final T? _focused;
  final T? _loading;
  final T? _loadingFocused;
  final T? _readOnly;
  final T? _valid;
  final T? _validFocused;

  T? get disabled => _disabled ?? enabled;

  T? get error => _error ?? enabled;

  T? get errorFocused => _errorFocused ?? _error ?? focused;

  T? get focused => _focused ?? enabled;

  T? get loading => _loading ?? enabled;

  T? get loadingFocused => _loadingFocused ?? _loading ?? focused;

  T? get valid => _valid ?? enabled;

  T? get validFocused => _validFocused ?? _valid ?? focused;

  T? get readOnly => _readOnly ?? disabled;

  const AndrossyFieldProperty({
    this.enabled,
    T? disabled,
    T? error,
    T? errorFocused,
    T? focused,
    T? loading,
    T? loadingFocused,
    T? readOnly,
    T? valid,
    T? validFocused,
  })  : _disabled = disabled,
        _error = error,
        _errorFocused = errorFocused,
        _focused = focused,
        _loading = loading,
        _loadingFocused = loadingFocused,
        _readOnly = readOnly,
        _validFocused = validFocused,
        _valid = valid;

  const AndrossyFieldProperty.none() : this();

  const AndrossyFieldProperty.all(T? value) : this(enabled: value);

  AndrossyFieldProperty<T> copyWith({
    T? disabled,
    T? enabled,
    T? error,
    T? errorFocused,
    T? focused,
    T? loading,
    T? loadingFocused,
    T? readOnly,
    T? valid,
    T? validFocused,
  }) {
    return AndrossyFieldProperty<T>(
      disabled: disabled ?? _disabled,
      enabled: enabled ?? this.enabled,
      error: error ?? _error,
      errorFocused: errorFocused ?? _errorFocused,
      focused: focused ?? _focused,
      loading: loading ?? _loading,
      loadingFocused: loadingFocused ?? _loadingFocused,
      readOnly: readOnly ?? _readOnly,
      valid: valid ?? _valid,
      validFocused: validFocused ?? _validFocused,
    );
  }

  AndrossyFieldProperty<T?> _defaults({
    T? disabled,
    T? enabled,
    T? error,
    T? errorFocused,
    T? focused,
    T? loading,
    T? loadingFocused,
    T? readOnly,
    T? valid,
    T? validFocused,
  }) {
    return AndrossyFieldProperty<T>(
      disabled: _disabled ?? disabled ?? this.enabled,
      enabled: this.enabled ?? enabled,
      error: _error ?? error,
      errorFocused: _errorFocused ?? errorFocused,
      focused: _focused ?? focused,
      loading: _loading ?? loading,
      loadingFocused: _loadingFocused ?? loadingFocused,
      readOnly: _readOnly ?? readOnly,
      valid: _valid ?? valid,
      validFocused: _validFocused ?? validFocused,
    );
  }

  T? fromState(AndrossyFieldPropertyState state) {
    switch (state) {
      case AndrossyFieldPropertyState.disabled:
        return disabled;
      case AndrossyFieldPropertyState.enabled:
        return enabled;
      case AndrossyFieldPropertyState.error:
        return error;
      case AndrossyFieldPropertyState.errorFocused:
        return errorFocused;
      case AndrossyFieldPropertyState.focused:
        return focused;
      case AndrossyFieldPropertyState.loading:
        return loading;
      case AndrossyFieldPropertyState.loadingFocused:
        return loadingFocused;
      case AndrossyFieldPropertyState.readOnly:
        return readOnly;
      case AndrossyFieldPropertyState.valid:
        return valid;
      case AndrossyFieldPropertyState.validFocused:
        return validFocused;
    }
  }

  @override
  int get hashCode {
    return _disabled.hashCode ^
        enabled.hashCode ^
        _error.hashCode ^
        _errorFocused.hashCode ^
        _focused.hashCode ^
        _readOnly.hashCode ^
        _loading.hashCode ^
        _loadingFocused.hashCode ^
        _valid.hashCode ^
        _validFocused.hashCode;
  }

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

extension on AndrossyFieldProperty<Color?>? {
  AndrossyFieldProperty<Color?> get use {
    return this ?? const AndrossyFieldProperty.none();
  }
}

extension on AndrossyFieldProperty<TextStyle?>? {
  AndrossyFieldProperty<TextStyle?> get use {
    return this ?? const AndrossyFieldProperty.none();
  }
}

enum AndrossyFieldPropertyState {
  disabled,
  enabled,
  error,
  errorFocused,
  focused,
  loading,
  loadingFocused,
  valid,
  validFocused,
  readOnly;

  factory AndrossyFieldPropertyState.from(AndrossyFieldState state) {
    if (state.isEnabled) {
      if (state.isFocused) {
        if (state.isIndicatorVisible) {
          return loadingFocused;
        } else if (state._valid) {
          return validFocused;
        } else if (state.isError) {
          return errorFocused;
        } else {
          return focused;
        }
      } else {
        if (state.isIndicatorVisible) {
          return loading;
        } else if (state._valid) {
          return valid;
        } else if (state.isError) {
          return error;
        } else {
          return enabled;
        }
      }
    } else if (state.isReadMode) {
      return readOnly;
    } else {
      return disabled;
    }
  }
}
