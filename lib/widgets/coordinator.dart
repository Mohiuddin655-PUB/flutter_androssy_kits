import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AndrossyCoordinator extends StatelessWidget {
  final ScrollController? controller;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;
  final bool floatHeaderSlivers;
  final Clip clipBehavior;
  final HitTestBehavior hitTestBehavior;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;

  final Widget? header;
  final Widget? toolbar;
  final Widget child;
  final bool floating;
  final bool pinned;
  final double toolbarHeight;

  const AndrossyCoordinator({
    super.key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.floatHeaderSlivers = false,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.restorationId,
    this.scrollBehavior,
    this.header,
    this.toolbar,
    required this.child,
    this.floating = false,
    this.pinned = true,
    this.toolbarHeight = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: controller,
      scrollDirection: scrollDirection,
      reverse: reverse,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      floatHeaderSlivers: floatHeaderSlivers,
      clipBehavior: clipBehavior,
      hitTestBehavior: hitTestBehavior,
      restorationId: restorationId,
      scrollBehavior: scrollBehavior,
      headerSliverBuilder: (BuildContext context, bool isScrolling) {
        return [
          if (header != null) SliverToBoxAdapter(child: header),
          if (toolbar != null)
            SliverPersistentHeader(
              pinned: pinned,
              floating: floating,
              delegate: _SliverAppBarDelegate(
                height: toolbarHeight,
                child: SizedBox(
                  height: toolbarHeight,
                  child: toolbar!,
                ),
              ),
            ),
        ];
      },
      body: child,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _SliverAppBarDelegate({
    required this.height,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double offset, bool overlaps) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
