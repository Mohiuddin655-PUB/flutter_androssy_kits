import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_androssy_kits/flutter_androssy_kits.dart';

import 'field_example_page.dart';
import 'gesture_example_page.dart';

const _assetPhoto = 'assets/bg.jpg';
const _assetMark = 'assets/androssy_mark.svg';

const _svgCode = '''
<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg">
  <rect width="120" height="120" rx="24" fill="#F9A825"/>
  <path d="M28 72C40 42 80 42 92 72" stroke="#263238" stroke-width="9" stroke-linecap="round"/>
  <circle cx="44" cy="52" r="7" fill="#263238"/>
  <circle cx="76" cy="52" r="7" fill="#263238"/>
</svg>
''';

const _longText =
    'Androssy widgets are small building blocks for production Flutter screens. '
    'The examples here show common states, builders, layout modes, callbacks, '
    'and customization paths without leaving the sample app.';

class WidgetGalleryHomePage extends StatelessWidget {
  const WidgetGalleryHomePage({super.key});

  static final List<_ExampleDestination> _destinations = [
    _ExampleDestination(
      title: 'AndrossyButton',
      group: 'Actions',
      icon: Icons.smart_button_outlined,
      builder: (_) => const AndrossyButtonExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyButtonSkeleton',
      group: 'Actions',
      icon: Icons.view_compact_outlined,
      builder: (_) => const AndrossyButtonSkeletonExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyGesture',
      group: 'Actions',
      icon: Icons.touch_app_outlined,
      builder: (_) => const AndrossyGestureExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyHoldGesture',
      group: 'Actions',
      icon: Icons.touch_app,
      builder: (_) => const AndrossyHoldGestureExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySwiper',
      group: 'Actions',
      icon: Icons.swipe_outlined,
      builder: (_) => const AndrossySwiperExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyField',
      group: 'Input',
      icon: Icons.text_fields,
      builder: (_) => const AndrossyFieldExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyForm',
      group: 'Input',
      icon: Icons.fact_check_outlined,
      builder: (_) => const AndrossyFormExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyOption',
      group: 'Input',
      icon: Icons.radio_button_checked,
      builder: (_) => const AndrossyOptionExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySelection',
      group: 'Input',
      icon: Icons.checklist_rtl,
      builder: (_) => const AndrossySelectionExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySwitch',
      group: 'Input',
      icon: Icons.toggle_on_outlined,
      builder: (_) => const AndrossySwitchExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyRating',
      group: 'Input',
      icon: Icons.star_border_rounded,
      builder: (_) => const AndrossyRatingExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyRatingIndicator',
      group: 'Feedback',
      icon: Icons.star_half_rounded,
      builder: (_) => const AndrossyRatingIndicatorExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyCountdown',
      group: 'Feedback',
      icon: Icons.timer_outlined,
      builder: (_) => const AndrossyCountdownExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyDataKeeper',
      group: 'Feedback',
      icon: Icons.cloud_sync_outlined,
      builder: (_) => const AndrossyDataKeeperExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyObserver',
      group: 'Feedback',
      icon: Icons.visibility_outlined,
      builder: (_) => const AndrossyObserverExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyRender',
      group: 'Feedback',
      icon: Icons.straighten_outlined,
      builder: (_) => const AndrossyRenderExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyShimmer',
      group: 'Feedback',
      icon: Icons.blur_on,
      builder: (_) => const AndrossyShimmerExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySplash',
      group: 'Feedback',
      icon: Icons.waves_outlined,
      builder: (_) => const AndrossySplashExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySlider',
      group: 'Navigation',
      icon: Icons.view_carousel_outlined,
      builder: (_) => const AndrossySliderExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyTab',
      group: 'Navigation',
      icon: Icons.tab,
      builder: (_) => const AndrossyTabExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyToolbar',
      group: 'Navigation',
      icon: Icons.space_dashboard_outlined,
      builder: (_) => const AndrossyToolbarExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyCoordinator',
      group: 'Navigation',
      icon: Icons.vertical_split_outlined,
      builder: (_) => const AndrossyCoordinatorExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyText',
      group: 'Content',
      icon: Icons.format_size,
      builder: (_) => const AndrossyTextExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyExpandableText',
      group: 'Content',
      icon: Icons.notes_outlined,
      builder: (_) => const AndrossyExpandableTextExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySetting',
      group: 'Content',
      icon: Icons.settings_outlined,
      builder: (_) => const AndrossySettingExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyAvatar',
      group: 'Media',
      icon: Icons.account_circle_outlined,
      builder: (_) => const AndrossyAvatarExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyIcon',
      group: 'Media',
      icon: Icons.insert_emoticon_outlined,
      builder: (_) => const AndrossyIconExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyImage',
      group: 'Media',
      icon: Icons.image_outlined,
      builder: (_) => const AndrossyImageExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyImageGrid',
      group: 'Media',
      icon: Icons.grid_view_outlined,
      builder: (_) => const AndrossyImageGridExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyThumbnail',
      group: 'Media',
      icon: Icons.play_circle_outline,
      builder: (_) => const AndrossyThumbnailExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyFade',
      group: 'Layout',
      icon: Icons.gradient_outlined,
      builder: (_) => const AndrossyFadeExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyFlex',
      group: 'Layout',
      icon: Icons.layers_outlined,
      builder: (_) => const AndrossyFlexExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossyGuideline',
      group: 'Layout',
      icon: Icons.control_camera_outlined,
      builder: (_) => const AndrossyGuidelineExamplePage(),
    ),
    _ExampleDestination(
      title: 'AndrossySingleton',
      group: 'Layout',
      icon: Icons.inventory_2_outlined,
      builder: (_) => const AndrossySingletonExamplePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<_ExampleDestination>>{};
    for (final destination in _destinations) {
      groups.putIfAbsent(destination.group, () => []).add(destination);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Androssy Widget Examples')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            Text(
              '${_destinations.length} widget pages',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            for (final entry in groups.entries)
              _DestinationSection(title: entry.key, children: entry.value),
          ],
        ),
      ),
    );
  }
}

class _DestinationSection extends StatelessWidget {
  const _DestinationSection({required this.title, required this.children});

  final String title;
  final List<_ExampleDestination> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 920
                  ? 3
                  : constraints.maxWidth >= 620
                      ? 2
                      : 1;
              final spacing = 10.0;
              final width =
                  (constraints.maxWidth - (spacing * (columns - 1))) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final child in children)
                    SizedBox(width: width, child: _DestinationTile(child)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile(this.destination);

  final _ExampleDestination destination;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: ListTile(
        leading: Icon(destination.icon, color: scheme.primary),
        title: Text(
          destination.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: destination.builder),
          );
        },
      ),
    );
  }
}

class _ExampleDestination {
  const _ExampleDestination({
    required this.title,
    required this.group,
    required this.icon,
    required this.builder,
  });

  final String title;
  final String group;
  final IconData icon;
  final WidgetBuilder builder;
}

