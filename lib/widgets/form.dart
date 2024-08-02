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

  AndrossyForm({
    super.key,
    int initialCheckTime = 500,
    List<Widget> children = const [],
    AndrossyFieldValidListener? onValid,
    AndrossyFieldValidatorListener? onValidator,
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : controller = AndrossyFormController(
          initialCheckTime: initialCheckTime,
          children: children,
          onValid: onValid,
          onValidator: onValidator,
        );

  @override
  State<AndrossyForm> createState() => _AndrossyFormState();
}

class _AndrossyFormState extends State<AndrossyForm> {
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
            children: controller.children,
          )
        : Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            crossAxisAlignment: widget.crossAxisAlignment,
            textBaseline: widget.textBaseline,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: controller.children,
          );
  }
}

class AndrossyFormController {
  /// BASE PROPERTIES
  final int initialCheckTime;
  final List<Widget> children;
  final AndrossyFieldValidListener? onValid;
  final AndrossyFieldValidatorListener? onValidator;

  AndrossyFormController({
    required this.initialCheckTime,
    required this.children,
    required this.onValid,
    required this.onValidator,
  });

  bool _initial = true;

  Iterable _items = const [];

  Set _checks = const {};

  bool get isValid => _validations.length == _items.length;

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
    _items = children.where((e) {
      if (e is AndrossyField && e.key is GlobalKey<AndrossyFieldState>) {
        return e.onValidator != null;
      } else if (e is AndrossyForm) {
        return e.controller.onValidator != null;
      } else {
        return false;
      }
    });
    _checks = _items.map((e) {
      if (e is AndrossyField && e.key is GlobalKey<AndrossyFieldState>) {
        return e.key;
      }
      if (e is AndrossyForm) {
        return e.controller;
      }
    }).toSet();
    if (_initial && onValid != null) {
      Future.delayed(Duration(milliseconds: initialCheckTime)).whenComplete(() {
        _initial = false;
        return onValid!(isValid);
      });
    }
    for (var i in _items) {
      if (i is AndrossyField && i.key is GlobalKey<AndrossyFieldState>) {
        final key = i.key as GlobalKey<AndrossyFieldState>;
        key.currentState?.setOnValidListener((value) {
          _checks.add(i.controller!);
          if (onValid != null) onValid!(isValid);
        });
      }
    }
  }
}
