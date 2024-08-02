import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icon.dart';

typedef AndrossyFieldActivator = Future<bool> Function(
  bool running,
  dynamic value,
);
typedef AndrossyFieldChangeListener<T> = void Function(T value);
typedef AndrossyFieldErrorListener = String? Function(AndrossyFieldError error);
typedef AndrossyFieldValidListener = void Function(bool value);
typedef AndrossyFieldValidatorListener = bool Function(String value);

typedef AndrossyFieldChecker = Future<bool> Function(String value);

typedef AndrossyFieldDrawableBuilder = Widget Function(
  BuildContext context,
  AndrossyFieldState controller,
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
  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// BASE PROPERTIES
  final bool enabled;
  final Duration? animationDuration;
  final Curve animationCurve;
  final bool autoDisposeMode;
  final String characters;
  final String hint;
  final Color? hintColor;
  final String ignorableCharacters;
  final Color? primary;
  final bool maxCharactersAsLimit;
  final int maxCharacters;
  final int? minCharacters;
  final List<TextInputFormatter>? inputFormatters;
  final StrutStyle? strutStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final EdgeInsets textScrollPadding;
  final ScrollPhysics? textScrollPhysics;

  final AndrossyFieldProperty<BoxDecoration>? decoration;
  final AndrossyFieldProperty<Color?>? background;
  final AndrossyFieldProperty<Border?>? border;
  final AndrossyFieldProperty<BorderRadius?>? borderRadius;

  /// COUNTER TEXT PROPERTIES
  final AndrossyFieldProperty<TextStyle>? counterTextStyle;
  final AndrossyFieldFloatingVisibility counterVisibility;

  /// DRAWABLE END PROPERTIES
  final AndrossyFieldProperty<dynamic>? drawableEnd;
  final AndrossyFieldDrawableBuilder? drawableEndBuilder;
  final AndrossyFieldProperty<double>? drawableEndSize;
  final AndrossyFieldProperty<double>? drawableEndPadding;
  final AndrossyFieldProperty<Color>? drawableEndTint;
  final bool drawableEndVisible;
  final bool drawableEndAsEye;

  /// DRAWABLE START PROPERTIES
  final AndrossyFieldProperty<dynamic>? drawableStart;
  final AndrossyFieldDrawableBuilder? drawableStartBuilder;
  final AndrossyFieldProperty<double>? drawableStartSize;
  final AndrossyFieldProperty<double>? drawableStartPadding;
  final AndrossyFieldProperty<Color>? drawableStartTint;
  final bool drawableStartVisible;

  /// ERROR TEXT PROPERTIES
  final AndrossyFieldProperty<String>? errorText;
  final AndrossyFieldFloatingVisibility errorVisibility;
  final AndrossyFieldProperty<TextStyle>? errorTextStyle;

  /// FLOATING TEXT PROPERTIES
  final Alignment? floatingAlignment;
  final String? floatingText;
  final AndrossyFieldProperty<TextStyle>? floatingTextStyle;
  final EdgeInsets floatingTextSpace;
  final AndrossyFieldFloatingVisibility floatingVisibility;

  /// HELPER TEXT PROPERTIES
  final String helperText;
  final AndrossyFieldProperty<TextStyle>? helperTextStyle;

  /// INDICATOR PROPERTIES
  final Widget? indicator;
  final double indicatorSize;
  final AndrossyFieldProperty<Color>? indicatorStrokeColor;
  final double indicatorStroke;
  final AndrossyFieldProperty<Color>? indicatorStrokeBackground;
  final bool indicatorVisible;

  /// TEXT FIELD PROPERTIES
  final bool autocorrect;
  final List<String> autofillHints;
  final bool autoFocus;
  final Clip clipBehaviorText;
  final Color? cursorColor;
  final double? cursorHeight;
  final bool cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double cursorWidth;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final AndrossyFieldContextMenuBuilder? contextMenuBuilder;
  final DragStartBehavior dragStartBehavior;
  final bool enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
  final bool enableSuggestions;
  final bool expands;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final Brightness keyboardAppearance;
  final TextMagnifierConfiguration magnifierConfiguration;
  final int? maxLines;
  final int? minLines;
  final MouseCursor? mouseCursor;
  final bool? obscureText;
  final String obscuringCharacter;
  final bool readOnly;
  final String? restorationId;
  final bool scribbleEnabled;
  final ScrollController? scrollControllerText;
  final EdgeInsets scrollPaddingText;
  final ScrollPhysics? scrollPhysicsText;
  final Color? secondaryColor;
  final TextSelectionControls? selectionControls;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final bool? showCursor;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextCapitalization textCapitalization;
  final UndoHistoryController? undoController;
  final AndrossyFieldPrivateCommandListener? onAppPrivateCommand;
  final AndrossyFieldVoidListener? onEditingComplete;
  final AndrossyFieldSubmitListener? onSubmitted;
  final AndrossyFieldTapOutsideListener? onTapOutside;

  /// UNDERLINE PROPERTIES
  final AndrossyFieldProperty<Color>? underlineColor;
  final AndrossyFieldProperty<double>? underlineHeight;

  /// TEXT PROPERTIES
  final String? text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;

  /// CALLBACK PROPERTIES
  final AndrossyFieldActivator? onActivator;
  final AndrossyFieldChangeListener? onChange;
  final AndrossyFieldErrorListener? onError;
  final AndrossyFieldValidListener? onValid;
  final AndrossyFieldValidatorListener? onValidator;

  const AndrossyField({
    /// ROOT PROPERTIES
    super.key,
    this.controller,
    this.focusNode,

    /// BASE PROPERTIES
    this.animationDuration,
    this.animationCurve = Curves.linear,
    this.autoDisposeMode = true,
    this.background,
    this.border,
    this.borderRadius,
    this.characters = "",
    this.decoration,
    this.errorText,
    this.hint = "",
    this.hintColor,
    this.hintStyle,
    this.minCharacters,
    this.primary,
    this.padding,

    /// CALLBACK PROPERTIES
    this.onActivator,
    this.onChange,
    this.onError,
    this.onValid,
    this.onValidator,

    /// TEXT PROPERTIES
    this.maxCharacters = 0,
    this.maxLines,
    this.textDirection,
    this.strutStyle,
    this.text,
    this.textAlign,
    this.textStyle,

    /// COUNTER PROPERTIES
    this.counterTextStyle,
    this.counterVisibility = AndrossyFieldFloatingVisibility.hide,

    /// DRAWABLE END PROPERTIES
    this.drawableEnd,
    this.drawableEndBuilder,
    this.drawableEndSize = const AndrossyFieldProperty(enabled: 24),
    this.drawableEndPadding,
    this.drawableEndTint,
    this.drawableEndVisible = true,
    this.drawableEndAsEye = false,

    /// DRAWABLE START PROPERTIES
    this.drawableStart,
    this.drawableStartBuilder,
    this.drawableStartSize = const AndrossyFieldProperty(enabled: 24),
    this.drawableStartPadding,
    this.drawableStartTint,
    this.drawableStartVisible = true,

    /// ERROR TEXT PROPERTIES
    this.errorTextStyle,
    this.errorVisibility = AndrossyFieldFloatingVisibility.auto,

    /// FLOATING TEXT PROPERTIES
    this.floatingAlignment,
    this.floatingText,
    this.floatingTextStyle,
    this.floatingTextSpace = EdgeInsets.zero,
    this.floatingVisibility = AndrossyFieldFloatingVisibility.hide,

    /// HELPER TEXT PROPERTIES
    this.helperText = "",
    this.helperTextStyle,

    /// INDICATOR PROPERTIES
    this.indicator,
    this.indicatorSize = 24,
    this.indicatorStrokeColor,
    this.indicatorStroke = 2,
    this.indicatorStrokeBackground,
    this.indicatorVisible = true,

    /// TEXT FIELD PROPERTIES
    this.enabled = true,
    this.autocorrect = true,
    this.autofillHints = const [],
    this.autoFocus = false,
    this.clipBehaviorText = Clip.hardEdge,
    this.cursorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates = false,
    this.cursorRadius,
    this.cursorWidth = 2,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.expands = false,
    this.ignorableCharacters = "",
    this.inputAction,
    this.inputFormatters,
    this.inputType,
    this.keyboardAppearance = Brightness.light,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.maxCharactersAsLimit = true,
    this.minLines,
    this.mouseCursor,
    this.obscureText,
    this.obscuringCharacter = '•',
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollControllerText,
    this.scrollPaddingText = const EdgeInsets.all(20),
    this.scrollPhysicsText,
    this.secondaryColor,
    this.selectionControls,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.textCapitalization = TextCapitalization.none,
    this.textScrollPadding = const EdgeInsets.all(20.0),
    this.textScrollPhysics,
    this.textInputAction,
    this.undoController,
    // LISTENERS
    this.onAppPrivateCommand,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,

    /// UNDERLINE PROPERTIES
    this.underlineColor,
    this.underlineHeight,
  });

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @visibleForTesting
  static Widget defaultSpellCheckSuggestionsToolbarBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoSpellCheckSuggestionsToolbar.editableText(
          editableTextState: editableTextState,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return SpellCheckSuggestionsToolbar.editableText(
          editableTextState: editableTextState,
        );
    }
  }

  static SpellCheckConfiguration inferAndroidSpellCheckConfiguration(
    SpellCheckConfiguration? configuration,
  ) {
    if (configuration == null ||
        configuration == const SpellCheckConfiguration.disabled()) {
      return const SpellCheckConfiguration.disabled();
    }
    return configuration.copyWith(
      misspelledTextStyle: configuration.misspelledTextStyle ??
          TextField.materialMisspelledTextStyle,
      spellCheckSuggestionsToolbarBuilder:
          configuration.spellCheckSuggestionsToolbarBuilder ??
              defaultSpellCheckSuggestionsToolbarBuilder,
    );
  }

  @override
  State<AndrossyField> createState() => AndrossyFieldState();
}

