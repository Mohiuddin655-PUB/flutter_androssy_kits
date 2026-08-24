import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_androssy_kits/widgets.dart';

class AndrossyFieldExamplePage extends StatefulWidget {
  const AndrossyFieldExamplePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AndrossyFieldExamplePage(),
    );
  }

  @override
  State<AndrossyFieldExamplePage> createState() {
    return _AndrossyFieldExamplePageState();
  }
}

class _AndrossyFieldExamplePageState extends State<AndrossyFieldExamplePage> {
  static const _fieldAnimationDuration = Duration(milliseconds: 320);
  static const _fieldAnimationCurve = Curves.easeOutCubic;

  final _formController = AndrossyFormController();

  final _displayNameKey = GlobalKey<AndrossyFieldState>();
  final _usernameKey = GlobalKey<AndrossyFieldState>();
  final _emailKey = GlobalKey<AndrossyFieldState>();
  final _passwordKey = GlobalKey<AndrossyFieldState>();
  final _sandboxKey = GlobalKey<AndrossyFieldState>();

  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController(text: 'hello@app.dev');
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _amountController = TextEditingController();
  final _bioController = TextEditingController();
  final _searchController = TextEditingController();
  final _rtlController = TextEditingController(text: 'marhaba');
  final _sandboxController = TextEditingController(text: 'Tap controls below');

