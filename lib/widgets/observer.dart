import 'package:flutter/material.dart';

class AndrossyObserver<T extends Object?> extends StatelessWidget {
  final Observer<T> observer;
  final Widget Function(BuildContext context, T value) builder;

  const AndrossyObserver({
    super.key,
    required this.builder,
    required this.observer,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: observer,
      builder: (context, child) {
        return builder(context, observer.value);
      },
    );
  }
}

class Observer<T> extends ChangeNotifier {
  T _value;

  Observer(T value) : _value = value;

  T get value => _value;

  set value(T value) {
    _value = value;
    notifyListeners();
  }

  void set(T value) => _value = value;

  Observer<T> notify([VoidCallback? callback]) {
    if (callback != null) callback();
    notifyListeners();
    return this;
  }
}

extension ObserverExtension<T> on T {
  Observer<T> get obx => Observer(this);
}

extension ObserverIterableExtension<E> on Observer<List<E>> {
  Observer<List<E>> toggle(E element, [bool? alreadyInserted]) {
    bool isInserted = alreadyInserted ?? value.contains(element);
    if (isInserted) {
      value = value..remove(element);
    } else {
      value = value..add(element);
    }
    return this;
  }

  Observer<List<E>> add(E element) {
    return notify(() => value.add(element));
  }

  Observer<List<E>> addAll(Iterable<E> elements) {
    return notify(() => value.addAll(elements));
  }

  Observer<List<E>> remove(E element) {
    return notify(() => value.remove(element));
  }

  Observer<List<E>> removeAt(int index) {
    return notify(() => value.removeAt(index));
  }

  Observer<List<E>> insert(int index, E element) {
    return notify(() => value.insert(index, element));
  }

  Observer<List<E>> insertAll(int index, Iterable<E> elements) {
    return notify(() => value.insertAll(index, elements));
  }
}
