import 'package:flutter/material.dart';

typedef OnAndrossySettingListener = void Function(BuildContext context);

class AndrossySetting extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? content;
  final Widget? leading;
  final Widget? tailing;
  final Widget? subscription;
  final EdgeInsets padding;
  final OnAndrossySettingListener? onClick;

  const AndrossySetting({
    super.key,
    this.header,
    this.body,
    this.content,
    this.leading,
    this.tailing,
    this.subscription,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (header != null) header!,
                if (body != null) body!,
              ],
            ),
          ),
          if (content != null) content!,
          if (tailing != null) tailing!,
        ],
      ),
    );
  }
}
