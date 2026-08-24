import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icon.dart';

const _kDefaultBorderWidth = 1.5;
const _kFocusedBorderWidth = 2.0;
const _kDefaultCursorWidth = 2.0;
const _kDefaultDrawablePadding = 12.0;
const _kDefaultIconSize = 24.0;
const _kDefaultIndicatorSize = 24.0;
const _kDefaultIndicatorStrokeWidth = 2.0;
const _kDefaultScrollPadding = EdgeInsets.all(20.0);
const _kDefaultFieldPadding = EdgeInsets.symmetric(vertical: 8.0);
const _kDefaultLabelStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

bool _hasText(String? value) => value?.isNotEmpty ?? false;

typedef OnAndrossyFieldErrorCheck = Future<AndrossyFieldError> Function(
    String value);
typedef OnAndrossyFieldChanged = void Function(String value);
typedef OnAndrossyFieldError = String? Function(AndrossyFieldError error);
typedef OnAndrossyFieldValid = void Function(bool value);
typedef OnAndrossyFieldValidator = bool Function(String value);

typedef AndrossyFieldDrawableBuilder = Widget Function(
    BuildContext context, AndrossyFieldState state);

typedef AndrossyFieldContextMenuBuilder = Widget Function(
    BuildContext context, EditableTextState state);

typedef AndrossyFieldPrivateCommandListener = void Function(
    String value, Map<String, dynamic> params);

typedef AndrossyFieldTapListener = void Function();
typedef AndrossyFieldVoidListener = void Function();
typedef AndrossyFieldCheckListener = Function(String tag, bool valid);
typedef AndrossyFieldSelectionChangeListener = void Function(
    TextSelection selection, SelectionChangedCause? cause);
typedef AndrossyFieldSubmitListener = void Function(String value);
typedef AndrossyFieldTapOutsideListener = void Function(PointerDownEvent event);
typedef AndrossyFieldTapUpOutsideListener = void Function(PointerUpEvent event);

/// A production-ready text input with Androssy state styling, drawables,
/// validation, helper/footer text, and the important behavior hooks from
/// Flutter's [TextField].
///
/// Use [AndrossyField] anywhere you would normally use a [TextField] but need
/// app-level consistency: state-aware colors, icons, async availability checks,
/// shared form defaults, or a custom footer/counter.
///
/// Common use cases:
///
/// Basic styled input:
///
/// ```dart
/// AndrossyField(
///   controller: nameController,
///   hintText: 'Display name',
///   inputAction: TextInputAction.next,
///   inputType: TextInputType.name,
///   drawableStart: const AndrossyFieldProperty(
///     enabled: Icons.person_outline,
///     focused: Icons.person,
///   ),
/// )
/// ```
///
/// Async validation with stale-result protection:
///
/// ```dart
/// AndrossyField(
///   hintText: 'Username',
///   characters: 'abcdefghijklmnopqrstuvwxyz0123456789_',
///   minCharacters: 3,
///   maxCharacters: 18,
///   loadingText: 'Checking username',
///   onValidator: (value) => value.length >= 3,
///   onCheck: (value) async {
///     final taken = await repository.isUsernameTaken(value);
///     return taken ? AndrossyFieldError.alreadyFound : AndrossyFieldError.none;
///   },
///   onError: (error) => switch (error) {
///     AndrossyFieldError.alreadyFound => 'Username already taken',
///     AndrossyFieldError.minimum => 'Too short',
///     AndrossyFieldError.none => null,
///     _ => 'Invalid username',
///   },
/// )
/// ```
///
/// Password field with a visibility toggle:
///
/// ```dart
/// AndrossyField(
///   hintText: 'Password',
///   inputType: TextInputType.visiblePassword,
///   obscureText: true,
///   drawableEye: const AndrossyFieldTweenProperty(
///     inactive: Icons.visibility_off_outlined,
///     active: Icons.visibility_outlined,
///   ),
/// )
/// ```
///
/// Custom counter in the Androssy footer:
///
/// ```dart
/// AndrossyField(
///   maxCharacters: 140,
///   maxCharactersAsLimit: false,
///   counterVisibility: FloatingVisibility.always,
///   buildCounter: (context, {
///     required currentLength,
///     required maxLength,
///     required isFocused,
///   }) {
///     return Text('$currentLength/${maxLength ?? '-'}');
///   },
/// )
/// ```
///
/// Keyboard behavior:
///
/// [autoDismissKeyboard] defaults to true, so a focused field releases focus
/// when its route/page becomes inactive or the widget is disposed. Set it to
/// false only for flows that intentionally keep focus across route transitions.
class AndrossyField extends StatefulWidget {
  /// GLOBAL PROPERTIES
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

  /// TEXT FIELD GLOBAL PROPERTIES
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

  /// Builds a custom counter inside the Androssy footer.
  ///
  /// This mirrors [TextField.buildCounter], but is rendered by [_Footer] so it
  /// works with [counterVisibility], [footerStyle], and Androssy helper/error
  /// layout instead of Flutter's native [InputDecoration] counter slot.
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
  final TextDirection? textDirection;
  final Brightness? keyboardAppearance;

  /// LOCAL PROPERTIES
  final bool? enabled;
  final bool? autoDisposeMode;

  /// Releases keyboard focus when the field's route becomes inactive or when
  /// the widget is disposed.
  ///
  /// Defaults to true. Keep it true for normal page navigation so the keyboard
  /// does not remain open during route transitions. Set false only for custom
  /// flows that intentionally preserve focus across route changes.
  final bool? autoDismissKeyboard;
  final bool? canRequestFocus;

  /// Allowed characters for this field.
  ///
  /// When non-empty, input is filtered with [FilteringTextInputFormatter.allow].
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

  /// Characters that should be denied even if other formatters allow them.
  final String? ignorableCharacters;

