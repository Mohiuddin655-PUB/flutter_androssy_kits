import 'package:flutter/material.dart';

class _Keeper {
  _Keeper._();

  static _Keeper? _i;

  static _Keeper get i => _i ??= _Keeper._();

  final Map<String, dynamic> _db = {};

  Future<T> keep<T>(String name, Future<T> Function() callback) async {
    final reference = "${name}_$T";
    return _db[reference] ??= await callback();
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
  final Future<T> Function() callback;

  final Widget Function(BuildContext, AndrossyDataResponse<T> value) builder;

  const AndrossyDataKeeper({
    super.key,
    this.initial,
    required this.backupKey,
    required this.callback,
    required this.builder,
  });

  @override
  State<AndrossyDataKeeper<T>> createState() => _AndrossyDataKeeperState();
}

class _AndrossyDataKeeperState<T extends Object?>
    extends State<AndrossyDataKeeper<T>> {
  AndrossyDataResponse<T> _response = AndrossyDataResponse.loader(true);

  Future<AndrossyDataResponse<T>> _callback() {
    try {
      return widget.callback().then(AndrossyDataResponse.call);
    } catch (e) {
      return Future.value(AndrossyDataResponse.failure(e));
    }
  }

  void _fetch() {
    if (widget.initial != null || _response.data != null) {
      _response = widget.initial ?? _response;
      return;
    }
    try {
      _Keeper.i.keep(widget.backupKey, _callback).then((feedback) {
        setState(() {
          if (feedback.data != null) {
            _response = feedback;
            return;
          }
          _response = feedback;
        });
      });
    } catch (e) {
      setState(() => _response = AndrossyDataResponse.failure(e));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetch();
  }

  @override
  void didUpdateWidget(covariant AndrossyDataKeeper<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_response.data == null) _fetch();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _response);
}
