import 'package:flutter/widgets.dart';

/// A mixin that provides Android-like lifecycle methods for Flutter StatefulWidgets
mixin LifecycleMixin<T extends StatefulWidget> on State<T> {
  late final _LifecycleObserver _lifecycleObserver;
  late DateTime _startTime;
  late DateTime _initializedTime;
  late DateTime _endTime;
  bool _isFirstBuild = true;
  bool _isResumed = false;
  bool _isVisible = false;
  bool _isInitialized = false;

  /// Whether the widget is currently in resumed state
  bool get isResumed => _isResumed;

  /// Whether the widget is currently visible
  bool get isVisible => _isVisible;

  /// Whether onCreate initialization is complete
  bool get isInitialized => _isInitialized;

  Duration get initializedTime => _initializedTime.difference(_startTime);

  Duration get endTime => _endTime.difference(_startTime);

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = _LifecycleObserver(this);
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
    _startTime = DateTime.now();
    onCreate().whenComplete(() {
      _initializedTime = DateTime.now();
      _isInitialized = true;
      _ready();
    });
    _isFirstBuild = true;
  }

  void _ready() {
    if (initializedTime.inSeconds < 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) onReady();
      });
      return;
    }
    onReady();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _lifecycleObserver.dispose();
    _endTime = DateTime.now();
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

  /// Called when the widget is first created. This is the place to:
  /// - Initialize essential variables and state
  /// - Set up dependencies
  /// - Create controllers
  /// - Initialize database connections
  /// - Set up logging
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onCreate() {
  ///   super.onCreate();
  ///   _pageController = PageController();
  ///   _scrollController = ScrollController();
  ///   _database = AppDatabase();
  ///   _preferences = await SharedPreferences.getInstance();
  /// }
  /// ```
  @protected
  Future<void> onCreate() async {}

  /// Called when onCreate initialization is complete
  /// This is the ideal place to:
  /// - Start initial animations
  /// - Make initial API calls
  /// - Load initial data
  /// - Show welcome messages or tutorials
  /// - Trigger initial UI updates
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onReady() {
  ///   super.onReady();
  ///   _loadInitialData();
  ///   _startWelcomeAnimation();
  ///   _checkForUpdates();
  /// }
  /// ```
  @protected
  void onReady() {}

  /// Called when the widget becomes visible to the user. This is where you should:
  /// - Load initial data
  /// - Initialize UI components
  /// - Set up event listeners
  /// - Register broadcast receivers
  /// - Start location updates
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onStart() {
  ///   super.onStart();
  ///   _loadInitialData();
  ///   _setupEventListeners();
  ///   _locationService.startUpdates();
  ///   SystemChannels.lifecycle.setMessageHandler(_handleLifecycleMessage);
  /// }
  /// ```
  @protected
  void onStart() {}

  /// Called when the widget is fully visible and interactive. Use this to:
  /// - Start animations
  /// - Start media playback
  /// - Start real-time updates
  /// - Subscribe to streams
  /// - Resume game logic
  /// - Start refresh timers
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onResume() {
  ///   super.onResume();
  ///   _startAnimations();
  ///   _videoController.play();
  ///   _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  ///   _streamSubscription = _dataStream.listen(_handleData);
  ///   _gameEngine.resume();
  /// }
  /// ```
  @protected
  void onResume() {}

  /// Called when the widget is no longer in focus but may be visible. Use this to:
  /// - Pause animations
  /// - Pause media playback
  /// - Stop real-time updates
  /// - Save game state
  /// - Cancel refresh timers
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onPause() {
  ///   super.onPause();
  ///   _pauseAnimations();
  ///   _videoController.pause();
  ///   _timer?.cancel();
  ///   _streamSubscription?.pause();
  ///   _gameEngine.pause();
  ///   _saveCurrentState();
  /// }
  /// ```
  @protected
  void onPause() {}

  /// Called when the widget is no longer visible. Use this to:
  /// - Save data
  /// - Unregister listeners
  /// - Stop location updates
  /// - Cancel subscriptions
  /// - Release heavy resources
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onStop() {
  ///   super.onStop();
  ///   _saveData();
  ///   _unregisterEventListeners();
  ///   _locationService.stopUpdates();
  ///   _streamSubscription?.cancel();
  ///   _heavyResources.release();
  /// }
  /// ```
  @protected
  void onStop() {}

  /// Called when the widget is about to be destroyed. Use this to:
  /// - Clean up resources
  /// - Close database connections
  /// - Dispose controllers
  /// - Cancel all pending operations
  /// - Remove all listeners
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onDestroy() {
  ///   super.onDestroy();
  ///   _pageController.dispose();
  ///   _scrollController.dispose();
  ///   _database.close();
  ///   _cancelAllOperations();
  ///   _removeAllListeners();
  /// }
  /// ```
  @protected
  void onDestroy() {}

  /// Called when the widget becomes visible again after being stopped.
  /// Use this to:
  /// - Restore saved state
  /// - Refresh data
  /// - Reinitialize components
  /// - Reconnect to services
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onRestart() {
  ///   super.onRestart();
  ///   _restoreSavedState();
  ///   _refreshData();
  ///   _reinitializeComponents();
  ///   _reconnectServices();
  /// }
  /// ```
  @protected
  void onRestart() {}

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