  bool _formValid = false;
  bool _sandboxEnabled = true;
  bool _sandboxReadOnly = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _amountController.dispose();
    _bioController.dispose();
    _searchController.dispose();
    _rtlController.dispose();
    _sandboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Androssy Field')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _ExampleHeader(
              title: 'Field Gallery',
              status: _formValid ? 'Form valid' : 'Form incomplete',
              active: _formValid,
            ),
            const SizedBox(height: 18),
            _ExampleSection(
              title: 'Shared Form Defaults',
              child: AndrossyForm(
                controller: _formController,
                animationDuration: _fieldAnimationDuration,
                animationCurve: _fieldAnimationCurve,
                backgroundColor: AndrossyFieldProperty(
                  enabled: scheme.surface,
                  focused: scheme.surface,
                  error: scheme.errorContainer.withValues(alpha: 0.16),
                  valid: scheme.primaryContainer.withValues(alpha: 0.16),
                ),
                borderColor: AndrossyFieldProperty(
                  enabled: scheme.outlineVariant,
                  focused: scheme.primary,
                  error: scheme.error,
                  valid: scheme.primary,
                ),
                borderRadius: AndrossyFieldProperty.all(
                  BorderRadius.circular(8),
                ),
                borderWidth: const AndrossyFieldTweenProperty(
                  active: 1.8,
                  inactive: 1,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
                counterVisibility: FloatingVisibility.auto,
                drawableStartPadding: const AndrossyFieldProperty.all(10),
                drawableEndPadding: const AndrossyFieldProperty.all(10),
                drawableStartTint: AndrossyFieldProperty(
                  enabled: scheme.onSurfaceVariant,
                  focused: scheme.primary,
                  error: scheme.error,
                  valid: scheme.primary,
                ),
                drawableEndTint: AndrossyFieldProperty(
                  enabled: scheme.onSurfaceVariant,
                  focused: scheme.primary,
                  error: scheme.error,
                  valid: scheme.primary,
                ),
                errorColor: scheme.error,
                floatingPadding: const EdgeInsets.symmetric(horizontal: 4),
                floatingVisibility: FloatingVisibility.always,
                footerVisibility: FloatingVisibility.always,
                helperStyle: AndrossyFieldProperty.all(
                  textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
                onValid: (valid) {
                  if (_formValid != valid) setState(() => _formValid = valid);
                },
                children: [
                  AndrossyField(
                    key: _displayNameKey,
                    controller: _displayNameController,
                    hintText: 'Display name',
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                    minCharacters: 2,
                    maxCharacters: 32,
                    drawableStart: const AndrossyFieldProperty(
                      enabled: Icons.badge_outlined,
                      focused: Icons.badge,
                    ),
                    drawableEnd: const AndrossyFieldProperty(
                      valid: Icons.check_circle,
                      error: Icons.error_outline,
                    ),
                    onValidator: (value) => value.trim().length >= 2,
                    onError: _messageForError,
                  ),
                  const SizedBox(height: 14),
                  AndrossyField(
                    key: _usernameKey,
                    controller: _usernameController,
                    hintText: 'Username',
                    helperText: 'Try taken or network',
                    characters: 'abcdefghijklmnopqrstuvwxyz0123456789_',
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                    maxCharacters: 18,
                    minCharacters: 3,
                    loadingText: 'Checking username',
                    drawableStart: const AndrossyFieldProperty(
                      enabled: Icons.alternate_email_outlined,
                      focused: Icons.alternate_email,
                    ),
                    drawableEnd: const AndrossyFieldProperty(
                      valid: Icons.verified,
                      error: Icons.info_outline,
                    ),
                    onCheck: _checkUsername,
                    onError: _messageForError,
                    onValidator: _isUsername,
                  ),
                  const SizedBox(height: 14),
                  AndrossyField(
                    key: _emailKey,
                    controller: _emailController,
                    hintText: 'Email address',
                    characters: 'abcdefghijklmnopqrstuvwxyz0123456789._%+-@',
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                    drawableStart: const AndrossyFieldProperty(
                      enabled: Icons.mail_outline,
                      focused: Icons.mail,
                    ),
                    drawableEnd: const AndrossyFieldProperty(
                      valid: Icons.done,
                      error: Icons.priority_high,
                    ),
                    onError: _messageForError,
                    onValidator: _isEmail,
                  ),
                  const SizedBox(height: 14),
                  AndrossyField(
                    key: _passwordKey,
                    controller: _passwordController,
                    hintText: 'Password',
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    maxCharacters: 24,
                    minCharacters: 8,
                    obscureText: true,
                    drawableStart: const AndrossyFieldProperty(
                      enabled: Icons.lock_outline,
                      focused: Icons.lock,
                    ),
                    drawableEye: const AndrossyFieldTweenProperty(
                      inactive: Icons.visibility_off_outlined,
                      active: Icons.visibility_outlined,
                    ),
                    onError: _messageForError,
                    onValidator: _isPassword,
                  ),
                ],
              ),
            ),
            _ExampleSection(
              title: 'Underline And Compact',
              children: [
                AndrossyField(
                  controller: _searchController,
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  hintText: 'Search anything',
                  inputAction: TextInputAction.search,
                  inputType: TextInputType.text,
                  counterVisibility: FloatingVisibility.hide,
                  drawableStart: const AndrossyFieldProperty(
                    enabled: Icons.search,
                    focused: Icons.manage_search,
                  ),
                  underlineColor: AndrossyFieldProperty(
                    enabled: scheme.outlineVariant,
                    focused: scheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                AndrossyField(
                  controller: _phoneController,
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  hintText: 'Phone number',
                  characters: '0123456789',
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.phone,
                  maxCharacters: 14,
                  floatingVisibility: FloatingVisibility.auto,
                  footerVisibility: FloatingVisibility.always,
                  counterVisibility: FloatingVisibility.always,
                  drawableStart: const AndrossyFieldProperty(
                    enabled: Icons.call_outlined,
                    focused: Icons.call,
                  ),
                  drawableEndBuilder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '+880',
                        style: textTheme.titleMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  },
                  onError: _messageForError,
                  onValidator: (value) => value.isEmpty || value.length >= 10,
                ),
              ],
            ),
            _ExampleSection(
              title: 'Custom Builder And Indicator',
              children: [
                AndrossyField(
                  controller: _amountController,
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  backgroundColor: AndrossyFieldProperty.all(
                    scheme.surfaceContainerHighest.withValues(alpha: 0.45),
                  ),
                  borderColor: AndrossyFieldProperty(
                    enabled: Colors.transparent,
                    focused: scheme.secondary,
                  ),
                  borderRadius: AndrossyFieldProperty.all(
                    BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  hintText: 'Amount',
                  inputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  inputType: TextInputType.number,
                  drawableStartBuilder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'BDT',
                        style: state.style.copyWith(
                          color: scheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                  drawableEnd: const AndrossyFieldProperty(
                    enabled: Icons.payments_outlined,
                    focused: Icons.payments,
                  ),
                ),
                const SizedBox(height: 16),
                AndrossyField(
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  indicatorVisible: true,
                  indicatorAlignment: IndicatorAlignment.start,
                  indicator: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: scheme.tertiary,
                    ),
                  ),
                  loadingText: 'Syncing',
                  hintText: 'Custom loading indicator',
                  text: 'Remote profile lookup',
                  footerVisibility: FloatingVisibility.always,
                  backgroundColor: AndrossyFieldProperty.all(scheme.surface),
                  borderColor: AndrossyFieldProperty.all(scheme.outlineVariant),
                  borderRadius: AndrossyFieldProperty.all(
                    BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  readOnly: true,
                ),
              ],
            ),
            _ExampleSection(
              title: 'Multiline And Character Rules',
              child: AndrossyField(
                controller: _bioController,
                animationDuration: _fieldAnimationDuration,
                animationCurve: _fieldAnimationCurve,
                hintText: 'Short bio',
                helperText: 'Counter allows overflow to show maximum errors',
                inputAction: TextInputAction.newline,
                inputType: TextInputType.multiline,
                maxCharacters: 140,
                maxCharactersAsLimit: false,
                maxLines: 5,
                minLines: 3,
                footerVisibility: FloatingVisibility.always,
                counterVisibility: FloatingVisibility.always,
                backgroundColor: AndrossyFieldProperty.all(scheme.surface),
                borderColor: AndrossyFieldProperty(
                  enabled: scheme.outlineVariant,
                  focused: scheme.primary,
                  error: scheme.error,
                ),
                borderRadius: AndrossyFieldProperty.all(
                  BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(14),
                onError: _messageForError,
                onValidator: (value) => value.characters.length <= 140,
              ),
            ),
            _ExampleSection(
              title: 'Read Only, Disabled, RTL',
              children: [
                AndrossyField(
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  text: 'Read only value',
                  readOnly: true,
                  hintText: 'Read only',
                  drawableStart: const AndrossyFieldProperty(
                    enabled: Icons.lock_clock_outlined,
                  ),
                  backgroundColor: AndrossyFieldProperty.all(scheme.surface),
                  borderColor: AndrossyFieldProperty.all(scheme.outlineVariant),
                  borderRadius: AndrossyFieldProperty.all(
                    BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(14),
                ),
                const SizedBox(height: 16),
                AndrossyField(
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  text: 'Disabled value',
                  enabled: false,
                  hintText: 'Disabled',
                  drawableStart: const AndrossyFieldProperty(
                    enabled: Icons.block_outlined,
                  ),
                  backgroundColor: AndrossyFieldProperty.all(
                    scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  ),
                  borderColor: AndrossyFieldProperty.all(scheme.outlineVariant),
                  borderRadius: AndrossyFieldProperty.all(
                    BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(14),
                ),
                const SizedBox(height: 16),
                AndrossyField(
                  controller: _rtlController,
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  hintText: 'RTL centered',
                  floatingVisibility: FloatingVisibility.always,
                  underlineColor: AndrossyFieldProperty(
                    enabled: scheme.outlineVariant,
                    focused: scheme.primary,
                  ),
                ),
              ],
            ),
            _ExampleSection(
              title: 'State Methods',
              children: [
                AndrossyField(
                  key: _sandboxKey,
                  controller: _sandboxController,
                  enabled: _sandboxEnabled,
                  readOnly: _sandboxReadOnly,
                  animationDuration: _fieldAnimationDuration,
                  animationCurve: _fieldAnimationCurve,
                  hintText: 'Controlled from GlobalKey',
                  loadingText: 'Manual loading',
                  footerVisibility: FloatingVisibility.always,
                  backgroundColor: AndrossyFieldProperty(
                    enabled: scheme.surface,
                    focused: scheme.surface,
                    disabled: scheme.surfaceContainerHighest,
                    readOnly: scheme.surfaceContainerHighest.withValues(
                      alpha: 0.45,
                    ),
                  ),
                  borderColor: AndrossyFieldProperty(
                    enabled: scheme.outlineVariant,
                    focused: scheme.primary,
                    error: scheme.error,
                    disabled: scheme.outlineVariant,
                  ),
                  borderRadius: AndrossyFieldProperty.all(
                    BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(14),
                  drawableStart: const AndrossyFieldProperty(
                    enabled: Icons.tune,
                    focused: Icons.tune,
                    error: Icons.error_outline,
                  ),
                  drawableEnd: const AndrossyFieldProperty(
                    enabled: Icons.touch_app_outlined,
                    focused: Icons.touch_app,
                  ),
                ),
                const SizedBox(height: 12),
                _SwitchRow(
                  label: 'Enabled',
                  value: _sandboxEnabled,
                  onChanged: (value) {
                    setState(() => _sandboxEnabled = value);
                    _sandboxKey.currentState?.setEnabled(value);
                  },
                ),
                _SwitchRow(
                  label: 'Read only',
                  value: _sandboxReadOnly,
                  onChanged: (value) {
                    setState(() => _sandboxReadOnly = value);
                    _sandboxKey.currentState?.setReadMode(value);
                  },
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        _sandboxKey.currentState?.setHelperText(
                          'Helper updated',
                        );
                      },
                      icon: const Icon(Icons.notes),
                      label: const Text('Helper'),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        _sandboxKey.currentState?.setErrorText('Manual error');
                      },
                      icon: const Icon(Icons.report_outlined),
                      label: const Text('Error'),
                    ),
                    FilledButton.icon(
                      onPressed: _showManualLoading,
                      icon: const Icon(Icons.sync),
                      label: const Text('Loading'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        _sandboxKey.currentState
                          ?..setErrorText(null)
                          ..setHelperText(null)
                          ..setIndicatorVisibility(false)
                          ..update();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<AndrossyFieldError> _checkUsername(String value) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final username = value.trim().toLowerCase();
    if (username == 'network') return AndrossyFieldError.networkError;
    if (username == 'taken') return AndrossyFieldError.alreadyFound;
    return AndrossyFieldError.none;
  }

  bool _isEmail(String value) {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim());
  }

  bool _isPassword(String value) {
    return value.length >= 8 && RegExp(r'[0-9]').hasMatch(value);
  }

  bool _isUsername(String value) {
    return RegExp(r'^[a-z0-9_]{3,18}$').hasMatch(value);
  }

  String? _messageForError(AndrossyFieldError error) {
    switch (error) {
      case AndrossyFieldError.none:
        return null;
      case AndrossyFieldError.alreadyFound:
        return 'Already taken';
      case AndrossyFieldError.empty:
        return 'Required';
      case AndrossyFieldError.error:
        return 'Something went wrong';
      case AndrossyFieldError.invalid:
        return 'Invalid value';
      case AndrossyFieldError.maximum:
        return 'Too long';
      case AndrossyFieldError.minimum:
        return 'Too short';
      case AndrossyFieldError.networkError:
        return 'Network unavailable';
      case AndrossyFieldError.unmodified:
        return 'No changes';
    }
  }

  void _showManualLoading() {
    final state = _sandboxKey.currentState;
    state?.setIndicatorVisibility(true);
    Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      _sandboxKey.currentState
        ?..setIndicatorVisibility(false)
        ..setHelperText('Manual loading finished');
    });
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
                active ? Icons.check_circle : Icons.pending_outlined,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
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
  final Widget? child;
  final List<Widget> children;

  const _ExampleSection({
    required this.title,
    this.child,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: child ?? Column(children: children),
          ),
        ],
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
