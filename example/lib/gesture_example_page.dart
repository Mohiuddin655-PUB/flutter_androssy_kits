import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/widgets.dart';

class AndrossyGestureExamplePage extends StatefulWidget {
  const AndrossyGestureExamplePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AndrossyGestureExamplePage(),
    );
  }

  @override
  State<AndrossyGestureExamplePage> createState() {
    return _AndrossyGestureExamplePageState();
  }
}

class _AndrossyGestureExamplePageState
    extends State<AndrossyGestureExamplePage> {
  static const _animationDuration = Duration(milliseconds: 150);

  static const _debouncedKey = Key('gesture-example-debounced');
  static const _rapidKey = Key('gesture-example-rapid');
  static const _pressKey = Key('gesture-example-press');
  static const _longPressKey = Key('gesture-example-long-press');
  static const _hoverKey = Key('gesture-example-hover');
  static const _focusKey = Key('gesture-example-focus');
  static const _shakeKey = Key('gesture-example-shake');
  static const _customKey = Key('gesture-example-custom');
  static const _enabledKey = Key('gesture-example-enabled');

  final _focusNode = FocusNode(debugLabel: 'Androssy gesture example');
  final _statesController = WidgetStatesController();

  int _tapCount = 0;
  int _rapidTapCount = 0;
  int _pressCount = 0;
  int _longPressCount = 0;
  int _shakeCount = 0;
  int _customCount = 0;

  bool _enabled = true;
  bool _focused = false;
  bool _hovering = false;
  bool _holding = false;
  bool _pressing = false;

  String _lastAction = 'Ready';

  bool get _statePressed {
    return _statesController.value.contains(WidgetState.pressed);
  }

  bool get _active {
    return _hovering || _focused || _holding || _pressing || _statePressed;
  }

  @override
  void initState() {
    super.initState();
    _statesController.addListener(_handleStatesChanged);
  }

  @override
  void dispose() {
    _statesController.removeListener(_handleStatesChanged);
    _statesController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Androssy Gesture')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _ExampleHeader(
              title: 'Gesture Gallery',
              status: _lastAction,
              active: _active,
            ),
            const SizedBox(height: 18),
            _ExampleSection(
              title: 'Tap Controls',
              child: _DemoGrid(
                children: [
                  _gestureCard(
                    key: _debouncedKey,
                    icon: Icons.touch_app_outlined,
                    title: 'Debounced Tap',
                    value: 'Tap $_tapCount',
                    detail: 'Default lock window',
                    color: scheme.primary,
                    active: _tapCount.isOdd,
                    effects: const [
                      GestureAnimation.scale(),
                      GestureAnimation.fade(),
                    ],
                    onTap: () {
                      setState(() {
                        _tapCount++;
                        _lastAction = 'Debounced tap $_tapCount';
                      });
                    },
                  ),
                  _gestureCard(
                    key: _rapidKey,
                    icon: Icons.bolt_outlined,
                    title: 'Rapid Tap',
                    value: 'Rapid $_rapidTapCount',
                    detail: 'Duration.zero debounce',
                    color: scheme.tertiary,
                    active: _rapidTapCount.isOdd,
                    debounceDuration: Duration.zero,
                    effects: const [
                      GestureAnimation.scale(target: 0.9),
                      GestureAnimation.fade(target: 0.65),
                    ],
                    onTap: () {
                      setState(() {
                        _rapidTapCount++;
                        _lastAction = 'Rapid tap $_rapidTapCount';
                      });
                    },
                  ),
                ],
              ),
            ),
            _ExampleSection(
              title: 'Press Lifecycle',
              child: _DemoGrid(
                children: [
                  _gestureCard(
                    key: _pressKey,
                    icon: _pressing
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    title: 'Tap Down And Up',
                    value: _pressing ? 'Pressed' : 'Released',
                    detail: 'Completed $_pressCount',
                    color: scheme.secondary,
                    active: _pressing,
                    effects: const [GestureAnimation.scale(target: 0.92)],
                    onTap: () {
                      setState(() {
                        _pressCount++;
                        _lastAction = 'Tap completed $_pressCount';
                      });
                    },
                    onTapDown: (_) {
                      setState(() {
                        _pressing = true;
                        _lastAction = 'Tap down';
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _pressing = false;
                        _lastAction = 'Tap up';
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _pressing = false;
                        _lastAction = 'Tap cancelled';
                      });
                    },
                  ),
                  _gestureCard(
                    key: _longPressKey,
                    icon: Icons.more_time,
                    title: 'Long Press',
                    value: _holding ? 'Holding' : 'Hold $_longPressCount',
                    detail: 'Start, end, up callbacks',
                    color: scheme.error,
                    active: _holding,
                    effects: const [
                      GestureAnimation.scale(target: 0.9),
                      GestureAnimation.fade(target: 0.72),
                    ],
                    onLongPressStart: (_) {
                      setState(() {
                        _holding = true;
                        _lastAction = 'Long press started';
                      });
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        _holding = false;
                        _longPressCount++;
                        _lastAction = 'Long press ended $_longPressCount';
                      });
                    },
                    onLongPressCancel: () {
                      setState(() {
                        _holding = false;
                        _lastAction = 'Long press cancelled';
                      });
                    },
                    onLongPressUp: () {
                      setState(() {
                        _holding = false;
                        _lastAction = 'Long press released';
                      });
                    },
                  ),
                ],
              ),
            ),
            _ExampleSection(
              title: 'Pointer And Focus',
              child: _DemoGrid(
                children: [
                  _gestureCard(
                    key: _hoverKey,
                    icon: _hovering ? Icons.ads_click : Icons.mouse_outlined,
                    title: 'Hover Only',
                    value: _hovering ? 'Hovering' : 'Idle',
                    detail: 'Cursor and enter/exit',
                    color: scheme.primary,
                    active: _hovering,
                    mouseCursor: SystemMouseCursors.grab,
                    effects: const [GestureAnimation.scale(target: 0.96)],
                    onHover: (hovering) {
                      setState(() {
                        _hovering = hovering;
                        _lastAction = hovering ? 'Hover enter' : 'Hover exit';
                      });
                    },
                  ),
                  _gestureCard(
                    key: _focusKey,
                    icon: _focused ? Icons.center_focus_strong : Icons.tab,
                    title: 'Focus And State',
                    value: _statePressed
                        ? 'Pressed'
                        : _focused
                            ? 'Focused'
                            : 'Ready',
                    detail: 'Feedback disabled',
                    color: scheme.tertiary,
                    active: _focused || _statePressed,
                    enableFeedback: false,
                    focusNode: _focusNode,
                    statesController: _statesController,
                    effects: const [GestureAnimation.scale(target: 0.94)],
                    onFocusChange: (focused) {
                      setState(() {
                        _focused = focused;
                        _lastAction = focused ? 'Focused' : 'Focus lost';
                      });
                    },
                    onTap: () {
                      _focusNode.requestFocus();
                      setState(() => _lastAction = 'Focus tile tapped');
                    },
                  ),
                ],
              ),
            ),
            _ExampleSection(
              title: 'Animation Effects',
              child: _DemoGrid(
                children: [
                  _gestureCard(
                    key: _shakeKey,
                    icon: Icons.vibration,
                    title: 'Shake Effect',
                    value: 'Shake $_shakeCount',
                    detail: 'Nonlinear movement',
                    color: scheme.secondary,
                    active: _shakeCount.isOdd,
                    debounceDuration: Duration.zero,
                    effects: [GestureAnimation.shake(intensity: 6)],
                    onTap: () {
                      setState(() {
                        _shakeCount++;
                        _lastAction = 'Shake effect $_shakeCount';
                      });
                    },
                  ),
                  _gestureCard(
                    key: _customKey,
                    icon: Icons.auto_awesome_motion,
                    title: 'Custom Builder',
                    value: 'Custom $_customCount',
                    detail: 'GestureAnimation.builder',
                    color: scheme.primary,
                    active: _customCount.isOdd,
                    debounceDuration: Duration.zero,
                    effects: [
                      GestureAnimation(
                        debugLabel: 'tilt',
                        curve: Curves.easeOutBack,
                        builder: _tiltBuilder,
                      ),
                    ],
                    onTap: () {
                      setState(() {
                        _customCount++;
                        _lastAction = 'Custom animation $_customCount';
                      });
                    },
                  ),
                ],
              ),
            ),
            _ExampleSection(
              title: 'Disabled State',
              child: Column(
                children: [
                  _SwitchRow(
                    label: 'Enabled',
                    value: _enabled,
                    onChanged: (value) {
                      setState(() {
                        _enabled = value;
                        _lastAction = value ? 'Enabled' : 'Disabled';
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _gestureCard(
                    key: _enabledKey,
                    icon: _enabled ? Icons.lock_open : Icons.lock_outline,
                    title: 'Controlled Gesture',
                    value: _enabled ? 'Active' : 'Blocked',
                    detail: 'Toggle controls enabled',
                    color: scheme.secondary,
                    active: _enabled,
                    enabled: _enabled,
                    effects: const [GestureAnimation.scale(target: 0.94)],
                    onTap: () {
                      setState(() => _lastAction = 'Controlled gesture tapped');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gestureCard({
    required Key key,
    required IconData icon,
    required String title,
    required String value,
    required String detail,
    required Color color,
    required bool active,
    bool enabled = true,
    bool enableFeedback = true,
    Duration? debounceDuration,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    WidgetStatesController? statesController,
    List<GestureAnimation>? effects,
    GestureTapCallback? onTap,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCancelCallback? onTapCancel,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureLongPressCancelCallback? onLongPressCancel,
    GestureLongPressUpCallback? onLongPressUp,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHover,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = enabled ? color : scheme.onSurfaceVariant;

    return AndrossyGesture(
      key: key,
      enabled: enabled,
      enableFeedback: enableFeedback,
      debounceDuration: debounceDuration ?? const Duration(milliseconds: 1500),
      mouseCursor: mouseCursor ?? SystemMouseCursors.click,
      focusNode: focusNode,
      statesController: statesController,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      onLongPressCancel: onLongPressCancel,
      onLongPressUp: onLongPressUp,
      effects: effects,
      backgroundColor: active
          ? color.withValues(alpha: 0.12)
          : enabled
              ? scheme.surface
              : scheme.surfaceContainerHighest.withValues(alpha: 0.55),
      highlightColor: color.withValues(alpha: 0.08),
      hoverColor: color.withValues(alpha: 0.08),
      splashColor: color.withValues(alpha: 0.14),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: active ? color.withValues(alpha: 0.55) : scheme.outlineVariant,
        ),
      ),
      child: _GestureCardContent(
        icon: icon,
        title: title,
        value: value,
        detail: detail,
        color: foreground,
        active: active,
        enabled: enabled,
      ),
    );
  }

  void _handleStatesChanged() {
    if (mounted) setState(() {});
  }

  static Widget _tiltBuilder(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final progress = 1 - animation.value;
    return Transform.translate(
      offset: Offset(0, -8 * progress),
      child: Transform.rotate(angle: -0.08 * progress, child: child),
    );
  }
}

class _ExampleHeader extends StatelessWidget {
  final String title;
  final String status;
  final bool active;

  const _ExampleHeader({
    required this.title,
    required this.status,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.tertiary;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.24)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                active ? Icons.touch_app : Icons.pending_outlined,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  status,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExampleSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _ExampleSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _DemoGrid extends StatelessWidget {
  final List<Widget> children;

  const _DemoGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final columns = constraints.maxWidth >= 620 ? 2 : 1;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}

class _GestureCardContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String detail;
  final Color color;
  final bool active;
  final bool enabled;

  const _GestureCardContent({
    required this.icon,
    required this.title,
    required this.value,
    required this.detail,
    required this.color,
    required this.active,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final muted = scheme.onSurfaceVariant.withValues(alpha: enabled ? 1 : 0.62);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 118),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                _StateDot(active: active, enabled: enabled, color: color),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: enabled ? scheme.onSurface : muted,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              detail,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(color: muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _StateDot extends StatelessWidget {
  final bool active;
  final bool enabled;
  final Color color;

  const _StateDot({
    required this.active,
    required this.enabled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: _AndrossyGestureExamplePageState._animationDuration,
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: !enabled
            ? scheme.outline
            : active
                ? color
                : scheme.outlineVariant,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