class AndrossyFieldState extends State<AndrossyField> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    controller.text = widget.text ?? controller.text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addFocusListener();
      _handleEditingChange(text);
    });
  }

  void _dispose() {
    if (widget.autoDisposeMode) {
      removeFocusListener();
      controller.dispose();
      focusNode.dispose();
    }
  }

  @override
  void dispose() {
    super.dispose();
    return _dispose();
  }

  Widget decorate(BuildContext context, Widget child) {
    final decoration = widget.decoration?.fromState(this) ??
        BoxDecoration(
          border: widget.border?.fromState(this),
          borderRadius: widget.borderRadius?.fromState(this),
          color: widget.background?.fromState(this),
        );
    if (widget.animationDuration != null) {
      return AnimatedContainer(
        duration: widget.animationDuration!,
        curve: widget.animationCurve,
        decoration: decoration,
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    } else {
      return Container(
        decoration: decoration,
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }
  }

  Widget attach(BuildContext context) {
    final theme = Theme.of(context);
    final themeStyle = theme.textTheme.bodyLarge ?? const TextStyle();
    final primaryColor = primary;
    final secondaryColor = widget.secondaryColor ?? const Color(0xffbbbbbb);

    var mStyle = (widget.textStyle ?? themeStyle).copyWith(
      fontSize: widget.textStyle?.fontSize ?? 18,
      height: 1.2,
    );
    var mHintStyle = (hintStyle ?? themeStyle).copyWith(
      fontSize: widget.textStyle?.fontSize ?? 18,
      height: 1.2,
      color: text.isNotEmpty
          ? Colors.transparent
          : widget.hintColor ?? secondaryColor,
    );
    final colors = AndrossyFieldProperty(
      enabled: secondaryColor,
      focused: primaryColor,
      disabled: secondaryColor,
    );

    final defaultColor = colors.fromState(this);

    return GestureDetector(
      onTap: () => showKeyboard(context),
      child: Container(
        color: Colors.transparent,
        padding: widget.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: widget.textDirection,
          children: [
            if (widget.drawableStartBuilder != null)
              widget.drawableStartBuilder!(context, this)
            else
              _Icon(
                visibility: drawableStart != null,
                icon: drawableStart,
                size: drawableStartSize,
                tint: drawableStartTint ?? defaultColor,
                margin: drawableStartSpace,
              ),
            Expanded(
              child: TextField(
                canRequestFocus: true,
                enabled: enabled,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  isCollapsed: true,
                  hintText: widget.hint,
                  hintStyle: mHintStyle,
                  hintTextDirection: widget.textDirection,
                ),
                autocorrect: widget.autocorrect,
                autofillHints: widget.autofillHints,
                autofocus: widget.autoFocus,
                clipBehavior: widget.clipBehaviorText,
                controller: controller,
                cursorColor: widget.cursorColor ?? primaryColor,
                cursorHeight: widget.cursorHeight,
                cursorOpacityAnimates: widget.cursorOpacityAnimates,
                cursorRadius: widget.cursorRadius,
                cursorWidth: widget.cursorWidth,
                contentInsertionConfiguration:
                    widget.contentInsertionConfiguration,
                contextMenuBuilder: widget.contextMenuBuilder,
                dragStartBehavior: widget.dragStartBehavior,
                enableIMEPersonalizedLearning:
                    widget.enableIMEPersonalizedLearning,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                enableSuggestions: widget.enableSuggestions,
                expands: widget.expands,
                focusNode: focusNode,
                inputFormatters: _formatter,
                keyboardAppearance: widget.keyboardAppearance,
                keyboardType: widget.inputType,
                maxLines: maxLines,
                magnifierConfiguration: widget.magnifierConfiguration,
                maxLength: null,
                minLines: widget.minLines,
                mouseCursor: widget.mouseCursor,
                obscureText: obscureText,
                obscuringCharacter: widget.obscuringCharacter,
                onAppPrivateCommand: onAppPrivateCommand,
                onChanged: _handleEditingChange,
                onEditingComplete: onEditingComplete,
                onSubmitted: onSubmitted,
                onTapOutside: onTapOutside,
                readOnly: isReadMode,
                restorationId: widget.restorationId,
                scribbleEnabled: widget.scribbleEnabled,
                scrollController: widget.scrollControllerText,
                scrollPadding: widget.textScrollPadding,
                scrollPhysics: widget.textScrollPhysics,
                selectionControls: widget.selectionControls,
                selectionHeightStyle: widget.selectionHeightStyle,
                selectionWidthStyle: widget.selectionWidthStyle,
                showCursor: widget.showCursor,
                smartDashesType: widget.smartDashesType,
                smartQuotesType: widget.smartQuotesType,
                spellCheckConfiguration: widget.spellCheckConfiguration,
                strutStyle: widget.strutStyle,
                style: mStyle,
                textAlign: widget.textAlign ?? TextAlign.start,
                textCapitalization: widget.textCapitalization,
                textDirection: widget.textDirection,
                textInputAction: widget.textInputAction,
                undoController: widget.undoController,
              ),
            ),
            if (isIndicatorVisible)
              Container(
                width: widget.indicatorSize,
                height: widget.indicatorSize,
                padding: EdgeInsets.all(widget.indicatorSize * 0.05),
                margin: drawableEndSpace,
                child: CircularProgressIndicator(
                  strokeWidth: widget.indicatorStroke,
                  color: indicatorStrokeColor ?? defaultColor,
                  backgroundColor: indicatorStrokeBackground ??
                      defaultColor?.withOpacity(0.1),
                ),
              )
            else if (widget.drawableEndBuilder != null)
              widget.drawableEndBuilder!(context, this)
            else
              _Icon(
                visibility: drawableEnd != null,
                icon: drawableEnd,
                size: drawableEndSize,
                tint: drawableEndTint ?? defaultColor,
                margin: drawableEndSpace,
                onToggleClick: widget.drawableEndAsEye ? onChangeEye : null,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final floatingVisible = this.floatingVisible;
    final underlineVisible = !isUnderlineHide;
    final footerVisible = this.footerVisible;

    final visible = floatingVisible || footerVisible || underlineVisible;

    Widget child = attach(context);

    if (isUnderlineHide) {
      child = decorate(context, child);
    }

    return visible
        ? Column(
            textDirection: widget.textDirection,
            children: [
              if (floatingVisible)
                _Header(
                  floatingAlignment: floatingAlignment,
                  floatingTextSpace: widget.floatingTextSpace,
                  floatingText: floatingText,
                  textAlign: widget.textAlign,
                  textDirection: widget.textDirection,
                  floatingTextStyle: floatingTextStyle,
                ),
              child,
              if (underlineVisible)
                _Underline(
                  active: isFocused,
                  color: underlineColor,
                  height: underlineHeight,
                ),
              if (footerVisible)
                _Footer(
                  counterVisibility: widget.counterVisibility,
                  hasError: hasError,
                  floatingTextSpace: widget.floatingTextSpace,
                  textDirection: widget.textDirection,
                  footerAlignment: footerAlignment,
                  textAlign: widget.textAlign,
                  counter: counter,
                  errorText: errorText,
                  helperText: widget.helperText,
                  footerTextStyle: footerTextStyle,
                  counterTextStyle: counterTextStyle,
                  errorTextColor: errorTextColor,
                  helperTextColor: helperTextStyle?.color,
                  counterTextColor: counterTextColor,
                  isFocused: isFocused,
                ),
            ],
          )
        : child;
  }

  AndrossyFieldError errorType(String text, [bool? valid]) {
    if (text.isEmpty && !_initial) {
      return AndrossyFieldError.empty;
    } else if (!(valid ?? isValid)) {
      final length = text.length;
      if (widget.maxCharacters > 0 && widget.maxCharacters < length) {
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

  void _handleFocusChange() {
    if (focusNode.hasFocus != focused) {
      focused = focusNode.hasFocus;
      if (onFocusChanged(focused)) {
        onNotify();
      }
    }
  }

  void _handleEditingChange(String value) {
    onNotifyWithCallback(() {
      _initial = false;
      valid = false;
      error = false;
      errorText = "";
      if (onChange != null) onChange!(value);
      if (onValid != null || onError != null || onActivator != null) {
        valid = isValid;
        if (valid && onActivator != null && !_initial) {
          _running = _indicatorVisible;
          _indicatorVisible = true;
          valid = false;
          error = false;
          onActivator!.call(_running, value).then((_) {
            onNotifyWithCallback(() {
              _indicatorVisible = false;
              valid = isValid;
              if (valid) {
                final x = valid;
                valid = _ && x;
                error = !_ && text.isNotEmpty && x;
                if (onValid != null) onValid!(valid);
                if (onError != null) {
                  if (error) {
                    errorText = onError!(AndrossyFieldError.alreadyFound) ?? "";
                  } else {
                    errorText = onError!(errorType(value, valid)) ?? "";
                  }
                }
              }
            });
          });
        } else {
          _indicatorVisible = false;
          valid = valid && isChecked;
          error = !valid && text.isNotEmpty;
          if (onValid != null) onValid!(valid);
          if (onError != null) {
            errorText = onError!(errorType(value, valid)) ?? "";
          }
        }
      }
    });
  }

  void showKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

  void onChangeEye(bool value) {
    if (widget.drawableEndAsEye) {
      onNotifyWithCallback(() => _obscureText = !obscureText);
    }
  }

  bool onFocusChanged(bool focused) {
    return true;
  }

  void onNotify() => setState(() {});

  void onNotifyWithCallback(VoidCallback callback) {
    callback();
    onNotify();
  }

  void addFocusListener([VoidCallback? callback]) {
    focusNode.addListener(() {
      _handleFocusChange();
      if (callback != null) callback();
    });
  }

  void removeFocusListener([VoidCallback? callback]) {
    focusNode.removeListener(() {
      _handleFocusChange();
      if (callback != null) callback();
    });
  }

  bool get activated => isFocused;

  int? get maxLines {
    switch (widget.inputType) {
      case TextInputType.datetime:
      case TextInputType.emailAddress:
      case TextInputType.name:
      case TextInputType.number:
      case TextInputType.phone:
      case TextInputType.streetAddress:
      case TextInputType.text:
      case TextInputType.visiblePassword:
      case TextInputType.text:
        return 1;
      case TextInputType.multiline:
      case TextInputType.url:
      default:
        return null;
    }
  }

  String get text => controller.text;

  Color get primary => widget.primary ?? Theme.of(context).primaryColor;

  Color? get counterTextColor {
    return counterTextStyle?.color ?? widget.secondaryColor;
  }

  TextStyle? get counterTextStyle {
    return widget.counterTextStyle?.fromState(this) ??
        helperTextStyle?.copyWith(
          color: hasError ? errorTextColor : widget.secondaryColor,
        );
  }

  bool get counterVisible {
    return !widget.counterVisibility.isInvisible &&
        widget.textAlign != TextAlign.center;
  }

  String? _errorText;

  set errorText(String? value) => _errorText = value;

  Color? get errorTextColor => errorTextStyle?.color ?? const Color(0xFFFF7769);

  TextStyle? get errorTextStyle {
    return widget.errorTextStyle?.fromState(this) ??
        helperTextStyle?.copyWith(color: const Color(0xFFFF7769));
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

  String get floatingText => widget.floatingText ?? widget.hint;

  Color? get floatingTextColor {
    return isFocused ? primary : widget.secondaryColor;
  }

  TextStyle get floatingTextStyle {
    final x = widget.floatingTextStyle?.fromState(this) ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
    if (widget.floatingVisibility.isVisible || text.isNotEmpty) {
      return x;
    } else {
      return x.copyWith(color: Colors.transparent);
    }
  }

  bool get floatingVisible => !widget.floatingVisibility.isInvisible;

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

  bool get footerVisible => helperTextVisible || counterVisible;

  Color? get footerTextColor => footerTextStyle?.color;

  TextStyle? get footerTextStyle {
    if (hasError) {
      return errorTextStyle;
    } else {
      return helperTextStyle;
    }
  }

  TextStyle? get helperTextStyle {
    return widget.helperTextStyle
        ?.fromState(this)
        ?.copyWith(color: widget.secondaryColor);
  }

  bool get helperTextVisible => hasError || widget.helperText.isNotEmpty;

  TextStyle? get hintStyle => widget.hintStyle ?? widget.textStyle;

  Color? get underlineColor {
    return widget.underlineColor?.fromState(this) ??
        AndrossyFieldProperty(
          enabled: const Color(0xffe1e1e1),
          focused: primary,
          error: const Color(0xFFFF7769),
        ).fromState(this);
  }

  double get underlineHeight {
    return widget.underlineHeight?.fromState(this) ?? 1;
  }

  dynamic get drawableEnd {
    if (widget.drawableEndAsEye) {
      return widget.drawableEnd?.fromState(this);
    }
    return widget.drawableEnd?.fromState(this);
  }

  double get drawableEndSize {
    return widget.drawableEndSize?.fromState(this) ?? 24;
  }

  double? get drawableEndPadding {
    return widget.drawableEndPadding?.fromState(this);
  }

  EdgeInsets get drawableEndSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space = drawableEndPadding ?? 12;
    return EdgeInsets.only(
      left: !isRTL ? space : 0,
      right: isRTL ? space : 0,
    );
  }

  Color? get drawableEndTint {
    return widget.drawableEndTint?.fromState(this);
  }

  /// DRAWABLE START PROPERTIES
  dynamic get drawableStart {
    return widget.drawableStart?.fromState(this);
  }

  double get drawableStartSize {
    return widget.drawableStartSize?.fromState(this) ?? 24;
  }

  double? get drawableStartPadding {
    return widget.drawableStartPadding?.fromState(this);
  }

  EdgeInsets get drawableStartSpace {
    final isRTL = widget.textDirection == TextDirection.rtl;
    final space = drawableStartPadding ?? 12;
    return EdgeInsets.only(
      left: isRTL ? space : 0,
      right: !isRTL ? space : 0,
    );
  }

  Color? get drawableStartTint {
    return widget.drawableStartTint?.fromState(this);
  }

  String? get errorText => widget.errorText?.fromState(this) ?? _errorText;

  bool get hasError => (errorText ?? "").isNotEmpty;

  Color? get indicatorStrokeColor {
    return widget.indicatorStrokeColor?.fromState(this);
  }

  Color? get indicatorStrokeBackground {
    return widget.indicatorStrokeBackground?.fromState(this);
  }

  late bool? _obscureText = widget.obscureText;

  bool get obscureText {
    return _obscureText ?? (widget.inputType == TextInputType.visiblePassword);
  }

  /// CUSTOMIZATIONS
  late bool enabled = widget.enabled;

  bool error = false;

  bool focused = false;

  bool valid = false;

  bool _initial = true;

  bool get isInitial => _initial;

  bool get isFocused => enabled && focused;

  bool get isReadMode => !enabled && widget.readOnly;

  bool get isUnderlineHide {
    return widget.background != null ||
        widget.border != null ||
        widget.borderRadius != null ||
        widget.decoration != null;
  }

  bool get isValid {
    if (onValidator != null) {
      return onValidator!(text);
    } else {
      return true;
    }
  }

  bool get isChecked {
    if (onActivator != null) {
      return valid;
    } else {
      return true;
    }
  }

  dynamic get iEnd => drawableEnd?.drawable(isFocused);

  dynamic get iStart => drawableStart?.drawable(isFocused);

  String get counter {
    var currentLength = text.length;
    final maxLength = widget.maxCharacters;
    return maxLength > 0
        ? '$currentLength / $maxLength'
        : currentLength > 0
            ? "$currentLength"
            : "";
  }

  List<TextInputFormatter>? get _formatter {
    return [
      ...?widget.inputFormatters,
      if (widget.characters.isNotEmpty)
        FilteringTextInputFormatter.allow(RegExp("[${widget.characters}]")),
      if (widget.ignorableCharacters.isNotEmpty)
        FilteringTextInputFormatter.deny(
            RegExp("[${widget.ignorableCharacters}]")),
      if (widget.maxCharactersAsLimit && widget.maxCharacters > 0)
        LengthLimitingTextInputFormatter(widget.maxCharacters),
    ];
  }

  /// CALLBACK PROPERTIES

  AndrossyFieldActivator? get onActivator =>
      enabled ? widget.onActivator : null;

  AndrossyFieldChangeListener? get onChange => enabled ? widget.onChange : null;

  AndrossyFieldErrorListener? get onError => enabled ? widget.onError : null;

  late AndrossyFieldValidListener? _onValid = widget.onValid;

  AndrossyFieldValidListener? get onValid => enabled ? _onValid : null;

  void setOnValidListener(AndrossyFieldValidListener value) => _onValid = value;

  AndrossyFieldValidatorListener? get onValidator {
    return enabled ? widget.onValidator : null;
  }

  AndrossyFieldPrivateCommandListener? get onAppPrivateCommand {
    return enabled ? widget.onAppPrivateCommand : null;
  }

  AndrossyFieldVoidListener? get onEditingComplete {
    return enabled ? widget.onEditingComplete : null;
  }

  AndrossyFieldSubmitListener? get onSubmitted {
    return enabled ? widget.onSubmitted : null;
  }

  AndrossyFieldTapOutsideListener? get onTapOutside {
    return enabled ? widget.onTapOutside : null;
  }

  /// FUNCTIONS

  bool _running = false;

  bool get isIndicatorVisible => onActivator != null && _indicatorVisible;

  late bool _indicatorVisible = widget.indicatorVisible;
}

enum AndrossyFieldFloatingVisibility {
  auto,
  hide,
  always;

  bool get isAuto => this == auto;

  bool get isInvisible => this == hide;

  bool get isVisible => this == always;
}

enum AndrossyFieldError {
  none,
  empty,
  invalid,
  alreadyFound,
  maximum,
  minimum,
  unmodified;

  bool get isEmpty => this == AndrossyFieldError.empty;

  bool get isInvalid => this == AndrossyFieldError.invalid;

  bool get isMaximum => this == AndrossyFieldError.maximum;

  bool get isMinimum => this == AndrossyFieldError.minimum;

  bool get isAlreadyFound => this == AndrossyFieldError.alreadyFound;

  bool get isUnmodified => this == AndrossyFieldError.unmodified;
}

class AndrossyFieldProperty<T> {
  final T? enabled;
  final T? focused;
  final T? disabled;
  final T? error;
  final T? valid;
  final T? readOnly;

  const AndrossyFieldProperty({
    this.enabled,
    this.focused,
    this.disabled,
    this.error,
    this.valid,
    this.readOnly,
  });

  const AndrossyFieldProperty.all(T? value) : this(enabled: value);

  AndrossyFieldProperty copyWith({
    T? enabled,
    T? disabled,
    T? focused,
    T? error,
    T? valid,
    T? readOnly,
  }) {
    return AndrossyFieldProperty(
      enabled: enabled ?? this.enabled,
      disabled: disabled ?? this.disabled,
      focused: focused ?? this.focused,
      error: error ?? this.error,
      valid: valid ?? this.valid,
      readOnly: readOnly ?? this.readOnly,
    );
  }

  T? detect({
    bool enabled = true,
    bool focused = false,
    bool error = false,
    bool valid = false,
    bool readMode = false,
  }) {
    if (enabled && !readMode) {
      if (error) {
        if (focused) {
          return this.error ?? this.focused ?? this.enabled;
        } else {
          return this.enabled ?? this.error;
        }
      } else if (valid) {
        if (focused) {
          return this.focused ?? this.enabled;
        } else {
          return this.valid ?? this.enabled;
        }
      } else {
        return this.enabled;
      }
    } else {
      if (readMode) {
        return this.readOnly ?? this.disabled ?? this.enabled;
      } else {
        return this.disabled ?? this.enabled;
      }
    }
  }

  T? fromState(AndrossyFieldState state) {
    return detect(
      enabled: state.enabled,
      error: state.error,
      focused: state.isFocused,
      valid: state.isValid,
      readMode: state.widget.readOnly,
    );
  }

  @override
  int get hashCode {
    return enabled.hashCode ^
        focused.hashCode ^
        disabled.hashCode ^
        error.hashCode ^
        valid.hashCode;
  }

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

class _Footer extends StatelessWidget {
  final AndrossyFieldFloatingVisibility counterVisibility;
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
  final Color? errorTextColor;
  final Color? helperTextColor;
  final Color? counterTextColor;
  final bool isFocused;

  const _Footer({
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
    required this.errorTextColor,
    required this.helperTextColor,
    required this.counterTextColor,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    final cv = counterVisibility;
    final counterVisible = !cv.isInvisible;
    final hasError = this.hasError;
    return Container(
      width: double.infinity,
      padding: floatingTextSpace.copyWith(bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: textDirection,
        mainAxisAlignment: footerAlignment,
        children: [
          _HighlightText(
            visible: hasError || helperText.isNotEmpty,
            text: hasError ? errorText : helperText,
            textAlign: textAlign,
            textDirection: textDirection,
            textStyle: footerTextStyle,
            textColor: hasError ? errorTextColor : helperTextColor,
            valid: hasError || helperText.isNotEmpty,
          ),
          _HighlightText(
            visible: counterVisible && textAlign != TextAlign.center,
            text: counter,
            textAlign: TextAlign.end,
            textDirection: textDirection,
            textStyle: counterTextStyle,
            textColor: hasError ? errorTextColor : counterTextColor,
            valid: counterVisible && (isFocused || cv.isVisible),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Alignment? floatingAlignment;
  final EdgeInsets floatingTextSpace;
  final String floatingText;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? floatingTextStyle;

  const _Header({
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
        text: floatingText,
        textAlign: textAlign,
        textDirection: textDirection,
        textStyle: floatingTextStyle,
      ),
    );
  }
}

class _HighlightText extends StatelessWidget {
  final bool valid;
  final bool visible;
  final String? text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? textStyle;
  final Color? textColor;

  const _HighlightText({
    this.visible = true,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.textStyle,
    this.textColor,
    this.valid = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = textStyle ??
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: valid ? textColor ?? Colors.grey : Colors.transparent,
        );
    return Visibility(
      visible: visible,
      child: Text(
        text ?? "",
        textAlign: textAlign,
        textDirection: textDirection,
        style: style,
      ),
    );
  }
}

class _Icon extends StatefulWidget {
  final bool visibility;
  final dynamic icon;
  final double size;
  final Color? tint;
  final EdgeInsets margin;
  final void Function(bool value)? onToggleClick;

  const _Icon({
    required this.visibility,
    required this.icon,
    required this.size,
    required this.tint,
    required this.margin,
    this.onToggleClick,
  });

  @override
  State<_Icon> createState() => _IconState();
}

class _IconState extends State<_Icon> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.visibility) return const SizedBox.shrink();
    Widget child = Padding(
      padding: widget.margin,
      child: AndrossyIcon(
        icon: widget.icon,
        size: widget.size,
        color: widget.tint,
      ),
    );
    if (widget.onToggleClick != null) {
      child = GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
            widget.onToggleClick!(selected);
          });
        },
        child: child,
      );
    }
    return child;
  }
}

class _Underline extends StatelessWidget {
  final Color? color;
  final bool active;
  final double height;

  const _Underline({
    this.color,
    this.active = true,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: active ? 0 : height),
      decoration: BoxDecoration(color: color),
      height: active ? height * 2 : height,
    );
  }
}
