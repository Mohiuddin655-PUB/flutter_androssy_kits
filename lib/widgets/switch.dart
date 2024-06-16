import 'package:flutter/material.dart';

import 'icon.dart';

typedef OnAndrossySwitchChangeListener = void Function(bool value);

class AndrossySwitch extends StatefulWidget {
  final bool visibility;
  final bool enabled;
  final bool value;
  final double size;

  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final Color? activeThumbStrokeColor;
  final Color? inactiveThumbStrokeColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackStrokeColor;
  final Color? inactiveTrackStrokeColor;

  final dynamic activeThumbIcon;
  final dynamic inactiveThumbIcon;
  final Color? activeThumbIconTint;
  final Color? inactiveThumbIconTint;

  final double? activeThumbSpacing;
  final double? inactiveThumbSpacing;
  final double? activeThumbStrokeSize;
  final double? inactiveThumbStrokeSize;

  final double? thumbIconSpacing;
  final int thumbWalkingTime;
  final double? trackBorderRadius;
  final double? trackStrokeSize;
  final double trackRatio;

  final AndrossySwitchConfig config;
  final OnAndrossySwitchChangeListener? onChanged;

  const AndrossySwitch({
    super.key,
    this.config = const AndrossySwitchConfig(),
    this.visibility = true,
    this.enabled = true,
    this.value = false,
    this.size = 30,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeThumbStrokeColor,
    this.inactiveThumbStrokeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeTrackStrokeColor,
    this.inactiveTrackStrokeColor,
    this.activeThumbIcon,
    this.inactiveThumbIcon,
    this.activeThumbIconTint,
    this.inactiveThumbIconTint,
    this.activeThumbSpacing,
    this.inactiveThumbSpacing,
    this.activeThumbStrokeSize,
    this.inactiveThumbStrokeSize,
    this.thumbIconSpacing,
    this.thumbWalkingTime = 200,
    this.trackBorderRadius,
    this.trackStrokeSize,
    this.trackRatio = 1.65,
    this.onChanged,
  });

