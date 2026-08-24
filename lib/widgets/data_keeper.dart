import 'package:flutter/material.dart';

class _Keeper {
  _Keeper._();

  static _Keeper? _i;

  static _Keeper get i => _i ??= _Keeper._();

  final Map<String, Object?> _db = {};
  final Map<String, Future<Object?>> _pending = {};

  String reference<T>(String name) => '${name}_$T';

  Future<T> keep<T>(
    String name,
    Future<T> Function() callback, {
    bool cache = true,
    bool Function(T value)? shouldCache,
  }) async {
    if (!cache) return callback();

    final key = reference<T>(name);
    if (_db.containsKey(key)) return _db[key] as T;

    final pending = _pending[key];
    if (pending != null) return await pending as T;

    final future = callback().then<Object?>((value) {
      if (shouldCache?.call(value) ?? true) _db[key] = value;
      return value;
    });
    _pending[key] = future;
    try {
      return await future as T;
    } finally {
      _pending.remove(key);
    }
  }

  void remove<T>(String name) {
    final key = reference<T>(name);
    _db.remove(key);
    _pending.remove(key);
  }

  void clear() {
    _db.clear();
    _pending.clear();
  }
}

class AndrossyDataResponse<T extends Object?> {
  final bool loading;
  final String error;
  final T? data;

  const AndrossyDataResponse.call(this.data)
      : loading = false,
        error = '';

  const AndrossyDataResponse.loader(this.loading)
      : data = null,
        error = '';

  const AndrossyDataResponse.failure(Object? error)
      : data = null,
        loading = false,
        error = '$error';
}

class AndrossyDataKeeper<T extends Object?> extends StatefulWidget {
  final String backupKey;
  final AndrossyDataResponse<T>? initial;
  final Future<T?> Function() callback;
  final bool cacheEnabled;
  final bool cacheFailures;
  final bool cacheNullData;

  final Widget Function(BuildContext, AndrossyDataResponse<T> value) builder;

  const AndrossyDataKeeper({
    super.key,
    this.initial,
    this.cacheEnabled = true,
    this.cacheFailures = false,
    this.cacheNullData = false,
    required this.backupKey,
    required this.callback,
    required this.builder,
  });

  static void clearCached<T extends Object?>(String backupKey) {
    _Keeper.i.remove<AndrossyDataResponse<T>>(backupKey);
  }

  static void clearAllCached() => _Keeper.i.clear();

  @override
  State<AndrossyDataKeeper<T>> createState() => _AndrossyDataKeeperState();
}

class _AndrossyDataKeeperState<T extends Object?>
    extends State<AndrossyDataKeeper<T>> {
  AndrossyDataResponse<T> _response = AndrossyDataResponse.loader(true);
  int _requestId = 0;

  Future<AndrossyDataResponse<T>> _callback() async {
    try {
      return AndrossyDataResponse.call(await widget.callback());
    } catch (e) {
      return AndrossyDataResponse.failure(e);
    }
  }

  void _fetch() {
    if (widget.initial != null || _response.data != null) {
      _response = widget.initial ?? _response;
      return;
    }
    final requestId = ++_requestId;
    try {
      _Keeper.i
          .keep<AndrossyDataResponse<T>>(
        widget.backupKey,
        _callback,
        cache: widget.cacheEnabled,
        shouldCache: (feedback) =>
            widget.initial == null && _shouldCacheResponse(feedback),
      )
          .then((feedback) {
        if (!mounted || requestId != _requestId) return;
        setState(() => _response = feedback);
      });
    } catch (e) {
      if (!mounted || requestId != _requestId) return;
      setState(() => _response = AndrossyDataResponse.failure(e));
    }
  }

  bool _shouldCacheResponse(AndrossyDataResponse<T> response) {
    if (response.error.isNotEmpty) return widget.cacheFailures;
    if (response.data == null) return widget.cacheNullData;
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetch();
  }

  @override
  void didUpdateWidget(covariant AndrossyDataKeeper<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.backupKey != oldWidget.backupKey) {
      _requestId++;
      _response = widget.initial ?? AndrossyDataResponse.loader(true);
    } else if (widget.initial != oldWidget.initial && widget.initial != null) {
      _requestId++;
      _response = widget.initial!;
    }
    if (_response.data == null) _fetch();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _response);
}