  /// Maximum visible character count for validation, counter, and optional
  /// input limiting.
  ///
  /// Use [maxCharactersAsLimit] to decide whether this becomes a hard
  /// [LengthLimitingTextInputFormatter] limit.
  final int? maxCharacters;

  /// Whether [maxCharacters] should be enforced by an input formatter.
  ///
  /// Set false for soft-limit fields such as post composers where users may
  /// type over the limit and see validation/counter feedback.
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
  final AndrossyFieldTapListener? onTap;
  final AndrossyFieldTapOutsideListener? onTapOutside;
  final AndrossyFieldTapUpOutsideListener? onTapUpOutside;
  final bool? onTapAlwaysCalled;

  /// CALLBACK LOCAL PROPERTIES

  /// Runs an async validation after local validation succeeds.
  ///
  /// Stale async results are ignored automatically when the user changes text
  /// before a previous check completes.
  final OnAndrossyFieldErrorCheck? onCheck;
  final OnAndrossyFieldChanged? onChanged;

  /// Maps an [AndrossyFieldError] to footer error text.
  ///
  /// Return null or an empty string to keep the footer clear.
  final OnAndrossyFieldError? onError;

  /// Emits validity changes after local and async validation state updates.
  final OnAndrossyFieldValid? onValid;

  /// Local synchronous validator used before [onCheck].
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
    this.height,
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
    this.width,

    /// TEXT FIELD GLOBAL PROPERTIES
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
    this.textDirection,
    this.keyboardAppearance,

    /// LOCAL PROPERTIES
    this.enabled,
    this.autoDisposeMode,
    this.autoDismissKeyboard,
    this.canRequestFocus,
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
    this.onTap,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onTapAlwaysCalled,

    /// CALLBACK LOCAL PROPERTIES
    this.onCheck,
    this.onChanged,
    this.onError,
    this.onValid,
    this.onValidator,
  });

  /// Returns a copy where this field's explicitly provided values win over
  /// inherited defaults.
  ///
  /// This is mainly used by [AndrossyForm] to provide app/section-level field
  /// defaults without overwriting a child field's local configuration.
  ///
  /// ```dart
  /// final inherited = AndrossyField(
  ///   hintText: 'Email',
  /// ).defaultWith(
  ///   borderColor: const AndrossyFieldProperty.auto(),
  ///   floatingVisibility: FloatingVisibility.always,
  /// );
  /// ```
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
    double? height,
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
    double? width,

    /// TEXT FIELD GLOBAL PROPERTIES
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
    TextDirection? textDirection,
    Brightness? keyboardAppearance,

    /// LOCAL PROPERTIES
    bool? enabled,
    bool? autoDisposeMode,
    bool? autoDismissKeyboard,
    bool? canRequestFocus,
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
    AndrossyFieldTapListener? onTap,
    AndrossyFieldTapOutsideListener? onTapOutside,
    AndrossyFieldTapUpOutsideListener? onTapUpOutside,
    bool? onTapAlwaysCalled,

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
      height: this.height ?? height,
      helperStyle: this.helperStyle ?? helperStyle,
      hintColor: this.hintColor ?? hintColor,
      indicatorAlignment: this.indicatorAlignment ?? indicatorAlignment,
      indicatorSize: this.indicatorSize ?? indicatorSize,
      indicatorStrokeWidth: this.indicatorStrokeWidth ?? indicatorStrokeWidth,
      indicatorStrokeBackground:
          this.indicatorStrokeBackground ?? indicatorStrokeBackground,
      indicatorStrokeColor: this.indicatorStrokeColor ?? indicatorStrokeColor,
      loadingText: this.loadingText ?? loadingText,
      primaryColor: this.primaryColor ?? primaryColor,
      secondaryColor: this.secondaryColor ?? secondaryColor,
      strutStyle: this.strutStyle ?? strutStyle,
      underlineColor: this.underlineColor ?? underlineColor,
      underlineHeight: this.underlineHeight ?? underlineHeight,
      width: this.width ?? width,

      /// TEXT FIELD GLOBAL PROPERTIES
      clipBehavior: this.clipBehavior ?? clipBehavior,
      contentInsertionConfiguration:
          this.contentInsertionConfiguration ?? contentInsertionConfiguration,
      contextMenuBuilder: this.contextMenuBuilder ?? contextMenuBuilder,
      groupId: this.groupId ?? groupId,
      statesController: this.statesController ?? statesController,
      textAlignVertical: this.textAlignVertical ?? textAlignVertical,
      cursorColor: this.cursorColor ?? cursorColor,
      cursorErrorColor: this.cursorErrorColor ?? cursorErrorColor,
      cursorHeight: this.cursorHeight ?? cursorHeight,
      cursorOpacityAnimates:
          this.cursorOpacityAnimates ?? cursorOpacityAnimates,
      cursorRadius: this.cursorRadius ?? cursorRadius,
      cursorWidth: this.cursorWidth ?? cursorWidth,
      dragStartBehavior: this.dragStartBehavior ?? dragStartBehavior,
      enableIMEPersonalizedLearning:
          this.enableIMEPersonalizedLearning ?? enableIMEPersonalizedLearning,
      enableInteractiveSelection:
          this.enableInteractiveSelection ?? enableInteractiveSelection,
      enableSuggestions: this.enableSuggestions ?? enableSuggestions,
      hintLocales: this.hintLocales ?? hintLocales,
      ignorePointers: this.ignorePointers ?? ignorePointers,
      magnifierConfiguration:
          this.magnifierConfiguration ?? magnifierConfiguration,
      maxLengthEnforcement: this.maxLengthEnforcement ?? maxLengthEnforcement,
      mouseCursor: this.mouseCursor ?? mouseCursor,
      buildCounter: this.buildCounter ?? buildCounter,
      obscuringCharacter: this.obscuringCharacter ?? obscuringCharacter,
      scribbleEnabled: this.scribbleEnabled ?? scribbleEnabled,
      stylusHandwritingEnabled:
          this.stylusHandwritingEnabled ?? stylusHandwritingEnabled,
      scrollPadding: this.scrollPadding ?? scrollPadding,
      scrollPhysics: this.scrollPhysics ?? scrollPhysics,
      selectAllOnFocus: this.selectAllOnFocus ?? selectAllOnFocus,
      selectionControls: this.selectionControls ?? selectionControls,
      selectionHeightStyle: this.selectionHeightStyle ?? selectionHeightStyle,
      selectionWidthStyle: this.selectionWidthStyle ?? selectionWidthStyle,
      smartDashesType: this.smartDashesType ?? smartDashesType,
      smartQuotesType: this.smartQuotesType ?? smartQuotesType,
      spellCheckConfiguration:
          this.spellCheckConfiguration ?? spellCheckConfiguration,
      style: this.style ?? style,
      textAlign: this.textAlign ?? textAlign,
      textCapitalization: this.textCapitalization ?? textCapitalization,
      textDirection: this.textDirection ?? textDirection,
      keyboardAppearance: this.keyboardAppearance ?? keyboardAppearance,

      /// LOCAL PROPERTIES
      enabled: this.enabled ?? enabled,
      autoDisposeMode: this.autoDisposeMode ?? autoDisposeMode,
      autoDismissKeyboard: this.autoDismissKeyboard ?? autoDismissKeyboard,
      canRequestFocus: this.canRequestFocus ?? canRequestFocus,
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
      inputAction: this.inputAction ?? inputAction ?? textInputAction,
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
      onTap: this.onTap ?? onTap,
      onTapOutside: this.onTapOutside ?? onTapOutside,
      onTapUpOutside: this.onTapUpOutside ?? onTapUpOutside,
      onTapAlwaysCalled: this.onTapAlwaysCalled ?? onTapAlwaysCalled,

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