  @override
  State<AndrossySwitch> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<AndrossySwitch>
    with SingleTickerProviderStateMixin {
  late Duration _duration;
  late final Animation _toggleAnimation;
  late final AnimationController _animationController;
  late AndrossySwitchConfig I;

  AndrossySwitchConfig _config() {
    return widget.config.copy(
      activeThumbColor: widget.activeThumbColor,
      activeThumbIcon: widget.activeThumbIcon,
      activeThumbIconTint: widget.activeThumbIconTint,
      activeThumbStrokeColor: widget.activeThumbStrokeColor,
      activeThumbStrokeSize: widget.activeThumbStrokeSize,
      activeThumbSpacing: widget.activeThumbSpacing,
      activeTrackColor: widget.activeTrackColor,
      activeTrackStrokeColor: widget.activeTrackStrokeColor,
      inactiveThumbColor: widget.inactiveThumbColor,
      inactiveThumbIcon: widget.inactiveThumbIcon,
      inactiveThumbIconTint: widget.inactiveThumbIconTint,
      inactiveThumbStrokeColor: widget.inactiveThumbStrokeColor,
      inactiveThumbStrokeSize: widget.inactiveThumbStrokeSize,
      inactiveThumbSpacing: widget.inactiveThumbSpacing,
      inactiveTrackColor: widget.inactiveTrackColor,
      inactiveTrackStrokeColor: widget.inactiveTrackStrokeColor,
      enabled: widget.enabled,
      size: widget.size,
      thumbIconSpacing: widget.thumbIconSpacing,
      thumbWalkingTime: widget.thumbWalkingTime,
      trackBorderRadius: widget.trackBorderRadius,
      trackRatio: widget.trackRatio,
      trackStrokeSize: widget.trackStrokeSize,
      value: widget.value,
    );
  }

  @override
  void initState() {
    super.initState();
    I = _config();
    _duration = Duration(milliseconds: I.thumbWalkingTime);
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: _duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AndrossySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    I = _config();

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = SwitchTheme.of(context);

    var mAC = colorScheme.primary;
    var mIC = const Color(0xff697e8b);

    var active = widget.value;
    var size = I.size;

    var trackColor = AndrossySwitchContent(
      active:
          I.activeTrackColor ?? theme.trackColor(WidgetState.selected) ?? mAC,
      inactive:
          I.inactiveTrackColor ?? theme.trackColor.none ?? Colors.transparent,
    ).detect(active);

    var trackOutlineColor = AndrossySwitchContent(
      active: I.activeTrackStrokeColor ??
          theme.trackOutlineColor(WidgetState.selected) ??
          Colors.transparent,
      inactive:
          I.inactiveTrackStrokeColor ?? theme.trackOutlineColor.none ?? mIC,
    ).detect(active);

    var thumbColor = AndrossySwitchContent(
      active: I.activeThumbColor ??
          theme.thumbColor(WidgetState.selected) ??
          colorScheme.surface,
      inactive: I.inactiveThumbColor ?? theme.thumbColor.none ?? mIC,
    ).detect(active);

    var thumbStrokeColor = AndrossySwitchContent(
      active: I.activeThumbStrokeColor ?? Colors.transparent,
      inactive: I.inactiveThumbStrokeColor ?? Colors.transparent,
    ).detect(active);

    var thumbSpacing = AndrossySwitchContent(
      active: I.activeThumbSpacing ?? size.x(5) ?? 4,
      inactive: I.inactiveThumbSpacing ?? size.x(20),
    ).detect(active);

    var thumbStrokeSize = AndrossySwitchContent(
      active: I.activeThumbStrokeSize ?? 0,
      inactive: I.inactiveThumbStrokeSize,
    ).detect(active);

    var thumbIcon = AndrossySwitchContent(
      active: I.activeThumbIcon,
      inactive: I.inactiveThumbIcon,
    ).detect(active);

    var thumbIconTint = AndrossySwitchContent(
      active: I.activeThumbIconTint,
      inactive: I.inactiveThumbIconTint,
    ).detect(active);

    var trackStrokeSize = I.trackStrokeSize ?? size.x(7) ?? 2.0;
    var borderRadius = I.trackBorderRadius ?? size;
    var dimension = I.trackRatio >= 1 ? I.trackRatio : 1.65;
    var thumbSize = size - (trackStrokeSize * 2) - (thumbSpacing * 2);

    Widget child = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: widget.enabled ? 1 : 0.5,
          child: AnimatedContainer(
            duration: _duration,
            width: I.size * dimension,
            height: I.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: trackColor,
              border: trackStrokeSize > 0
                  ? Border.all(
                      color: trackOutlineColor,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: trackStrokeSize,
                    )
                  : null,
            ),
            child: Align(
              alignment: _toggleAnimation.value,
              child: AnimatedContainer(
                duration: _duration,
                curve: Curves.decelerate,
                width: thumbSize,
                margin: EdgeInsets.all(thumbSpacing),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: thumbColor,
                  border: thumbStrokeSize > 0
                      ? Border.all(
                          strokeAlign: BorderSide.strokeAlignInside,
                          color: thumbStrokeColor,
                          width: thumbStrokeSize,
                        )
                      : null,
                ),
                child: thumbIcon != null
                    ? FittedBox(
                        child: Padding(
                          padding: EdgeInsets.all(
                            I.thumbIconSpacing ?? 0,
                          ),
                          child: AndrossyIcon(
                            icon: thumbIcon,
                            color: thumbIconTint,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );

    if (widget.onChanged != null) {
      return GestureDetector(
        onTap: () {
          if (widget.enabled) {
            if (widget.value) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            widget.onChanged?.call(!widget.value);
          }
        },
        child: child,
      );
    }

    return child;
  }
}

class AndrossySwitchConfig {
  final double size;

  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final Color? activeThumbStrokeColor;
  final Color? inactiveThumbStrokeColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackStrokeColor;
  final Color? inactiveTrackStrokeColor;

  final dynamic activeThumbIcon;
  final dynamic inactiveThumbIcon;
  final Color? activeThumbIconTint;
  final Color? inactiveThumbIconTint;

  final double? activeThumbSpacing;
  final double? inactiveThumbSpacing;
  final double? activeThumbStrokeSize;
  final double? inactiveThumbStrokeSize;

  final double? thumbIconSpacing;
  final int thumbWalkingTime;
  final double? trackBorderRadius;
  final double? trackStrokeSize;
  final double trackRatio;

  const AndrossySwitchConfig({
    this.size = 30,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeThumbStrokeColor,
    this.inactiveThumbStrokeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeTrackStrokeColor,
    this.inactiveTrackStrokeColor,
    this.activeThumbIcon,
    this.inactiveThumbIcon,
    this.activeThumbIconTint,
    this.inactiveThumbIconTint,
    this.activeThumbSpacing,
    this.inactiveThumbSpacing,
    this.activeThumbStrokeSize,
    this.inactiveThumbStrokeSize,
    this.thumbIconSpacing,
    this.thumbWalkingTime = 200,
    this.trackBorderRadius,
    this.trackStrokeSize,
    this.trackRatio = 1.65,
  });

  AndrossySwitchConfig copy({
    bool? enabled,
    bool? value,
    double? size,
    Color? activeThumbColor,
    Color? inactiveThumbColor,
    Color? activeThumbStrokeColor,
    Color? inactiveThumbStrokeColor,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeTrackStrokeColor,
    Color? inactiveTrackStrokeColor,
    dynamic activeThumbIcon,
    dynamic inactiveThumbIcon,
    Color? activeThumbIconTint,
    Color? inactiveThumbIconTint,
    double? activeThumbSpacing,
    double? inactiveThumbSpacing,
    double? activeThumbStrokeSize,
    double? inactiveThumbStrokeSize,
    double? thumbIconSpacing,
    int? thumbWalkingTime,
    double? trackBorderRadius,
    double? trackStrokeSize,
    double? trackRatio,
  }) {
    return AndrossySwitchConfig(
      activeThumbColor: activeThumbColor ?? this.activeThumbColor,
      activeThumbIcon: activeThumbIcon ?? this.activeThumbIcon,
      activeThumbIconTint: activeThumbIconTint ?? this.activeThumbIconTint,
      activeThumbStrokeColor:
          activeThumbStrokeColor ?? this.activeThumbStrokeColor,
      activeThumbStrokeSize:
          activeThumbStrokeSize ?? this.activeThumbStrokeSize,
      activeThumbSpacing: activeThumbSpacing ?? this.activeThumbSpacing,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      activeTrackStrokeColor:
          activeTrackStrokeColor ?? this.activeTrackStrokeColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
      inactiveThumbIcon: inactiveThumbIcon ?? this.inactiveThumbIcon,
      inactiveThumbIconTint:
          inactiveThumbIconTint ?? this.inactiveThumbIconTint,
      inactiveThumbStrokeColor:
          inactiveThumbStrokeColor ?? this.inactiveThumbStrokeColor,
      inactiveThumbStrokeSize:
          inactiveThumbStrokeSize ?? this.inactiveThumbStrokeSize,
      inactiveThumbSpacing: inactiveThumbSpacing ?? this.inactiveThumbSpacing,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      inactiveTrackStrokeColor:
          inactiveTrackStrokeColor ?? this.inactiveTrackStrokeColor,
      size: size ?? this.size,
      thumbIconSpacing: thumbIconSpacing ?? this.thumbIconSpacing,
      thumbWalkingTime: thumbWalkingTime ?? this.thumbWalkingTime,
      trackBorderRadius: trackBorderRadius ?? this.trackBorderRadius,
      trackRatio: trackRatio ?? this.trackRatio,
      trackStrokeSize: trackStrokeSize ?? this.trackStrokeSize,
    );
  }
}

class AndrossySwitchContent<T> {
  final T active;
  final T inactive;

  const AndrossySwitchContent({
    required this.active,
    T? inactive,
  }) : inactive = inactive ?? active;

  T detect(bool isActivated) => isActivated ? active : inactive;
}

extension _SizeExtension on double? {
  double? x(int percentage) => this != null ? this! * (percentage / 100) : null;
}

extension _WidgetStateExtension<T> on WidgetStateProperty<T?>? {
  WidgetStateProperty<T?> get use {
    return this ?? const WidgetStatePropertyAll(null);
  }

  T? call([WidgetState? state]) => use.resolve({if (state != null) state});

  T? get none => use.call();
}