class _GalleryPage extends StatelessWidget {
  const _GalleryPage({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: children,
        ),
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({
    required this.title,
    this.child,
    this.children = const [],
  });

  final String title;
  final Widget? child;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          if (child != null) child!,
          ...children,
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _DemoGrid extends StatelessWidget {
  const _DemoGrid({required this.children, this.minWidth = 260});

  final List<Widget> children;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / minWidth).floor().clamp(1, 3);
        final spacing = 10.0;
        final width =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;
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

class _SurfaceBox extends StatelessWidget {
  const _SurfaceBox({
    required this.child,
    this.height,
    this.color,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final double? height;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.onSurfaceVariant;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class AndrossyButtonExamplePage extends StatefulWidget {
  const AndrossyButtonExamplePage({super.key});

  @override
  State<AndrossyButtonExamplePage> createState() {
    return _AndrossyButtonExamplePageState();
  }
}

class _AndrossyButtonExamplePageState extends State<AndrossyButtonExamplePage> {
  final _stateButtonKey = GlobalKey<AndrossyButtonState>();

  bool _enabled = true;
  bool _loading = false;
  bool _activated = false;
  int _clicks = 0;
  String _lastAction = 'Ready';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyButton',
      children: [
        _GallerySection(
          title: 'States',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Primary',
                subtitle: _lastAction,
                child: AndrossyButton(
                  text: 'Continue',
                  icon: Icons.arrow_forward_rounded,
                  primary: scheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  clickEffects: const [GestureAnimation.scale(target: 0.96)],
                  onTap: () {
                    setState(() {
                      _clicks++;
                      _lastAction = 'Tapped $_clicks';
                    });
                  },
                ),
              ),
              _DemoCard(
                title: 'Toggle',
                trailing: _StatusPill(text: _activated ? 'On' : 'Off'),
                child: AndrossyButton(
                  activated: _activated,
                  borderOnly: true,
                  text: 'Favorite',
                  icons: const AndrossyButtonProperty(
                    enabled: Icons.favorite_border,
                    activated: Icons.favorite,
                  ),
                  iconOrIndicatorAlignment: IconAlignment.start,
                  primary: scheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  onToggle: (value) => setState(() => _activated = value),
                ),
              ),
              _DemoCard(
                title: 'Loading',
                child: AndrossyButton(
                  loading: _loading,
                  enabled: _enabled,
                  text: 'Save',
                  texts: const AndrossyButtonProperty(
                    loading: 'Saving',
                    disabled: 'Disabled',
                  ),
                  icon: Icons.save_outlined,
                  primary: scheme.tertiary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  onTap: () => _showSnack(context, 'Save tapped'),
                ),
              ),
              _DemoCard(
                title: 'Icon Only',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AndrossyButton(
                    iconOnly: true,
                    icon: Icons.notifications_outlined,
                    width: 48,
                    height: 48,
                    primary: scheme.error,
                    borderRadius: BorderRadius.circular(8),
                    onLongPress: () {
                      _showSnack(context, 'Long pressed notification');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        _GallerySection(
          title: 'Controller And Flags',
          child: _DemoCard(
            title: 'GlobalKey state',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AndrossyButton(
                  key: _stateButtonKey,
                  text: 'Controlled button',
                  icon: Icons.tune,
                  enabled: _enabled,
                  loading: _loading,
                  activated: _activated,
                  textAllCaps: true,
                  centerText: true,
                  width: double.infinity,
                  primary: scheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  onTap: () => _showSnack(context, 'Controlled tap'),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Enabled'),
                      selected: _enabled,
                      onSelected: (value) {
                        setState(() => _enabled = value);
                        _stateButtonKey.currentState?.setEnabled(value);
                      },
                    ),
                    FilterChip(
                      label: const Text('Loading'),
                      selected: _loading,
                      onSelected: (value) {
                        setState(() => _loading = value);
                        _stateButtonKey.currentState?.setLoading(value);
                      },
                    ),
                    FilterChip(
                      label: const Text('Activated'),
                      selected: _activated,
                      onSelected: (value) {
                        setState(() => _activated = value);
                        _stateButtonKey.currentState?.setActivated(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AndrossyButtonSkeletonExamplePage extends StatelessWidget {
  const AndrossyButtonSkeletonExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyButtonSkeleton',
      children: [
        _GallerySection(
          title: 'Content Layout',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Text Only',
                child: _SkeletonFrame(
                  child: AndrossyButtonSkeleton(
                    text: 'Create account',
                    textColor: scheme.primary,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Start Icon',
                child: _SkeletonFrame(
                  child: AndrossyButtonSkeleton(
                    icon: Icons.download_outlined,
                    iconAlignment: IconAlignment.start,
                    text: 'Download',
                    iconColor: scheme.secondary,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Centered Text',
                child: _SkeletonFrame(
                  child: AndrossyButtonSkeleton(
                    width: double.infinity,
                    icon: Icons.chevron_right,
                    iconFlexible: true,
                    text: 'Next step',
                    textCenter: true,
                    iconColor: scheme.tertiary,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Loading Indicator',
                child: _SkeletonFrame(
                  child: AndrossyButtonSkeleton(
                    text: 'Syncing',
                    indicatorVisible: true,
                    indicatorColor: scheme.primary,
                    indicatorSize: 24,
                    padding: const EdgeInsets.all(12),
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

class _SkeletonFrame extends StatelessWidget {
  const _SkeletonFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class AndrossyAvatarExamplePage extends StatelessWidget {
  const AndrossyAvatarExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyAvatar',
      children: [
        _GallerySection(
          title: 'Avatar Sources',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Photo',
                child: Row(
                  children: [
                    AndrossyAvatar(
                      _assetPhoto,
                      size: 72,
                      border: Border.all(color: scheme.primary, width: 3),
                      shadow: BoxShadow(
                        color: scheme.primary.withValues(alpha: 0.2),
                        blurRadius: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const AndrossyAvatar(_assetPhoto, size: 48),
                    const SizedBox(width: 16),
                    const AndrossyAvatar(_assetPhoto, size: 34),
                  ],
                ),
              ),
              _DemoCard(
                title: 'Vector And Empty',
                child: Row(
                  children: [
                    AndrossyAvatar(
                      _assetMark,
                      size: 72,
                      backgroundColor: scheme.primaryContainer,
                    ),
                    const SizedBox(width: 16),
                    AndrossyAvatar(
                      null,
                      size: 72,
                      backgroundColor: scheme.surfaceContainerHighest,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AndrossyIconExamplePage extends StatelessWidget {
  const AndrossyIconExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyIcon',
      children: [
        _GallerySection(
          title: 'Icon Data',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Material Icons',
                child: Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: [
                    AndrossyIcon(
                      Icons.home_rounded,
                      size: 34,
                      color: scheme.primary,
                    ),
                    AndrossyIcon(
                      Icons.lock_outline,
                      size: 34,
                      color: scheme.secondary,
                    ),
                    AndrossyIcon(
                      Icons.cloud_done_outlined,
                      size: 34,
                      color: scheme.tertiary,
                    ),
                  ],
                ),
              ),
              _DemoCard(
                title: 'SVG Asset',
                child: Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: [
                    const AndrossyIcon(_assetMark, size: 52),
                    AndrossyIcon(
                      _assetMark,
                      size: 52,
                      color: scheme.error,
                      tintMode: BlendMode.srcIn,
                    ),
                    const AndrossyIcon(
                      Icons.visibility_off_outlined,
                      visibility: false,
                      size: 52,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AndrossyImageExamplePage extends StatelessWidget {
  const AndrossyImageExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyImage',
      children: [
        _GallerySection(
          title: 'Sources And Rendering',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Asset Photo',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const AndrossyImage(
                    _assetPhoto,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _DemoCard(
                title: 'SVG Asset',
                child: _SurfaceBox(
                  height: 150,
                  child: const Center(
                    child: AndrossyImage(_assetMark, width: 96, height: 96),
                  ),
                ),
              ),
              _DemoCard(
                title: 'SVG Code',
                child: _SurfaceBox(
                  height: 150,
                  color: scheme.primaryContainer.withValues(alpha: 0.45),
                  child: const Center(
                    child: AndrossyImage(
                      _svgCode,
                      width: 96,
                      height: 96,
                      type: AndrossyImageType.svgCode,
                    ),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Tint And Hidden',
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AndrossyImage(
                        _assetPhoto,
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                        tint: scheme.secondary.withValues(alpha: 0.45),
                        tintMode: BlendMode.srcATop,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const AndrossyImage(
                      _assetPhoto,
                      visibility: false,
                      width: 92,
                      height: 92,
                    ),
                    const _StatusPill(text: 'Hidden'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AndrossyThumbnailExamplePage extends StatelessWidget {
  const AndrossyThumbnailExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyThumbnail',
      children: [
        _GallerySection(
          title: 'Video Thumbnails',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Default Play',
                child: AndrossyThumbnail(
                  _assetPhoto,
                  onPlay: () => _showSnack(context, 'Play tapped'),
                ),
              ),
              _DemoCard(
                title: 'Cinematic',
                child: AndrossyThumbnail(
                  _assetPhoto,
                  frameRatio: 16 / 9,
                  foregroundColor: Colors.black.withValues(alpha: 0.24),
                  buttonBackgroundColor: scheme.primary,
                  buttonRadius: 17,
                  onPlay: () => _showSnack(context, 'Cinematic play'),
                ),
              ),
              _DemoCard(
                title: 'Custom Button',
                child: AndrossyThumbnail(
                  _assetPhoto,
                  frameRatio: 4 / 3,
                  button: Center(
                    child: FilledButton.icon(
                      onPressed: () => _showSnack(context, 'Preview opened'),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Preview'),
                    ),
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

class AndrossyImageGridExamplePage extends StatelessWidget {
  const AndrossyImageGridExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyImageGrid',
      children: [
        _GallerySection(
          title: 'Layer Counts',
          child: _DemoGrid(
            minWidth: 190,
            children: [
              for (final count in [1, 2, 3, 4, 5, 6, 9])
                _DemoCard(title: '$count items', child: _grid(count)),
            ],
          ),
        ),
        _GallerySection(
          title: 'Custom Ratios',
          child: _DemoCard(
            title: 'Per layer frame ratio',
            child: AndrossyImageGrid(
              itemCount: 5,
              itemSpace: 6,
              frameRatioBuilder: (layer) => layer == 5 ? 16 / 9 : null,
              itemBuilder: (context, index) => _GridTile(index: index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _grid(int count) {
    return AndrossyImageGrid(
      itemCount: count,
      itemSpace: 5,
      itemBackground: Colors.black12,
      itemBuilder: (context, index) => _GridTile(index: index),
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.index});

  final int index;

  static const _colors = [
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFF9A825),
    Color(0xFF6A1B9A),
    Color(0xFFC62828),
    Color(0xFF00838F),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _colors[index % _colors.length],
      child: Center(
        child: Text(
          '${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class AndrossyTextExamplePage extends StatelessWidget {
  const AndrossyTextExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyText',
      children: [
        _GallerySection(
          title: 'Text Variants',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Plain And Styled',
                child: AndrossyText(
                  'Readable text with Material theming.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              _DemoCard(
                title: 'Prefix, Spans, Suffix',
                child: AndrossyText(
                  'body',
                  prefix: 'Prefix ',
                  suffix: ' suffix',
                  style: Theme.of(context).textTheme.bodyLarge,
                  prefixStyle: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                  suffixStyle: TextStyle(
                    color: scheme.secondary,
                    fontWeight: FontWeight.w800,
                  ),
                  spans: [
                    TextSpan(
                      text: ' with rich span',
                      style: TextStyle(color: scheme.tertiary),
                    ),
                  ],
                  onClick: (context) => _showSnack(context, 'Text tapped'),
                ),
              ),
              _DemoCard(
                title: 'Translated',
                child: AndrossyText(
                  'dashboard.title',
                  translate: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              _DemoCard(
                title: 'Custom Ellipsis',
                child: SizedBox(
                  width: 220,
                  child: AndrossyText(
                    _longText,
                    maxLines: 2,
                    ellipsis: ' ...',
                    style: Theme.of(context).textTheme.bodyMedium,
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

class AndrossyExpandableTextExamplePage extends StatelessWidget {
  const AndrossyExpandableTextExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyExpandableText',
      children: [
        _GallerySection(
          title: 'Expandable Copy',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Animated',
                child: AndrossyExpandableText(
                  _longText,
                  initial: 72,
                  duration: const Duration(milliseconds: 8),
                  curve: Curves.easeOutCubic,
                  style: Theme.of(context).textTheme.bodyLarge,
                  expandableStyle: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _DemoCard(
                title: 'Instant',
                child: AndrossyExpandableText(
                  _longText,
                  initial: 46,
                  duration: Duration.zero,
                  expandedText: ' show less',
                  unexpandedText: ' show more',
                  expandableStyle: TextStyle(
                    color: scheme.secondary,
                    fontWeight: FontWeight.w800,
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

class AndrossyFadeExamplePage extends StatelessWidget {
  const AndrossyFadeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyFade',
      children: [
        _GallerySection(
          title: 'Fade Masks',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Horizontal',
                child: SizedBox(
                  height: 64,
                  child: AndrossyFade(
                    side: FadeSide.horizontal,
                    fadeWidthFraction: 0.35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Chip(label: Text('Filter ${index + 1}'));
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemCount: 12,
                    ),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Vertical',
                child: SizedBox(
                  height: 160,
                  child: AndrossyFade(
                    side: FadeSide.vertical,
                    fadeWidthFraction: 0.3,
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text('Activity ${index + 1}'),
                        );
                      },
                    ),
                  ),
                ),
              ),
              _DemoCard(
                title: 'One Side',
                child: SizedBox(
                  height: 110,
                  child: AndrossyFade(
                    side: FadeSide.bottom,
                    fadeWidthFraction: 0.28,
                    child: _SurfaceBox(
                      padding: const EdgeInsets.all(12),
                      child: Text(_longText.repeat(2)),
                    ),
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

extension _StringRepeat on String {
  String repeat(int count) => List.filled(count, this).join(' ');
}

class AndrossyFlexExamplePage extends StatelessWidget {
  const AndrossyFlexExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyFlex',
      children: [
        _GallerySection(
          title: 'Overlay Positions',
          child: _DemoGrid(
            minWidth: 180,
            children: [
              _flexCard(context, 'Start', FlexPosition.start, scheme.primary),
              _flexCard(context, 'End', FlexPosition.end, scheme.secondary),
              _flexCard(context, 'Above', FlexPosition.above, scheme.tertiary),
              _flexCard(context, 'Down', FlexPosition.down, scheme.error),
              _flexCard(
                context,
                'Behind',
                FlexPosition.centerX,
                scheme.primary,
                frontMode: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _flexCard(
    BuildContext context,
    String title,
    FlexPosition position,
    Color color, {
    bool frontMode = true,
  }) {
    return _DemoCard(
      title: title,
      child: SizedBox(
        height: 130,
        child: AndrossyFlex(
          flexPosition: position,
          frontMode: frontMode,
          flexible: _IconBadge(icon: Icons.bolt, color: color),
          child: _SurfaceBox(
            height: 120,
            padding: EdgeInsets.zero,
            child: Center(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AndrossyGuidelineExamplePage extends StatefulWidget {
  const AndrossyGuidelineExamplePage({super.key});

  @override
  State<AndrossyGuidelineExamplePage> createState() {
    return _AndrossyGuidelineExamplePageState();
  }
}

class _AndrossyGuidelineExamplePageState
    extends State<AndrossyGuidelineExamplePage> {
  double _x = 8;
  double _y = -8;
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyGuideline',
      children: [
        _GallerySection(
          title: 'Offset Guide',
          child: _DemoCard(
            title: 'Layout percentage',
            trailing: _StatusPill(
              text: 'x ${_x.round()} y ${_y.round()}',
              active: _visible,
            ),
            child: Column(
              children: [
                _SurfaceBox(
                  height: 240,
                  child: AndrossyGuideline(
                    visibility: _visible,
                    x: _x,
                    y: _y,
                    child: const _GuidelineMarker(),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Visible'),
                  value: _visible,
                  onChanged: (value) => setState(() => _visible = value),
                ),
                Slider(
                  value: _x,
                  min: -25,
                  max: 25,
                  divisions: 50,
                  label: 'x ${_x.round()}',
                  onChanged: (value) => setState(() => _x = value),
                ),
                Slider(
                  value: _y,
                  min: -25,
                  max: 25,
                  divisions: 50,
                  label: 'y ${_y.round()}',
                  onChanged: (value) => setState(() => _y = value),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GuidelineMarker extends StatelessWidget {
  const _GuidelineMarker();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: 86,
        height: 86,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.control_camera, color: Colors.white),
      ),
    );
  }
}

class AndrossyCoordinatorExamplePage extends StatelessWidget {
  const AndrossyCoordinatorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: AndrossyCoordinator(
          header: Container(
            height: 180,
            alignment: Alignment.center,
            color: scheme.primaryContainer,
            child: Text(
              'Scrollable Header',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          toolbar: AndrossyToolbar(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: scheme.surface,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: 'AndrossyCoordinator',
            actions: [
              IconButton(
                onPressed: () => _showSnack(context, 'Pinned toolbar action'),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            itemBuilder: (context, index) {
              return _SurfaceBox(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Nested item ${index + 1}'),
                  subtitle: const Text('Body scrolls under the header'),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: 18,
          ),
        ),
      ),
    );
  }
}

class AndrossyToolbarExamplePage extends StatelessWidget {
  const AndrossyToolbarExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyToolbar',
      children: [
        _GallerySection(
          title: 'Toolbar Layouts',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Centered',
                child: AndrossyToolbar(
                  padding: EdgeInsets.zero,
                  backgroundColor: scheme.surfaceContainerHighest,
                  title: 'Centered title',
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              _DemoCard(
                title: 'Side Title',
                child: AndrossyToolbar(
                  padding: EdgeInsets.zero,
                  centerTitle: false,
                  title: 'Left aligned',
                  backgroundColor: scheme.primaryContainer,
                  leading: const Icon(Icons.layers_outlined),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.check_circle_outline),
                    ),
                  ],
                ),
              ),
              _DemoCard(
                title: 'Custom Child',
                child: AndrossyToolbar(
                  padding: EdgeInsets.zero,
                  backgroundColor: scheme.secondaryContainer,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search toolbar',
                      isDense: true,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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

class AndrossyCountdownExamplePage extends StatefulWidget {
  const AndrossyCountdownExamplePage({super.key});

  @override
  State<AndrossyCountdownExamplePage> createState() {
    return _AndrossyCountdownExamplePageState();
  }
}

class _AndrossyCountdownExamplePageState
    extends State<AndrossyCountdownExamplePage> {
  final _key = GlobalKey<AndrossyCountdownState>();
  Duration _remaining = const Duration(seconds: 10);
  bool _complete = false;

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyCountdown',
      children: [
        _GallerySection(
          title: 'Controlled Timer',
          child: _DemoCard(
            title: '10 second countdown',
            trailing: _StatusPill(
              text: _complete ? 'Complete' : 'Running',
              active: !_complete,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AndrossyCountdown(
                  key: _key,
                  target: const Duration(seconds: 10),
                  initialStartMode: false,
                  onRemaining: (value) => setState(() => _remaining = value),
                  onComplete: (complete) {
                    setState(() {
                      _complete = complete;
                      if (complete) _remaining = Duration.zero;
                    });
                  },
                  builder: (context, duration) {
                    return Text(
                      '${duration.inSeconds}s',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    );
                  },
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 1 - (_remaining.inMilliseconds / 10000).clamp(0, 1),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        setState(() => _complete = false);
                        _key.currentState?.start();
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _key.currentState?.stop(),
                      icon: const Icon(Icons.pause),
                      label: const Text('Stop'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _remaining = const Duration(seconds: 10);
                          _complete = false;
                        });
                        _key.currentState?.restart();
                      },
                      icon: const Icon(Icons.replay),
                      label: const Text('Restart'),
                    ),
                    TextButton.icon(
                      onPressed: () => _key.currentState?.clear(),
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AndrossyDataKeeperExamplePage extends StatefulWidget {
  const AndrossyDataKeeperExamplePage({super.key});

  @override
  State<AndrossyDataKeeperExamplePage> createState() {
    return _AndrossyDataKeeperExamplePageState();
  }
}

class _AndrossyDataKeeperExamplePageState
    extends State<AndrossyDataKeeperExamplePage> {
  int _version = 0;
  bool _cache = true;
  bool _fail = false;

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyDataKeeper',
      children: [
        _GallerySection(
          title: 'Async Data States',
          child: _DemoCard(
            title: 'Cached request',
            trailing: _StatusPill(text: _cache ? 'Cache on' : 'Cache off'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AndrossyDataKeeper<String>(
                  backupKey: 'profile-$_version',
                  cacheEnabled: _cache,
                  cacheFailures: false,
                  callback: _loadProfile,
                  builder: _dataBuilder,
                ),
                const SizedBox(height: 12),
                AndrossyDataKeeper<String>(
                  backupKey: 'initial-state',
                  initial: const AndrossyDataResponse.call('Initial response'),
                  callback: () async => 'Never requested',
                  builder: _dataBuilder,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => setState(() => _version++),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                    FilterChip(
                      label: const Text('Fail next'),
                      selected: _fail,
                      onSelected: (value) => setState(() => _fail = value),
                    ),
                    FilterChip(
                      label: const Text('Cache'),
                      selected: _cache,
                      onSelected: (value) => setState(() => _cache = value),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        AndrossyDataKeeper.clearAllCached();
                        setState(() => _version++);
                      },
                      icon: const Icon(Icons.delete_sweep_outlined),
                      label: const Text('Clear cache'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _loadProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (_fail) throw StateError('Demo request failed');
    return 'Loaded profile #$_version at ${DateTime.now().second}s';
  }

  Widget _dataBuilder(
    BuildContext context,
    AndrossyDataResponse<String> response,
  ) {
    if (response.loading) {
      return const LinearProgressIndicator();
    }
    if (response.error.isNotEmpty) {
      return _SurfaceBox(
        child: ListTile(
          leading: const Icon(Icons.error_outline),
          title: const Text('Failure'),
          subtitle: Text(response.error),
        ),
      );
    }
    return _SurfaceBox(
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: const Text('Success'),
        subtitle: Text(response.data ?? 'No data'),
      ),
    );
  }
}

class AndrossyObserverExamplePage extends StatefulWidget {
  const AndrossyObserverExamplePage({super.key});

  @override
  State<AndrossyObserverExamplePage> createState() {
    return _AndrossyObserverExamplePageState();
  }
}

class _AndrossyObserverExamplePageState
    extends State<AndrossyObserverExamplePage> {
  final Observer<int> _counter = 0.obx;
  final Observer<List<String>> _tags = <String>[].obx;

  @override
  void dispose() {
    _counter.dispose();
    _tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossyObserver',
      children: [
        _GallerySection(
          title: 'Reactive Values',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Counter',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AndrossyObserver<int>(
                      observer: _counter,
                      builder: (context, value) {
                        return Text(
                          '$value',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => _counter.value++,
                          icon: const Icon(Icons.add),
                          label: const Text('Add'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _counter.value = 0,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _DemoCard(
                title: 'List Extensions',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AndrossyObserver<List<String>>(
                      observer: _tags,
                      builder: (context, tags) {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in tags) Chip(label: Text(tag)),
                            if (tags.isEmpty)
                              const _StatusPill(text: 'No tags selected'),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final tag in ['Design', 'Build', 'Review'])
                          FilterChip(
                            label: Text(tag),
                            selected: _tags.value.contains(tag),
                            onSelected: (_) => _tags.toggle(tag),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AndrossyOptionExamplePage extends StatefulWidget {
  const AndrossyOptionExamplePage({super.key});

  @override
  State<AndrossyOptionExamplePage> createState() {
    return _AndrossyOptionExamplePageState();
  }
}

class _AndrossyOptionExamplePageState extends State<AndrossyOptionExamplePage> {
  int _plan = 1;
  int _density = 0;
  int _shipping = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyOption',
      children: [
        _GallerySection(
          title: 'Option Groups',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Horizontal',
                child: AndrossyOption(
                  direction: Axis.horizontal,
                  itemCount: 3,
                  currentIndex: _plan,
                  spaceBetween: 8,
                  flex: const AndrossyOptionProperty(active: 2, inactive: 1),
                  onChanged: (index) => setState(() => _plan = index),
                  builder: (context, index, selected) {
                    const plans = ['Free', 'Pro', 'Team'];
                    return _OptionItem(
                      label: plans[index],
                      selected: selected,
                      color: scheme.primary,
                    );
                  },
                ),
              ),
              _DemoCard(
                title: 'Vertical',
                child: AndrossyOption(
                  itemCount: 3,
                  currentIndex: _shipping,
                  spaceBetween: 8,
                  onChanged: (index) => setState(() => _shipping = index),
                  gesture: (context, child, callback) {
                    return AndrossyGesture(
                      onTap: callback,
                      effects: const [GestureAnimation.scale(target: 0.98)],
                      child: child,
                    );
                  },
                  builder: (context, index, selected) {
                    const values = ['Pickup', 'Standard', 'Express'];
                    return _OptionItem(
                      label: values[index],
                      selected: selected,
                      color: scheme.secondary,
                    );
                  },
                ),
              ),
              _DemoCard(
                title: 'Compact',
                child: AndrossyOption(
                  direction: Axis.horizontal,
                  itemCount: 2,
                  currentIndex: _density,
                  spaceBetween: 8,
                  onChanged: (index) => setState(() => _density = index),
                  builder: (context, index, selected) {
                    return ChoiceChip(
                      label: Text(index == 0 ? 'Comfortable' : 'Compact'),
                      selected: selected,
                      onSelected: (_) {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    required this.label,
    required this.selected,
    required this.color,
  });

  final String label;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: 0.14) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              selected ? color : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: selected ? color : null,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class AndrossySelectionExamplePage extends StatefulWidget {
  const AndrossySelectionExamplePage({super.key});

  @override
  State<AndrossySelectionExamplePage> createState() {
    return _AndrossySelectionExamplePageState();
  }
}

class _AndrossySelectionExamplePageState
    extends State<AndrossySelectionExamplePage> {
  final _filter = TextEditingController();
  List<String> _selected = const ['flutter'];
  List<String> _single = const ['weekly'];

  static const _topics = [
    'flutter',
    'dart',
    'widgets',
    'forms',
    'animation',
    'layout',
    'testing',
    'release',
  ];

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossySelection',
      children: [
        _GallerySection(
          title: 'Multi Select',
          child: _DemoCard(
            title: 'Filterable chips',
            trailing: _StatusPill(text: '${_selected.length} selected'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _filter,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Filter topics',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                AndrossySelection<String>(
                  controller: _filter,
                  items: _topics,
                  initialTags: _selected,
                  filterMode: true,
                  onSelectedTags: (tags) => setState(() => _selected = tags),
                  tagBuilder: (value) => value,
                  searchBuilder: (query, value) {
                    return value.contains(query.trim().toLowerCase());
                  },
                  builder: (context, instance) {
                    return FilterChip(
                      label: Text(instance.data),
                      selected: instance.selected,
                      onSelected: (_) => instance.call(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        _GallerySection(
          title: 'Single Select',
          child: _DemoCard(
            title: 'List builder',
            child: AndrossySelection<String>(
              items: const ['daily', 'weekly', 'monthly'],
              singleMode: true,
              initialTags: _single,
              onSelectedTags: (tags) => setState(() => _single = tags),
              tagBuilder: (value) => value,
              listBuilder: (context, children) {
                return Column(children: children);
              },
              builder: (context, instance) {
                return ListTile(
                  onTap: instance.call,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: Icon(
                    instance.selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  title: Text(instance.data),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class AndrossyRatingExamplePage extends StatefulWidget {
  const AndrossyRatingExamplePage({super.key});

  @override
  State<AndrossyRatingExamplePage> createState() {
    return _AndrossyRatingExamplePageState();
  }
}

class _AndrossyRatingExamplePageState extends State<AndrossyRatingExamplePage> {
  double _stars = 3.5;
  double _hearts = 2;
  double _vertical = 1;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyRating',
      children: [
        _GallerySection(
          title: 'Interactive Ratings',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Half Stars',
                trailing: _StatusPill(text: _stars.toStringAsFixed(1)),
                child: AndrossyRating(
                  initialRating: _stars,
                  allowHalfRating: true,
                  updateOnDrag: true,
                  itemPadding: const EdgeInsets.only(right: 4),
                  glowColor: scheme.primary,
                  unratedColor: scheme.outlineVariant,
                  icon: AndrossyRatingIcon(
                    full: Icon(Icons.star_rounded, color: scheme.primary),
                    half: Icon(Icons.star_half_rounded, color: scheme.primary),
                    empty: Icon(
                      Icons.star_border_rounded,
                      color: scheme.outlineVariant,
                    ),
                  ),
                  onRatingChange: (value) => setState(() => _stars = value),
                ),
              ),
              _DemoCard(
                title: 'Builder',
                trailing: _StatusPill(text: _hearts.toStringAsFixed(0)),
                child: AndrossyRating.builder(
                  initialRating: _hearts,
                  itemCount: 5,
                  itemSize: 34,
                  glowColor: scheme.error,
                  unratedColor: scheme.outlineVariant,
                  itemBuilder: (context, index) {
                    return Icon(Icons.favorite, color: scheme.error);
                  },
                  onRatingChange: (value) => setState(() => _hearts = value),
                ),
              ),
              _DemoCard(
                title: 'Vertical',
                trailing: _StatusPill(text: _vertical.toStringAsFixed(0)),
                child: AndrossyRating.builder(
                  direction: Axis.vertical,
                  initialRating: _vertical,
                  itemCount: 4,
                  itemSize: 30,
                  tapOnlyMode: true,
                  itemPadding: const EdgeInsets.only(bottom: 4),
                  itemBuilder: (context, index) {
                    return Icon(Icons.circle, color: scheme.secondary);
                  },
                  onRatingChange: (value) => setState(() => _vertical = value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AndrossyRatingIndicatorExamplePage extends StatelessWidget {
  const AndrossyRatingIndicatorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyRatingIndicator',
      children: [
        _GallerySection(
          title: 'Read Only Ratings',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Fractional',
                child: AndrossyRatingIndicator(
                  rating: 3.65,
                  unratedColor: scheme.outlineVariant,
                  itemPadding: const EdgeInsets.only(right: 4),
                  itemBuilder: _ratingStar,
                ),
              ),
              _DemoCard(
                title: 'RTL',
                child: AndrossyRatingIndicator(
                  rating: 2.4,
                  textDirection: TextDirection.rtl,
                  unratedColor: scheme.outlineVariant,
                  itemPadding: const EdgeInsets.only(left: 4),
                  itemBuilder: _ratingStar,
                ),
              ),
              _DemoCard(
                title: 'Vertical',
                child: AndrossyRatingIndicator(
                  rating: 4.25,
                  direction: Axis.vertical,
                  itemSize: 30,
                  unratedColor: scheme.outlineVariant,
                  itemPadding: const EdgeInsets.only(bottom: 4),
                  itemBuilder: (context, index) {
                    return Icon(Icons.hexagon, color: scheme.secondary);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _ratingStar(BuildContext context, int index) {
  return Icon(Icons.star_rounded, color: Theme.of(context).colorScheme.primary);
}

class AndrossySliderExamplePage extends StatefulWidget {
  const AndrossySliderExamplePage({super.key});

  @override
  State<AndrossySliderExamplePage> createState() {
    return _AndrossySliderExamplePageState();
  }
}

class _AndrossySliderExamplePageState extends State<AndrossySliderExamplePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossySlider',
      children: [
        _GallerySection(
          title: 'Page Slider',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Default Counter',
                trailing: _StatusPill(text: '${_index + 1} / 4'),
                child: AndrossySlider(
                  itemCount: 4,
                  index: _index,
                  frameRatio: 16 / 9,
                  onChanged: (value) => setState(() => _index = value),
                  builder: (context, index) => _Slide(index: index),
                ),
              ),
              _DemoCard(
                title: 'Custom Counter',
                child: AndrossySlider(
                  itemCount: 3,
                  frameRatio: 4 / 3,
                  counterPosition: PositionType.bottomRight,
                  counterBuilder: (context, index) {
                    return AndrossySlideCounter(
                      text: 'Photo ${index + 1}',
                      backgroundColor: scheme.primary,
                    );
                  },
                  builder: (context, index) => _Slide(index: index + 4),
                ),
              ),
              _DemoCard(
                title: 'No Counter',
                child: AndrossySlider(
                  itemCount: 2,
                  frameRatio: 2,
                  showCounter: false,
                  builder: (context, index) => _Slide(index: index + 7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.index});

  final int index;

  static const _colors = [
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFF9A825),
    Color(0xFFC62828),
    Color(0xFF6A1B9A),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _colors[index % _colors.length],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Slide ${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class AndrossySwitchExamplePage extends StatefulWidget {
  const AndrossySwitchExamplePage({super.key});

  @override
  State<AndrossySwitchExamplePage> createState() {
    return _AndrossySwitchExamplePageState();
  }
}

class _AndrossySwitchExamplePageState extends State<AndrossySwitchExamplePage> {
  bool _wifi = true;
  bool _theme = false;
  bool _large = true;
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossySwitch',
      children: [
        _GallerySection(
          title: 'Switch States',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Default',
                child: _SwitchRow(
                  label: 'Wi-Fi',
                  value: _wifi,
                  child: AndrossySwitch(
                    value: _wifi,
                    onChanged: (value) => setState(() => _wifi = value),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Icons',
                child: _SwitchRow(
                  label: 'Theme',
                  value: _theme,
                  child: AndrossySwitch(
                    value: _theme,
                    size: 34,
                    activeThumbIcon: Icons.dark_mode,
                    inactiveThumbIcon: Icons.light_mode,
                    activeThumbIconTint: scheme.primary,
                    inactiveThumbIconTint: Colors.white,
                    activeTrackColor: scheme.primaryContainer,
                    inactiveTrackColor: scheme.secondary,
                    onChanged: (value) => setState(() => _theme = value),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Large Custom',
                child: _SwitchRow(
                  label: 'Automation',
                  value: _large,
                  child: AndrossySwitch(
                    value: _large,
                    size: 44,
                    trackRatio: 2.2,
                    trackStrokeSize: 2,
                    activeTrackColor: scheme.tertiary,
                    inactiveTrackColor: scheme.surfaceContainerHighest,
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: scheme.onSurfaceVariant,
                    onChanged: (value) => setState(() => _large = value),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Disabled And Hidden',
                child: Column(
                  children: [
                    _SwitchRow(
                      label: 'Disabled',
                      value: true,
                      child: const AndrossySwitch(value: true, enabled: false),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Visible'),
                      value: _visible,
                      onChanged: (value) => setState(() => _visible = value),
                    ),
                    AndrossySwitch(visibility: _visible, value: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.child,
  });

  final String label;
  final bool value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        _StatusPill(text: value ? 'On' : 'Off', active: value),
        const SizedBox(width: 10),
        child,
      ],
    );
  }
}

class AndrossyTabExamplePage extends StatelessWidget {
  const AndrossyTabExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyTab',
      children: [
        _GallerySection(
          title: 'Tabs',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Fixed',
                child: SizedBox(
                  height: 250,
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        AndrossyTab(
                          indicatorColor: scheme.primary,
                          indicatorWeight: 3,
                          builder: (context, index, selected) {
                            const labels = ['Today', 'Week', 'Month'];
                            return Tab(
                              child: Text(
                                labels[index],
                                style: TextStyle(
                                  fontWeight: selected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              _TabPane(text: 'Today'),
                              _TabPane(text: 'Week'),
                              _TabPane(text: 'Month'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _DemoCard(
                title: 'Scrollable',
                child: SizedBox(
                  height: 210,
                  child: DefaultTabController(
                    length: 5,
                    child: Column(
                      children: [
                        AndrossyTab(
                          isScrollable: true,
                          indicatorFullWidth: true,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          indicator: BoxDecoration(
                            color: scheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          builder: (context, index, selected) {
                            return Tab(text: 'Tab ${index + 1}');
                          },
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              _TabPane(text: 'One'),
                              _TabPane(text: 'Two'),
                              _TabPane(text: 'Three'),
                              _TabPane(text: 'Four'),
                              _TabPane(text: 'Five'),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _TabPane extends StatelessWidget {
  const _TabPane({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return _SurfaceBox(
      child: Center(
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class AndrossyShimmerExamplePage extends StatelessWidget {
  const AndrossyShimmerExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyShimmer',
      children: [
        _GallerySection(
          title: 'Loading Placeholders',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Default',
                child: AndrossyShimmer(
                  child: Column(
                    children: const [
                      _SkeletonLine(width: double.infinity),
                      SizedBox(height: 10),
                      _SkeletonLine(width: 180),
                      SizedBox(height: 10),
                      _SkeletonLine(width: 240),
                    ],
                  ),
                ),
              ),
              _DemoCard(
                title: 'Custom Colors',
                child: AndrossyShimmer(
                  baseColor: scheme.primary.withValues(alpha: 0.1),
                  highlightColor: scheme.primary.withValues(alpha: 0.35),
                  fadeLowerBound: 0.45,
                  fadeUpperBound: 1,
                  child: const Row(
                    children: [
                      _SkeletonCircle(),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          children: [
                            _SkeletonLine(width: double.infinity),
                            SizedBox(height: 10),
                            _SkeletonLine(width: double.infinity),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _DemoCard(
                title: 'Finite Loop',
                child: AndrossyShimmer(
                  loopCount: 3,
                  shimmerDuration: const Duration(milliseconds: 900),
                  fadeDuration: const Duration(milliseconds: 900),
                  child: const _SkeletonLine(width: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _SkeletonCircle extends StatelessWidget {
  const _SkeletonCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}

class AndrossyHoldGestureExamplePage extends StatefulWidget {
  const AndrossyHoldGestureExamplePage({super.key});

  @override
  State<AndrossyHoldGestureExamplePage> createState() {
    return _AndrossyHoldGestureExamplePageState();
  }
}

class _AndrossyHoldGestureExamplePageState
    extends State<AndrossyHoldGestureExamplePage> {
  int _hold = 0;
  int _smooth = 0;
  bool _holding = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyHoldGesture',
      children: [
        _GallerySection(
          title: 'Press Progress',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Bounded Hold',
                trailing: _StatusPill(text: '$_hold%', active: _holding),
                child: AndrossyHoldGesture(
                  max: 100,
                  duration: const Duration(milliseconds: 14),
                  onStatus: (value) => setState(() => _holding = value),
                  onChanged: (value) => setState(() => _hold = value),
                  child: _HoldPanel(
                    label: 'Hold to fill',
                    value: _hold / 100,
                    color: scheme.primary,
                  ),
                ),
              ),
              _DemoCard(
                title: 'Smooth Release',
                trailing: _StatusPill(text: '$_smooth%'),
                child: AndrossyHoldGesture(
                  max: 100,
                  useSmoothRelease: true,
                  duration: const Duration(milliseconds: 10),
                  reverseDuration: const Duration(milliseconds: 4),
                  onChanged: (value) => setState(() => _smooth = value),
                  child: _HoldPanel(
                    label: 'Release drains',
                    value: _smooth / 100,
                    color: scheme.secondary,
                  ),
                ),
              ),
              _DemoCard(
                title: 'Disabled',
                child: AndrossyHoldGesture(
                  enabled: false,
                  child: _HoldPanel(
                    label: 'Disabled',
                    value: 0.35,
                    color: scheme.outline,
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

class _HoldPanel extends StatelessWidget {
  const _HoldPanel({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return _SurfaceBox(
      height: 124,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.touch_app, color: color),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: value.clamp(0, 1)),
        ],
      ),
    );
  }
}

class AndrossySwiperExamplePage extends StatefulWidget {
  const AndrossySwiperExamplePage({super.key});

  @override
  State<AndrossySwiperExamplePage> createState() {
    return _AndrossySwiperExamplePageState();
  }
}

class _AndrossySwiperExamplePageState extends State<AndrossySwiperExamplePage> {
  String _last = 'Swipe, tap, double tap, or long press';
  int _events = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossySwiper',
      children: [
        _GallerySection(
          title: 'Swipe Detection',
          child: _DemoGrid(
            children: [
              _DemoCard(
                title: 'Singular On End',
                trailing: _StatusPill(text: '$_events'),
                child: AndrossySwiper(
                  behavior: HitTestBehavior.opaque,
                  swipeConfig: const AndrossySwipeConfig(
                    verticalThreshold: 30,
                    horizontalThreshold: 30,
                  ),
                  onTap: () => _event('Tap'),
                  onDoubleTap: () => _event('Double tap'),
                  onLongPress: () => _event('Long press'),
                  onHorizontalSwipe: (direction) =>
                      _event('Horizontal $direction'),
                  onVerticalSwipe: (direction) => _event('Vertical $direction'),
                  child: _SwipePanel(text: _last, color: scheme.primary),
                ),
              ),
              _DemoCard(
                title: 'Continuous',
                child: AndrossySwiper(
                  behavior: HitTestBehavior.opaque,
                  swipeConfig: const AndrossySwipeConfig(
                    horizontalThreshold: 24,
                    swipeDetectionBehavior:
                        AndrossySwipeDetectionBehavior.continuous,
                  ),
                  onHorizontalSwipe: (direction) =>
                      _event('Continuous $direction'),
                  child: _SwipePanel(
                    text: 'Drag left or right',
                    color: scheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _event(String value) {
    setState(() {
      _events++;
      _last = value;
    });
  }
}

class _SwipePanel extends StatelessWidget {
  const _SwipePanel({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return _SurfaceBox(
      height: 180,
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swipe, color: color, size: 36),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class AndrossySplashExamplePage extends StatefulWidget {
  const AndrossySplashExamplePage({super.key});

  @override
  State<AndrossySplashExamplePage> createState() {
    return _AndrossySplashExamplePageState();
  }
}

class _AndrossySplashExamplePageState extends State<AndrossySplashExamplePage> {
  String _stage = 'Waiting for callback';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossySplash',
      children: [
        _GallerySection(
          title: 'Splash Layout',
          child: _DemoCard(
            title: 'Execute then route',
            trailing: _StatusPill(text: _stage),
            child: SizedBox(
              height: 280,
              child: _SurfaceBox(
                color: scheme.primaryContainer.withValues(alpha: 0.45),
                child: AndrossySplash(
                  duration: 900,
                  axisY: -8,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AndrossyIcon(
                        Icons.auto_awesome,
                        color: scheme.primary,
                        size: 54,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Androssy',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LinearProgressIndicator(color: scheme.primary),
                  ),
                  onExecute: (context) async {
                    if (!mounted) return;
                    setState(() => _stage = 'Executing');
                    await Future<void>.delayed(
                      const Duration(milliseconds: 500),
                    );
                  },
                  onRoute: (context) {
                    if (mounted) setState(() => _stage = 'Routed');
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AndrossySingletonExamplePage extends StatefulWidget {
  const AndrossySingletonExamplePage({super.key});

  @override
  State<AndrossySingletonExamplePage> createState() {
    return _AndrossySingletonExamplePageState();
  }
}

class _AndrossySingletonExamplePageState
    extends State<AndrossySingletonExamplePage> {
  bool _keepAlive = true;

  @override
  Widget build(BuildContext context) {
    return _GalleryPage(
      title: 'AndrossySingleton',
      children: [
        _GallerySection(
          title: 'Keep Alive',
          child: _DemoCard(
            title: 'PageView state',
            trailing: _StatusPill(text: _keepAlive ? 'Singleton' : 'Dispose'),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Keep page state alive'),
                  value: _keepAlive,
                  onChanged: (value) => setState(() => _keepAlive = value),
                ),
                SizedBox(
                  height: 190,
                  child: PageView(
                    children: [
                      AndrossySingleton(
                        singleton: _keepAlive,
                        child: const _CounterPanel(title: 'Page A'),
                      ),
                      AndrossySingleton(
                        singleton: _keepAlive,
                        child: const _CounterPanel(title: 'Page B'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CounterPanel extends StatefulWidget {
  const _CounterPanel({required this.title});

  final String title;

  @override
  State<_CounterPanel> createState() => _CounterPanelState();
}

class _CounterPanelState extends State<_CounterPanel> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return _SurfaceBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(
            '$_count',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => setState(() => _count++),
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class AndrossyRenderExamplePage extends StatefulWidget {
  const AndrossyRenderExamplePage({super.key});

  @override
  State<AndrossyRenderExamplePage> createState() {
    return _AndrossyRenderExamplePageState();
  }
}

class _AndrossyRenderExamplePageState extends State<AndrossyRenderExamplePage> {
  bool _expanded = false;
  Size _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyRender',
      children: [
        _GallerySection(
          title: 'Size Reporting',
          child: _DemoCard(
            title: 'Measured child',
            trailing: _StatusPill(
              text: '${_size.width.round()} x ${_size.height.round()}',
              active: _expanded,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AndrossyRender(
                  render: (size) {
                    if (_size == size || !mounted) return;
                    setState(() => _size = size);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    width: _expanded ? 280 : 150,
                    height: _expanded ? 130 : 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Measure me'),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  icon: const Icon(Icons.aspect_ratio),
                  label: const Text('Resize'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AndrossySettingExamplePage extends StatelessWidget {
  const AndrossySettingExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossySetting',
      children: [
        _GallerySection(
          title: 'Settings Rows',
          children: [
            _SettingShell(
              child: AndrossySetting(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _IconBadge(
                      icon: Icons.person_outline, color: scheme.primary),
                ),
                header: const Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                body: const Text('Signed in as demo user'),
                content: const _StatusPill(text: 'Active', active: true),
                tailing: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.chevron_right),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _SettingShell(
              child: AndrossySetting(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _IconBadge(
                    icon: Icons.notifications_outlined,
                    color: scheme.secondary,
                  ),
                ),
                header: const Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                body: const Text('Product updates and releases'),
                content: const AndrossySwitch(value: true),
              ),
            ),
            const SizedBox(height: 10),
            _SettingShell(
              child: AndrossySetting(
                padding: const EdgeInsets.all(16),
                header: const Text(
                  'Compact row',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                body: const Text('No leading widget'),
                tailing: FilledButton(
                  onPressed: () => _showSnack(context, 'Compact setting'),
                  child: const Text('Open'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingShell extends StatelessWidget {
  const _SettingShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}

class AndrossyFormExamplePage extends StatefulWidget {
  const AndrossyFormExamplePage({super.key});

  @override
  State<AndrossyFormExamplePage> createState() =>
      _AndrossyFormExamplePageState();
}

class _AndrossyFormExamplePageState extends State<AndrossyFormExamplePage> {
  final _controller = AndrossyFormController();
  final _nameKey = GlobalKey<AndrossyFieldState>();
  final _emailKey = GlobalKey<AndrossyFieldState>();
  final _codeKey = GlobalKey<AndrossyFieldState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _code = TextEditingController();
  bool _valid = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _GalleryPage(
      title: 'AndrossyForm',
      children: [
        _GallerySection(
          title: 'Shared Defaults',
          child: _DemoCard(
            title: 'Validation controller',
            trailing: _StatusPill(text: _valid ? 'Valid' : 'Incomplete'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AndrossyForm(
                  controller: _controller,
                  initialCheckTime: 200,
                  onValid: (valid) {
                    if (_valid != valid) setState(() => _valid = valid);
                  },
                  animationDuration: const Duration(milliseconds: 220),
                  animationCurve: Curves.easeOutCubic,
                  backgroundColor: AndrossyFieldProperty.all(scheme.surface),
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
                  floatingVisibility: FloatingVisibility.always,
                  footerVisibility: FloatingVisibility.always,
                  counterVisibility: FloatingVisibility.auto,
                  drawableStartTint: AndrossyFieldProperty(
                    enabled: scheme.onSurfaceVariant,
                    focused: scheme.primary,
                  ),
                  children: [
                    AndrossyField(
                      key: _nameKey,
                      controller: _name,
                      hintText: 'Name',
                      minCharacters: 2,
                      inputAction: TextInputAction.next,
                      drawableStart: const AndrossyFieldProperty(
                        enabled: Icons.badge_outlined,
                        focused: Icons.badge,
                      ),
                      onValidator: (value) => value.trim().length >= 2,
                      onError: _errorText,
                    ),
                    const SizedBox(height: 12),
                    AndrossyField(
                      key: _emailKey,
                      controller: _email,
                      hintText: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      drawableStart: const AndrossyFieldProperty(
                        enabled: Icons.mail_outline,
                        focused: Icons.mail,
                      ),
                      onValidator: _isEmail,
                      onError: _errorText,
                    ),
                    const SizedBox(height: 12),
                    AndrossyForm(
                      backgroundColor: AndrossyFieldProperty.all(
                        scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      ),
                      borderColor: AndrossyFieldProperty(
                        enabled: scheme.outlineVariant,
                        focused: scheme.secondary,
                      ),
                      children: [
                        AndrossyField(
                          key: _codeKey,
                          controller: _code,
                          hintText: 'Invite code',
                          helperText: 'Nested form override',
                          maxCharacters: 6,
                          minCharacters: 6,
                          drawableStart: const AndrossyFieldProperty(
                            enabled: Icons.key_outlined,
                            focused: Icons.key,
                          ),
                          onValidator: (value) => value.length == 6,
                          onError: _errorText,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        _controller.validate();
                        setState(() => _valid = _controller.isValid);
                      },
                      icon: const Icon(Icons.fact_check_outlined),
                      label: const Text('Validate'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        _name.clear();
                        _email.clear();
                        _code.clear();
                        _nameKey.currentState?.update();
                        _emailKey.currentState?.update();
                        _codeKey.currentState?.update();
                        setState(() => _valid = false);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _GallerySection(
          title: 'Horizontal Form',
          child: _DemoCard(
            title: 'Fixed width fields',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AndrossyForm(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                borderColor: AndrossyFieldProperty.all(scheme.outlineVariant),
                borderRadius: AndrossyFieldProperty.all(
                  BorderRadius.circular(8),
                ),
                children: const [
                  AndrossyField(width: 160, hintText: 'First name'),
                  SizedBox(width: 10),
                  AndrossyField(width: 160, hintText: 'Last name'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isEmail(String value) {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim());
  }

  String? _errorText(AndrossyFieldError error) {
    return switch (error) {
      AndrossyFieldError.none => null,
      AndrossyFieldError.empty => 'Required',
      AndrossyFieldError.minimum => 'Too short',
      AndrossyFieldError.maximum => 'Too long',
      AndrossyFieldError.invalid => 'Invalid',
      AndrossyFieldError.networkError => 'Network error',
      AndrossyFieldError.alreadyFound => 'Already exists',
      AndrossyFieldError.unmodified => 'Unmodified',
      AndrossyFieldError.error => 'Error',
    };
  }
}
