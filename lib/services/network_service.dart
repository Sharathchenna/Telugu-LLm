import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.logger.dart';

class NetworkService with ListenableServiceMixin {
  final logger = getLogger("Network service");

  final _hasConnection = ReactiveValue<bool>(true);
  late final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool get hasConnection => _hasConnection.value;

  NetworkService() {
    _connectivity = Connectivity();
    _initConnectivity();
  }
  void _initConnectivity() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _hasConnection.value = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
    notifyListeners();
  }

  Future<void> fetchData() async {
    if (!_hasConnection.value) {
      throw Exception('No internet connection');
    }
  }

  cancel() {
    _connectivitySubscription.cancel();
  }
}
