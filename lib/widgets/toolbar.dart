import 'package:flutter/material.dart';

class AndrossyToolbar extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;
  final double titleSpace;
  final TextStyle titleStyle;
  final double height;
  final EdgeInsets padding;
  final bool centerTitle;
  final double elevation;
  final Color? elevationColor;
  final List<Widget> actions;
  final Widget? leading;

  const AndrossyToolbar({
    super.key,
    this.backgroundColor,
    this.title,
    this.titleSpace = 24,
    this.titleStyle = const TextStyle(fontSize: 16),
    this.height = kToolbarHeight,
    this.padding = const EdgeInsets.only(top: 28, left: 8, right: 8),
    this.centerTitle = true,
    this.elevation = 1,
    this.elevationColor,
    this.actions = const [],
    this.leading,
  });

  Widget _title(BuildContext context) {
    return Text(
      title ?? "",
      style: titleStyle,
    );
  }

  Widget _centerMode(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (leading != null) Positioned(left: 0, child: leading!),
        Center(child: _title(context)),
        Positioned(
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: actions,
          ),
        ),
      ],
    );
  }

  Widget _sideMode(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, SizedBox(width: titleSpace)],
        Expanded(child: _title(context)),
        ...actions
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + padding.vertical,
      color: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: centerTitle ? _centerMode(context) : _sideMode(context),
          ),
          if (elevation > 0)
            Divider(
              height: elevation,
              color: elevationColor ?? Colors.grey.withOpacity(0.1),
            ),
        ],
      ),
    );
  }
}
