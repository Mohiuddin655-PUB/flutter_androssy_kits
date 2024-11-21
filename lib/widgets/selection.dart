import 'package:flutter/material.dart';

typedef AndrossySelectionCallback = void Function(String tag);
typedef AndrossySelectionTagBuilder<T> = String Function(T value);
typedef AndrossySelectionSearchBuilder<T> = bool Function(
  String query,
  T value,
);
typedef AndrossySelectionListBuilder<T> = Widget Function(
  BuildContext context,
  List<Widget> children,
);

typedef AndrossySelectionBuilder<T> = Widget Function(
  BuildContext context,
  AndrossySelectionInstance<T> instance,
);

final class AndrossySelectionInstance<T> {
  int index;
  T data;
  String tag;
  bool selected;
  final AndrossySelectionCallback _callback;

  void call() => _callback(tag);

  AndrossySelectionInstance._({
    required this.index,
    required this.data,
    required this.tag,
    this.selected = false,
    required AndrossySelectionCallback callback,
  }) : _callback = callback;
}

class AndrossySelection<T> extends StatefulWidget {
  final TextEditingController? controller;
  final List<T> items;
  final Iterable<String> initialTags;
  final bool singleMode;
  final bool filterMode;
  final ValueChanged<List<String>> onSelectedTags;
  final AndrossySelectionBuilder<T> builder;
  final AndrossySelectionSearchBuilder<T>? searchBuilder;
  final AndrossySelectionTagBuilder<T> tagBuilder;
  final AndrossySelectionListBuilder<T>? listBuilder;

  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;

  const AndrossySelection({
    super.key,
    this.controller,
    this.searchBuilder,
    this.items = const [],
    this.singleMode = false,
    this.filterMode = false,
    this.initialTags = const {},
    required this.onSelectedTags,
    required this.builder,
    required this.tagBuilder,
    this.listBuilder,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 8.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 8.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  @override
  State<AndrossySelection<T>> createState() => _AndrossySelectionState<T>();
}

class _AndrossySelectionState<T> extends State<AndrossySelection<T>> {
  List<String> _tags = [];
  List<AndrossySelectionInstance<T>> _roots = [];
  List<AndrossySelectionInstance<T>> _filtered = [];

  List<AndrossySelectionInstance<T>> _temp = [];

  bool get _isFilterMode {
    return widget.controller != null && widget.searchBuilder != null;
  }

  void _init() {
    _tags = List.from(widget.initialTags);
    _roots = List.generate(widget.items.length, (index) {
      final e = widget.items.elementAt(index);
      final tag = widget.tagBuilder(e);
      return AndrossySelectionInstance._(
        index: index,
        tag: tag,
        data: e,
        callback: _put,
      );
    }).toList();
    _filtered = widget.filterMode ? _merge((e) => e.tag) : _roots;
    _temp = _filtered;
    if (_isFilterMode) widget.controller?.addListener(_filter);
  }

  List<AndrossySelectionInstance<T>> _merge(
    String Function(AndrossySelectionInstance<T>) tag,
  ) {
    final ts = List.from(widget.initialTags);
    final List<AndrossySelectionInstance<T>> oi = [];
    final List<AndrossySelectionInstance<T>> ri = [];
    for (var e in _roots) {
      ts.contains(tag(e)) ? oi.add(e) : ri.add(e);
    }
    oi.sort((a, b) => ts.indexOf(tag(a)).compareTo(ts.indexOf(tag(b))));
    return [...oi, ...ri];
  }

  void _put(String tag) {
    if (widget.singleMode) {
      _tags.clear();
      _tags.add(tag);
    } else {
      if (_tags.contains(tag)) {
        _tags.remove(tag);
      } else {
        if (widget.filterMode) {
          _tags.insert(0, tag);
        } else {
          _tags.add(tag);
        }
      }
    }
    setState(() {});
    widget.onSelectedTags([..._tags]..sort((a, b) => a.compareTo(b)));
  }

  void _filter() {
    final query = widget.controller!.text;
    setState(() {
      if (query.isNotEmpty) {
        final filtered = _filtered.where((e) {
          return widget.searchBuilder!(query, e.data);
        });
        _temp = List.from(filtered);
      } else {
        _temp = _filtered;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AndrossySelection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller ||
        oldWidget.searchBuilder != widget.searchBuilder ||
        oldWidget.initialTags != widget.initialTags ||
        oldWidget.items != widget.items) {
      _init();
    }
  }

  @override
  void dispose() {
    if (_isFilterMode) widget.controller?.removeListener(_filter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = List.generate(_temp.length, (index) {
      final item = _temp.elementAt(index);
      return widget.builder(
        context,
        item..selected = _tags.contains(item.tag),
      );
    });
    if (widget.listBuilder != null) {
      return widget.listBuilder!(context, children);
    }
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      alignment: widget.alignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      clipBehavior: widget.clipBehavior,
      direction: widget.direction,
      runAlignment: widget.runAlignment,
      textDirection: widget.textDirection,
      verticalDirection: widget.verticalDirection,
      children: children,
    );
  }
}
