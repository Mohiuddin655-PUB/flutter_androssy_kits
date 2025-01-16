import 'package:flutter/widgets.dart';

/// A mixin that provides Android-like lifecycle methods for Flutter StatefulWidgets
mixin LifecycleMixin<T extends StatefulWidget> on State<T> {
// Internal state tracking
  late final _LifecycleObserver _lifecycleObserver;
  bool _isFirstBuild = true;
  bool _isResumed = false;
  bool _isVisible = false;

  /// Whether the widget is currently in resumed state
  bool get isResumed => _isResumed;

  /// Whether the widget is currently visible
  bool get isVisible => _isVisible;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = _LifecycleObserver(this);
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
    onCreate();
    _isFirstBuild = true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _lifecycleObserver.dispose();
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstBuild) {
      onStart();
      _isFirstBuild = false;
      _isVisible = true;
      _isResumed = true;
      onResume();
    }
  }

  @override
  void deactivate() {
    if (_isResumed) {
      onPause();
      _isResumed = false;
    }
    if (_isVisible) {
      onStop();
      _isVisible = false;
    }
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    if (!_isVisible) {
      onRestart();
      onStart();
      _isVisible = true;
    }
    if (!_isResumed) {
      onResume();
      _isResumed = true;
    }
  }

  /// Similar to onCreate() in Android
  /// Called when this object is inserted into the tree
  @protected
  void onCreate() {
    // Override this method to implement onCreate behavior
  }

  /// Similar to onStart() in Android
  /// Called when the widget becomes visible
  @protected
  void onStart() {
    // Override this method to implement onStart behavior
  }

  /// Similar to onResume() in Android
  /// Called when the widget is fully visible and interactive
  @protected
  void onResume() {
    // Override this method to implement onResume behavior
  }

  /// Similar to onPause() in Android
  /// Called when the widget is no longer fully visible
  @protected
  void onPause() {
    // Override this method to implement onPause behavior
  }

  /// Similar to onStop() in Android
  /// Called when the widget is no longer visible
  @protected
  void onStop() {
    // Override this method to implement onStop behavior
  }

  /// Similar to onDestroy() in Android
  /// Called when this object is removed from the tree permanently
  @protected
  void onDestroy() {
    // Override this method to implement onDestroy behavior
  }

  /// Similar to onRestart() in Android
  /// Called after onStop() when the widget becomes visible again
  @protected
  void onRestart() {
    // Override this method to implement onRestart behavior
  }

  /// Handles system lifecycle state changes
  void _handleLifecycleChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_isResumed && mounted) {
          if (!_isVisible) {
            onRestart();
            onStart();
          }
          onResume();
          _isResumed = true;
          _isVisible = true;
        }
        break;

      case AppLifecycleState.inactive:
        if (_isResumed) {
          onPause();
          _isResumed = false;
        }
        break;

      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        if (_isVisible) {
          onStop();
          _isVisible = false;
        }
        break;

      case AppLifecycleState.detached:
        if (_isVisible) {
          onStop();
          _isVisible = false;
        }
        break;
    }
  }
}

/// Separate observer class to handle lifecycle events
class _LifecycleObserver with WidgetsBindingObserver {
  final LifecycleMixin _state;
  bool _isDisposed = false;

  _LifecycleObserver(this._state);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isDisposed) {
      _state._handleLifecycleChange(state);
    }
  }

  void dispose() {
    _isDisposed = true;
  }
}
