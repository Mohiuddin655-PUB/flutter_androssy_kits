import 'package:flutter/material.dart';

class AndrossySingleton extends StatefulWidget {
  final bool singleton;

  const AndrossySingleton({
    super.key,
    this.singleton = true,
    required this.child,
  });

  final Widget child;

  @override
  State<AndrossySingleton> createState() => _AndrossySingletonState();
}

class _AndrossySingletonState extends State<AndrossySingleton>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.singleton;
}