/// Runtime controller for an [AndrossyField].
///
/// Access it with a `GlobalKey<AndrossyFieldState>` when a form needs to update
/// helper/error text, read validity, show/hide keyboard, or toggle state from
/// business logic.
///
/// ```dart
/// final fieldKey = GlobalKey<AndrossyFieldState>();
///
/// AndrossyField(key: fieldKey);
///
/// fieldKey.currentState?.setErrorText('Try another value');
/// fieldKey.currentState?.showKeyboard(context);
/// ```
class AndrossyFieldState extends State<AndrossyField> {
  /// WIDGET BUILDER START
  ///
  ///

  late TextEditingController controller;
  late FocusNode _focusNode;
  late bool _ownsController;
  late bool _ownsFocusNode;
  bool _widgetInitialized = false;
  bool _focusListenerAttached = false;
  String _lastText = '';
  int _checkSerial = 0;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    controller = widget.controller ?? TextEditingController();
    if (widget.text != null) {
      _setControllerText(widget.text!);
    }
    _lastText = controller.text;
    controller.addListener(_handleControllerChange);

    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _attachFocusListener();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _widgetInitialized = true;
      _focused = _focusNode.hasFocus;
      _handleEditingChange(text, markInteracted: false);
    });
  }

  @override
  void didUpdateWidget(covariant AndrossyField oldWidget) {
    super.didUpdateWidget(oldWidget);

    var shouldValidate = false;

    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_handleControllerChange);
      final previousController = controller;
      final previousOwned = _ownsController;
      final previousText = previousController.text;

      _ownsController = widget.controller == null;
      controller = widget.controller ??
          TextEditingController(text: widget.text ?? previousText);
      if (widget.text != null) {
        _setControllerText(widget.text!);
      }
      _lastText = controller.text;
      controller.addListener(_handleControllerChange);

      if (previousOwned || (oldWidget.autoDisposeMode ?? false)) {
        previousController.dispose();
      }
      shouldValidate = true;
    } else if (widget.text != null && widget.text != oldWidget.text) {
      _setControllerText(widget.text!);
      shouldValidate = true;
    }

    if (oldWidget.focusNode != widget.focusNode) {
      _detachFocusListener();
      final previousFocusNode = _focusNode;
      final previousOwned = _ownsFocusNode;

      _ownsFocusNode = widget.focusNode == null;
      _focusNode = widget.focusNode ?? FocusNode();
      _focused = _focusNode.hasFocus;
      _attachFocusListener();

      if (previousOwned || (oldWidget.autoDisposeMode ?? false)) {
        previousFocusNode.dispose();
      }
    }

    if (widget.enabled != oldWidget.enabled && widget.enabled != null) {
      _enabled = widget.enabled!;
      if (!_enabled) {
        _cancelPendingCheck();
        _focusNode.unfocus();
      }
      shouldValidate = true;
    }
    if (widget.readOnly != oldWidget.readOnly && widget.readOnly != null) {
      _readOnly = widget.readOnly!;
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
    }
    if (widget.floatingText != oldWidget.floatingText) {
      _floatingText = widget.floatingText;
    }
    if (widget.helperText != oldWidget.helperText) {
      _helperText = widget.helperText;
    }
    if (widget.hintText != oldWidget.hintText) {
      _hintText = widget.hintText;
    }
    if (widget.errorText != oldWidget.errorText) {
      _setLocalErrorText(widget.errorText);
    }
    if (widget.indicatorVisible != oldWidget.indicatorVisible) {
      _indicatorVisible = widget.indicatorVisible ?? false;
    }
    if (widget.maxCharacters != oldWidget.maxCharacters) {
      maxCharacters = widget.maxCharacters ?? 0;
      shouldValidate = true;
    }
    if (widget.minCharacters != oldWidget.minCharacters) {
      shouldValidate = true;
    }
    if (widget.onCheck != oldWidget.onCheck ||
        widget.onValidator != oldWidget.onValidator) {
      _cancelPendingCheck();
      shouldValidate = true;
    }
    if (widget.onError != oldWidget.onError) {
      shouldValidate = true;
    }
    if (widget.characters != oldWidget.characters) {
      characters = widget.characters ?? '';
    }
    if (widget.ignorableCharacters != oldWidget.ignorableCharacters) {
      ignorableCharacters = widget.ignorableCharacters ?? '';
    }
    if (widget.maxCharactersAsLimit != oldWidget.maxCharactersAsLimit) {
      maxCharactersAsLimit = widget.maxCharactersAsLimit ?? true;
    }

    state = AndrossyFieldPropertyState.from(this);

    if (shouldValidate && _widgetInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _handleEditingChange(text, markInteracted: false);
      });
    }
  }

  bool get _disposeExternalResources => widget.autoDisposeMode ?? false;

  bool get _autoDismissKeyboard => widget.autoDismissKeyboard ?? true;

  void _cancelPendingCheck() {
    _checkSerial++;
    _checking = false;
  }

  void _dismissKeyboardIfFocused() {
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  void _dismissKeyboardForInactiveRoute() {
    if (!_autoDismissKeyboard || !_focusNode.hasFocus) return;

    final isCurrent = ModalRoute.isCurrentOf(context);
    final isActive = ModalRoute.isActiveOf(context);
    if (isCurrent != false && isActive != false) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _dismissKeyboardIfFocused();
    });
  }

  void _setControllerText(String value) {
    if (controller.text == value) return;
    final offset = controller.selection.baseOffset;
    final safeOffset =
        offset < 0 ? value.length : offset.clamp(0, value.length).toInt();

    _lastText = value;
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: safeOffset),
    );
  }

  void _disposeOwnedResources() {
    _cancelPendingCheck();
    controller.removeListener(_handleControllerChange);
    _detachFocusListener(clearCallbacks: true);

    if (_ownsController || _disposeExternalResources) {
      controller.dispose();
    }
    if (_ownsFocusNode || _disposeExternalResources) {
      _focusNode.dispose();
    }
  }

  @override
  void dispose() {
    _widgetInitialized = false;
    if (_autoDismissKeyboard) _dismissKeyboardIfFocused();
    _disposeOwnedResources();
    super.dispose();
  }

  late AndrossyFieldPropertyState state = AndrossyFieldPropertyState.from(this);

  ThemeData get theme => Theme.of(context);

  Color get primaryColor => widget.primaryColor ?? theme.primaryColor;

  Color get errorColor =>
      widget.errorColor ??
      (theme.brightness == Brightness.dark
          ? Colors.red
          : const Color(0xFFFF7769));

  Color get secondaryColor =>
      widget.secondaryColor ??
      (Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF616161)
          : const Color(0xFFBBBBBB));

  TextStyle get defaultLabelStyle => _kDefaultLabelStyle;

  AndrossyFieldProperty<TextStyle?> get defaultFloatingStyle =>
      widget.floatingStyle.use._defaults(
        enabled: defaultLabelStyle.copyWith(color: secondaryColor),
        focused: defaultLabelStyle.copyWith(color: primaryColor),
        disabled: defaultLabelStyle.copyWith(color: secondaryColor),
        error: defaultLabelStyle.copyWith(color: errorColor),
      );

  AndrossyFieldProperty<TextStyle?> get defaultFooterStyle =>
      widget.footerStyle.use._defaults(
        enabled: defaultLabelStyle.copyWith(color: secondaryColor),
        focused: defaultLabelStyle.copyWith(color: primaryColor),
        disabled: defaultLabelStyle.copyWith(color: secondaryColor),
        error: defaultLabelStyle.copyWith(color: errorColor),
      );

  AndrossyFieldProperty<Color?> get defaultBorderColor =>
      widget.borderColor.use._defaults(
        enabled: primaryColor.withValues(alpha: 0.1),
        focused: primaryColor,
        disabled: secondaryColor.withAlpha(20),
        errorFocused: errorColor,
        error: errorColor.withValues(alpha: 0.25),
      );

  AndrossyFieldProperty<Color?> get defaultCursorColor =>
      widget.cursorColor.use._defaults(
        enabled: secondaryColor,
        focused: primaryColor,
        error: errorColor,
        disabled: secondaryColor,
      );

  Color get cursorColor {
    if ((isError || hasError) && widget.cursorErrorColor != null) {
      return widget.cursorErrorColor!;
    }
    return defaultCursorColor.fromState(state) ?? primaryColor;
  }

  AndrossyFieldProperty<Color?> get defaultDrawableStartColor =>
      widget.drawableStartTint.use._defaults(
        enabled: secondaryColor,
        focused: primaryColor,
        disabled: secondaryColor,
        error: errorColor,
      );

  AndrossyFieldProperty<Color?> get defaultDrawableEndColor =>
      widget.drawableEndTint.use._defaults(
        enabled: secondaryColor,
        focused: primaryColor,
        disabled: secondaryColor,
        error: errorColor,
      );

  AndrossyFieldProperty<Color?> get defaultIndicatorColor =>
      widget.indicatorStrokeColor.use._defaults(
        enabled: secondaryColor,
        focused: primaryColor,
        disabled: secondaryColor,
        error: errorColor,
      );

  AndrossyFieldProperty<Color?> get defaultIndicatorBackgroundColor =>
      widget.indicatorStrokeBackground.use._defaults(
        enabled: secondaryColor.withAlpha(10),
        focused: primaryColor.withAlpha(20),
      );

  AndrossyFieldProperty<Color?> get defaultUnderlineColor =>
      widget.underlineColor.use._defaults(
        enabled: secondaryColor,
        focused: primaryColor,
        disabled: secondaryColor,
        error: errorColor,
      );

  Curve get animationCurve => widget.animationCurve ?? Curves.linear;

  Duration? get animationDuration => widget.animationDuration;

  double get indicatorSize => widget.indicatorSize ?? _kDefaultIndicatorSize;

  double get _inactiveBorderWidth {
    return widget.borderWidth?.inactive ?? _kDefaultBorderWidth;
  }

  double get _activeBorderWidth {
    return widget.borderWidth?.active ?? _kFocusedBorderWidth;
  }

  double get _reservedBorderWidth {
    final inactive = _inactiveBorderWidth;
    final active = _activeBorderWidth;
    return active > inactive ? active : inactive;
  }

  bool get _usesStableDefaultBorder {
    return isUnderlineHide &&
        widget.decoration == null &&
        !(widget.borderColor?._none ?? false);
  }

  EdgeInsets get _effectiveContentPadding {
    final padding = widget.contentPadding ?? _kDefaultFieldPadding;
    if (!_usesStableDefaultBorder) return padding;
    final borderWidth = _reservedBorderWidth;
    return EdgeInsets.fromLTRB(
      padding.left + borderWidth,
      padding.top + borderWidth,
      padding.right + borderWidth,
      padding.bottom + borderWidth,
    );
  }

  Border? _border(AndrossyFieldPropertyState state) {
    if (widget.borderColor?._none ?? false) return null;
    return Border.all(
      color: defaultBorderColor.fromState(state) ?? Colors.grey,
      width: isFocused ? _activeBorderWidth : _inactiveBorderWidth,
    );
  }

  TextStyle get _style => widget.style ?? const TextStyle();

  TextStyle get style {
    final base = _style;
    return base.copyWith(
      fontSize: base.fontSize ?? 18,
      height: base.height ?? 1.2,
      color: isEnabled ? base.color : base.color?.withAlpha(150),
    );
  }

  TextStyle get hintStyle {
    return style.copyWith(
      color: text.isNotEmpty
          ? Colors.transparent
          : widget.hintColor ?? secondaryColor.withAlpha(100),
    );
  }

  Widget defaultIndicator(
    AndrossyFieldPropertyState state, [
    IndicatorAlignment? alignment,
  ]) {
    final defaultColor = defaultIndicatorColor.fromState(state);
    return Container(
      width: indicatorSize,
      height: indicatorSize,
      padding: EdgeInsets.all(indicatorSize * 0.05),
      margin: (alignment ?? indicatorAlignment).isStart
          ? drawableStartSpace
          : drawableEndSpace,
      child: CircularProgressIndicator(
        strokeWidth:
            widget.indicatorStrokeWidth ?? _kDefaultIndicatorStrokeWidth,
        color: defaultColor,
        strokeCap: StrokeCap.round,
        backgroundColor: defaultIndicatorBackgroundColor.fromState(state) ??
            defaultColor?.withAlpha(20),
      ),
    );
  }

  Widget _indicator(AndrossyFieldPropertyState state, IndicatorAlignment side) {
    final indicator = widget.indicator;
    if (indicator == null) {
      return defaultIndicator(state, side);
    }
    return Padding(
      padding: side.isStart ? drawableStartSpace : drawableEndSpace,
      child: indicator,
    );
  }

  Widget _attach(BuildContext context, AndrossyFieldPropertyState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: widget.textDirection,
      children: [
        _leading(context, state),
        _input(state),
        _trailing(context, state),
      ],
    );
  }

  Widget _leading(BuildContext context, AndrossyFieldPropertyState state) {
    if (isIndicatorVisible && indicatorAlignment.isStart) {
      return _indicator(state, IndicatorAlignment.start);
    }
    if (drawableStartVisible && widget.drawableStartBuilder != null) {
      return widget.drawableStartBuilder!(context, this);
    }
    return _Icon(
      animationCurve: animationCurve,
      animationDuration: animationDuration,
      visibility: drawableStartVisible && drawableStart != null,
      icon: drawableStart,
      size: drawableStartSize,
      tint: defaultDrawableStartColor.fromState(state),
      margin: drawableStartSpace,
    );
  }

  Widget _input(AndrossyFieldPropertyState state) {
    return Expanded(
      child: TextField(
        canRequestFocus: canRequestKeyboardFocus,
        enabled: isEnabled,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          isCollapsed: true,
          hintText: hintText,
          hintStyle: hintStyle,
          hintTextDirection: widget.textDirection,
        ),
        autocorrect: widget.autocorrect ?? true,
        autofillHints: widget.autofillHints,
        autofocus: widget.autoFocus ?? false,
        clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        controller: controller,
        cursorColor: cursorColor,
        cursorErrorColor: widget.cursorErrorColor,
        cursorHeight: widget.cursorHeight,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth ?? _kDefaultCursorWidth,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        contextMenuBuilder: widget.contextMenuBuilder,
        dragStartBehavior: widget.dragStartBehavior ?? DragStartBehavior.start,
        enableIMEPersonalizedLearning:
            widget.enableIMEPersonalizedLearning ?? true,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enableSuggestions: widget.enableSuggestions ?? true,
        expands: widget.expands ?? false,
        focusNode: _focusNode,
        groupId: widget.groupId ?? EditableText,
        hintLocales: widget.hintLocales,
        ignorePointers: widget.ignorePointers,
        inputFormatters: _formatter,
        keyboardAppearance: widget.keyboardAppearance,
        keyboardType: widget.inputType,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: maxLines,
        magnifierConfiguration: widget.magnifierConfiguration,
        maxLength: null,
        minLines: minLines,
        mouseCursor: widget.mouseCursor,
        obscureText: obscureText,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
        onAppPrivateCommand: onAppPrivateCommand,
        onChanged: _handleUserEditingChange,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        onTap: onTap,
        onTapAlwaysCalled: widget.onTapAlwaysCalled ?? false,
        onTapOutside: onTapOutside,
        onTapUpOutside: onTapUpOutside,
        readOnly: isReadMode,
        restorationId: widget.restorationId,
        statesController: widget.statesController,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled ??
            widget.scribbleEnabled ??
            EditableText.defaultStylusHandwritingEnabled,
        scrollController: widget.scrollController,
        scrollPadding: widget.scrollPadding ?? _kDefaultScrollPadding,
        scrollPhysics: widget.scrollPhysics,
        selectAllOnFocus: widget.selectAllOnFocus,
        selectionControls: widget.selectionControls,
        selectionHeightStyle:
            widget.selectionHeightStyle ?? BoxHeightStyle.tight,
        selectionWidthStyle: widget.selectionWidthStyle ?? BoxWidthStyle.tight,
        showCursor: widget.showCursor,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        strutStyle: widget.strutStyle,
        style: style,
        textAlign: widget.textAlign ?? TextAlign.start,
        textAlignVertical: widget.textAlignVertical,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        textDirection: widget.textDirection,
        textInputAction: widget.inputAction,
        undoController: widget.undoController,
      ),
    );
  }

  Widget _trailing(BuildContext context, AndrossyFieldPropertyState state) {
    if (isIndicatorVisible && indicatorAlignment.isEnd) {
      return _indicator(state, IndicatorAlignment.end);
    }
    if (drawableEndVisible && widget.drawableEndBuilder != null) {
      return widget.drawableEndBuilder!(context, this);
    }
    return _Icon(
      animationCurve: animationCurve,
      animationDuration: animationDuration,
      visibility: drawableEndVisible && drawableEnd != null,
      icon: drawableEnd,
      size: drawableEndSize,
      tint: defaultDrawableEndColor.fromState(state),
      margin: drawableEndSpace,
      onToggleClick: widget.drawableEye != null ? onChangeEye : null,
    );
  }

  Widget _decorate(Widget child) {
    final borderRadius = widget.borderRadius?.fromState(state);
    final decoration = isUnderlineHide
        ? widget.decoration?.fromState(state) ??
            BoxDecoration(
              borderRadius: borderRadius,
              color: widget.backgroundColor?.fromState(state) ??
                  Colors.transparent,
            )
        : null;
    final foregroundDecoration = _usesStableDefaultBorder
        ? BoxDecoration(border: _border(state), borderRadius: borderRadius)
        : null;
    final clipBehavior = isUnderlineHide ? Clip.antiAlias : Clip.none;
    final padding = _effectiveContentPadding;
    final color = isUnderlineHide ? null : Colors.transparent;

    if (animationDuration != null) {
      return AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: animationDuration!,
        curve: animationCurve,
        color: color,
        constraints: widget.constraints,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        clipBehavior: clipBehavior,
        padding: padding,
        child: child,
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
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
    _dismissKeyboardForInactiveRoute();

    final floatingVisible = this.floatingVisible;
    final underlineVisible = !isUnderlineHide;
    final footerVisible = this.footerVisible;
    final state = this.state;

    final visible = floatingVisible || footerVisible || underlineVisible;

    Widget child = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _canRequestKeyboardFromTap ? () => showKeyboard(context) : null,
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
                  buildCounter: widget.buildCounter,
                  currentLength: currentLength,
                  maxLength: counterMaxLength,
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

  bool get canRequestKeyboardFocus {
    return isEnabled && (widget.canRequestFocus ?? true);
  }

  bool get _canRequestKeyboardFromTap {
    return canRequestKeyboardFocus && widget.ignorePointers != true;
  }

  late bool _error = _hasText(widget.errorText);

  bool get isError => _error;

  bool _focused = false;

  bool get isFocused => _enabled && _focused;

  bool _initial = true;

  bool get isInitial => _initial;

  bool _valid = false;

  bool get validate => _validateText(text);

  bool get isChecked =>
      onCheck != null ? !_checking && validate && _valid : true;

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

  int _textLength(String value) => value.characters.length;

  bool _validateText(String value) {
    final validator = onValidator;
    return validator != null ? validator(value) : true;
  }

  AndrossyFieldError errorType(String text, [bool? valid]) {
    if (text.isEmpty) {
      return _initial ? AndrossyFieldError.none : AndrossyFieldError.empty;
    } else if (!(valid ?? _valid)) {
      final length = _textLength(text);
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

  bool _checking = false;

  Future<void> _checker(
    String value,
    int ticket,
    OnAndrossyFieldErrorCheck check,
  ) async {
    AndrossyFieldError futureError;
    try {
      futureError = await check(value);
    } catch (_) {
      futureError = AndrossyFieldError.error;
    }

    if (!mounted || ticket != _checkSerial || value != text) return;

    final locallyValid = _validateText(value);
    final nextValid = locallyValid && futureError.isOk;
    final nextError = locallyValid && !futureError.isOk && value.isNotEmpty;
    final nextErrorType = nextValid
        ? AndrossyFieldError.none
        : locallyValid
            ? futureError
            : errorType(value, locallyValid);
    final nextErrorText = _resolveErrorText(nextErrorType);

    notify(() {
      _checking = false;
      _valid = nextValid;
      _error = nextError;
      errorText = nextErrorText;
    });
    _emitValidity(nextValid);
  }

  void _handleControllerChange() {
    final value = controller.text;
    if (value == _lastText) return;
    _lastText = value;
    _handleEditingChange(value);
  }

  void _handleUserEditingChange(String value) {
    onChange?.call(value);
    final currentValue = controller.text;
    if (currentValue != _lastText) {
      _lastText = currentValue;
      _handleEditingChange(currentValue);
    }
  }

  void _handleEditingChange(String value, {bool markInteracted = true}) {
    if (markInteracted) _initial = false;

    final check = onCheck;
    final locallyValid = _validateText(value);
    final shouldCheck =
        locallyValid && check != null && (!isInitial || value.isNotEmpty);

    _valid = shouldCheck ? false : locallyValid;
    _error = !shouldCheck && !locallyValid && value.isNotEmpty;
    errorText = "";

    if (shouldCheck) {
      final ticket = ++_checkSerial;
      _checking = true;
      _emitValidity(false);
      _checker(value, ticket, check);
    } else {
      _cancelPendingCheck();
      _emitValidity(_valid);
      errorText = _resolveErrorText(errorType(value, _valid));
    }

    notify();
  }

  void _emitValidity(bool value) {
    final listener = onValid;
    listener?.call(value);
  }

  String _resolveErrorText(AndrossyFieldError error) {
    final listener = onError;
    return listener?.call(error) ?? "";
  }

  final Set<VoidCallback> _focusCallbacks = <VoidCallback>{};

  void _handleFocusNodeEvent() {
    _handleFocusChange();
    for (final callback in List<VoidCallback>.of(_focusCallbacks)) {
      callback();
    }
  }

  void _attachFocusListener() {
    if (_focusListenerAttached) return;
    _focusNode.addListener(_handleFocusNodeEvent);
    _focusListenerAttached = true;
  }

  void _detachFocusListener({bool clearCallbacks = false}) {
    if (_focusListenerAttached) {
      _focusNode.removeListener(_handleFocusNodeEvent);
      _focusListenerAttached = false;
    }
    if (clearCallbacks) _focusCallbacks.clear();
  }

  void addFocusListener([VoidCallback? callback]) {
    if (callback != null) _focusCallbacks.add(callback);
    _attachFocusListener();
  }

  void removeFocusListener([VoidCallback? callback]) {
    if (callback != null) {
      _focusCallbacks.remove(callback);
    } else {
      _detachFocusListener(clearCallbacks: true);
    }
  }

  void showKeyboard(BuildContext context) {
    if (!canRequestKeyboardFocus) return;
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void hideKeyboard(BuildContext context) {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  ///
  ///
  ///
  /// BASE NOTIFIER END
  /// NOTIFIERS START
  ///
  ///
  ///

  void update() {
    if (mounted) _handleEditingChange(text);
  }

  void notify([VoidCallback? callback]) {
    if (!mounted) return;

    if (!_widgetInitialized) {
      callback?.call();
      state = AndrossyFieldPropertyState.from(this);
      return;
    }

    setState(() {
      callback?.call();
      state = AndrossyFieldPropertyState.from(this);
    });
  }

  void setEnabled(bool value) {
    if (!value) {
      _cancelPendingCheck();
      _focusNode.unfocus();
    }
    notify(() => _enabled = value);
  }

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
    if (widget.expands ?? false) return null;
    if (obscureText) return 1;
    if (widget.maxLines != null) return widget.maxLines;

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

  int? get minLines => (widget.expands ?? false) ? null : widget.minLines;

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

  set helperText(String? value) => _helperText = value;

  void setHelperText(String? value) => notify(() => _helperText = value);

  late String? _hintText = widget.hintText;

  String get hintText => _hintText ?? '';

  void setHintText(String? value) {
    notify(() => _hintText = value);
  }

  bool get isIndicatorVisible => isEnabled && (_indicatorVisible || _checking);

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

  bool get drawableEndVisible => widget.drawableEndVisible ?? true;

  dynamic get drawableEnd {
    if (widget.drawableEye != null) {
      return widget.drawableEye?.detect(obscureText);
    }
    return widget.drawableEnd?.fromState(state);
  }

  double get drawableEndSize {
    final property = widget.drawableEndSize ??
        const AndrossyFieldProperty.all(_kDefaultIconSize);
    return property.fromState(state) ?? _kDefaultIconSize;
  }

  EdgeInsets get drawableEndSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space =
        widget.drawableEndPadding?.fromState(state) ?? _kDefaultDrawablePadding;
    return EdgeInsets.only(left: !isRTL ? space : 0, right: isRTL ? space : 0);
  }

  dynamic get drawableStart {
    return widget.drawableStart?.fromState(state);
  }

  bool get drawableStartVisible => widget.drawableStartVisible ?? true;

  double get drawableStartSize {
    return widget.drawableStartSize?.fromState(state) ?? _kDefaultIconSize;
  }

  EdgeInsets get drawableStartSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space = widget.drawableStartPadding?.fromState(state) ??
        _kDefaultDrawablePadding;
    return EdgeInsets.only(left: isRTL ? space : 0, right: !isRTL ? space : 0);
  }

  late String? errorText = widget.errorText;

  void _setLocalErrorText(String? value) {
    errorText = value;
    _error = _hasText(value);
    if (_error) _valid = false;
  }

  void setErrorText(String? value) {
    notify(() => _setLocalErrorText(value));
  }

  bool get hasError => _hasText(errorText);

  late bool? _obscureText = widget.obscureText;

  bool get obscureText {
    return _obscureText ?? (widget.inputType == TextInputType.visiblePassword);
  }

  /// OTHERS

  dynamic get iEnd => drawableEnd?.drawable(isFocused);

  dynamic get iStart => drawableStart?.drawable(isFocused);

  int get currentLength => _textLength(text);

  int? get counterMaxLength => maxCharacters == 0 ? null : maxCharacters;

  String get counter {
    final maxLength = counterMaxLength ?? 0;
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
          RegExp("[${RegExp.escape(characters)}]"),
        ),
      if (ignorableCharacters.isNotEmpty)
        FilteringTextInputFormatter.deny(
          RegExp("[${RegExp.escape(ignorableCharacters)}]"),
        ),
      if (maxCharactersAsLimit && maxCharacters > 0)
        LengthLimitingTextInputFormatter(
          maxCharacters,
          maxLengthEnforcement: widget.maxLengthEnforcement,
        ),
    ];
  }

  /// CALLBACK PROPERTIES

  OnAndrossyFieldErrorCheck? get onCheck => isEnabled ? widget.onCheck : null;

  OnAndrossyFieldChanged? get onChange => isEnabled ? widget.onChanged : null;

  OnAndrossyFieldError? get onError => isEnabled ? widget.onError : null;

  OnAndrossyFieldValid? _onValid;

  OnAndrossyFieldValid? get onValid {
    if (!isEnabled) return null;

    final widgetListener = widget.onValid;
    final stateListener = _onValid;
    if (widgetListener == null) return stateListener;
    if (stateListener == null || identical(widgetListener, stateListener)) {
      return widgetListener;
    }
    return (value) {
      widgetListener(value);
      stateListener(value);
    };
  }

  void setOnValidListener(OnAndrossyFieldValid? value) => _onValid = value;

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

  AndrossyFieldTapListener? get onTap {
    return isEnabled ? widget.onTap : null;
  }

  AndrossyFieldTapOutsideListener? get onTapOutside {
    return isEnabled ? widget.onTapOutside : null;
  }

  AndrossyFieldTapUpOutsideListener? get onTapUpOutside {
    return isEnabled ? widget.onTapUpOutside : null;
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
  final InputCounterWidgetBuilder? buildCounter;
  final int currentLength;
  final int? maxLength;
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
    required this.buildCounter,
    required this.currentLength,
    required this.maxLength,
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

    final counterColor = cv.isAuto && !isFocused
        ? Colors.transparent
        : counterTextStyle?.color ?? footerTextStyle?.color;

    final counterStyle = counterTextStyle?.copyWith(color: counterColor) ??
        footerStyle?.copyWith(color: counterColor);

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

    final counterShouldShow = counterVisible &&
        textAlign != TextAlign.center &&
        (isFocused || cv.isAlways);
    final Widget counterChild;
    final customCounter = buildCounter?.call(
      context,
      currentLength: currentLength,
      maxLength: maxLength,
      isFocused: isFocused,
    );
    if (buildCounter != null) {
      counterChild = Visibility(
        visible: counterShouldShow && customCounter != null,
        child: customCounter == null
            ? const SizedBox.shrink()
            : Semantics(
                container: true,
                liveRegion: isFocused,
                child: customCounter,
              ),
      );
    } else {
      counterChild = _HighlightText(
        visible: counterVisible && textAlign != TextAlign.center,
        animationDuration: null,
        animationCurve: animationCurve,
        text: " $counter",
        textAlign: TextAlign.end,
        textDirection: textDirection,
        textStyle: hasError ? errorStyle : counterStyle,
        valid: counterShouldShow,
      );
    }

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
        counterChild,
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
      icon,
      key: ValueKey(Object.hash(icon, tint)),
      size: size,
      color: tint,
    );

    if (animationDuration != null) {
      child = AnimatedSwitcher(
        duration: animationDuration!,
        switchInCurve: animationCurve,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: child,
      );
    }
    child = Padding(padding: margin, child: child);
    if (onToggleClick != null) {
      child = GestureDetector(onTap: onToggleClick, child: child);
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

/// Side where the loading indicator appears when [AndrossyField.onCheck] or
/// manual indicator visibility is active.
enum IndicatorAlignment {
  start,
  end;

  bool get isStart => this == start;

  bool get isEnd => this == end;
}

/// Visibility mode for floating label, footer, and counter regions.
enum FloatingVisibility {
  auto,
  hide,
  always;

  bool get isAuto => this == auto;

  bool get isHide => this == hide;

  bool get isAlways => this == always;
}

/// Error categories understood by [AndrossyField].
///
/// Use [AndrossyField.onError] to map these values to localized/user-facing
/// messages.
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
    if (state.text.isEmpty) {
      return state._initial
          ? AndrossyFieldError.none
          : AndrossyFieldError.empty;
    } else if (!state._valid) {
      final length = state._textLength(state.text);
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

/// Holds two values and returns one based on an active/inactive boolean.
///
/// Useful for lightweight icon toggles, such as password visibility:
///
/// ```dart
/// drawableEye: const AndrossyFieldTweenProperty(
///   inactive: Icons.visibility_off_outlined,
///   active: Icons.visibility_outlined,
/// )
/// ```
class AndrossyFieldTweenProperty<T> {
  final T active;
  final T inactive;

  const AndrossyFieldTweenProperty({required this.active, T? inactive})
      : inactive = inactive ?? active;

  const AndrossyFieldTweenProperty.all(T value) : this(active: value);

  T detect(bool activated) {
    return activated ? active : inactive;
  }
}

/// State-aware value resolver for field colors, text styles, dimensions, and
/// drawables.
///
/// Provide only the states you care about; missing states fall back to
/// [enabled] or the closest relevant state.
///
/// ```dart
/// borderColor: AndrossyFieldProperty(
///   enabled: Colors.grey,
///   focused: Colors.blue,
///   error: Colors.red,
/// )
/// ```
class AndrossyFieldProperty<T> {
  final bool _none;
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
        _valid = valid,
        _none = false;

  const AndrossyFieldProperty.none()
      : enabled = null,
        _disabled = null,
        _error = null,
        _errorFocused = null,
        _focused = null,
        _loading = null,
        _loadingFocused = null,
        _readOnly = null,
        _validFocused = null,
        _valid = null,
        _none = true;

  const AndrossyFieldProperty.all(T? value) : this(enabled: value);

  const AndrossyFieldProperty.auto() : this();

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
    if (_none) return this;
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
    if (_none) return this;
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
    return _none.hashCode ^
        _disabled.hashCode ^
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AndrossyFieldProperty<T> &&
            other._none == _none &&
            other.enabled == enabled &&
            other._disabled == _disabled &&
            other._error == _error &&
            other._errorFocused == _errorFocused &&
            other._focused == _focused &&
            other._readOnly == _readOnly &&
            other._loading == _loading &&
            other._loadingFocused == _loadingFocused &&
            other._valid == _valid &&
            other._validFocused == _validFocused;
  }
}

extension _AndrossyFieldPropertyDefaults<T> on AndrossyFieldProperty<T>? {
  AndrossyFieldProperty<T> get use {
    return this ?? AndrossyFieldProperty<T>();
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
    if (!state.isEnabled) {
      return disabled;
    }
    if (state.isReadMode) {
      return readOnly;
    }

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
  }
}
