import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AndrossyTab extends StatefulWidget {
  final bool automaticIndicatorColorAdjustment;
  final TabController? controller;
  final Color? dividerColor;
  final double? dividerHeight;
  final DragStartBehavior dragStartBehavior;
  final bool? enableFeedback;
  final Decoration? indicator;
  final Color? indicatorColor;
  final bool indicatorFullWidth;
  final EdgeInsets indicatorPadding;
  final double indicatorWeight;
  final bool isScrollable;
  final EdgeInsets? margin;
  final MouseCursor? mouseCursor;
  final ValueChanged<int>? onChanged;
  final WidgetStateProperty<Color?>? overlayColor;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final BorderRadius? splashBorderRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final TabAlignment? tabAlignment;
  final TextScaler? textScaler;

  final Widget Function(BuildContext context, int index, bool selected) builder;

  const AndrossyTab({
    super.key,
    this.controller,
    required this.builder,
    this.automaticIndicatorColorAdjustment = true,
    this.dividerColor,
    this.dividerHeight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableFeedback,
    this.indicator,
    this.indicatorColor,
    this.indicatorFullWidth = false,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorWeight = 2,
    this.isScrollable = false,
    this.margin,
    this.mouseCursor,
    this.onChanged,
    this.overlayColor,
    this.padding,
    this.physics,
    this.splashBorderRadius,
    this.splashFactory,
    this.tabAlignment,
    this.textScaler,
  });

  @override
  State<AndrossyTab> createState() => AndrossyTabState();
}

class AndrossyTabState extends State<AndrossyTab> {
  int currentIndex = 0;

  late TabController controller =
      widget.controller ?? DefaultTabController.of(context);

  void changeIndex(int value) {
    if (controller.length <= value || value < 0) return;
    if (value != currentIndex) {
      setState(() {
        currentIndex = value;
        if (widget.onChanged != null) widget.onChanged!(currentIndex);
      });
    }
  }

  void changePage(double value, [bool notify = false]) {
    int page = value.round();
    if (page != currentIndex) {
      currentIndex = page;
      if (widget.onChanged != null) widget.onChanged?.call(currentIndex);
      if (notify) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    final tc = controller;
    currentIndex = tc.index;
    final anim = tc.animation;
    if (anim != null) {
      anim.addListener(() => changePage(anim.value));
    }
  }

  @override
  void dispose() {
    final anim = controller.animation;
    if (anim != null) {
      anim.removeListener(() => changePage(anim.value));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      automaticIndicatorColorAdjustment:
          widget.automaticIndicatorColorAdjustment,
      controller: controller,
      dividerColor: widget.dividerColor,
      dividerHeight: widget.dividerHeight,
      dragStartBehavior: widget.dragStartBehavior,
      enableFeedback: widget.enableFeedback,
      indicator: widget.indicator,
      indicatorColor: widget.indicatorColor,
      indicatorPadding: widget.indicatorPadding,
      indicatorSize: widget.indicatorFullWidth
          ? TabBarIndicatorSize.tab
          : TabBarIndicatorSize.label,
      indicatorWeight: widget.indicatorWeight,
      isScrollable: widget.isScrollable,
      labelPadding: widget.isScrollable ? widget.margin : null,
      mouseCursor: widget.mouseCursor,
      onTap: changeIndex,
      overlayColor: widget.overlayColor,
      padding: widget.padding,
      physics: widget.physics,
      splashBorderRadius: widget.splashBorderRadius,
      splashFactory: widget.splashFactory,
      tabs: List.generate(controller.length, (index) {
        return widget.builder(context, index, index == currentIndex);
      }),
      tabAlignment: widget.tabAlignment,
      textScaler: widget.textScaler,
    );
  }
}
