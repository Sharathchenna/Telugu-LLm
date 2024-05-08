import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.logger.dart';

class NetworkService with ListenableServiceMixin {
  final logger = getLogger("Network service");

  final _hasConnection = ReactiveValue<bool>(false);
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool get hasConnection => _hasConnection.value;

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result = [ConnectivityResult.none];
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logger.e(e.toString());
    }

    _updateConnectionStatus(result);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      _hasConnection.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      _hasConnection.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      _hasConnection.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      _hasConnection.value = false;
    }
    logger.i("Connection State: $hasConnection");
    logger.i("Connection list: $connectivityResult");
    notifyListeners();
  }

  cancel() {
    _connectivitySubscription.cancel();
  }
}
