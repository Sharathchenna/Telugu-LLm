class StopwatchService {
  final Stopwatch _stopWatch = Stopwatch();

  void handleStartStop() {
    if (_stopWatch.isRunning) {
      _stopWatch.reset();
    } else {
      _stopWatch.start();
    }
  }

  Map<String, String> getTiming() {
    var milli = _stopWatch.elapsed.inMilliseconds;

    return {
      "seconds": ((milli ~/ 1000) % 60).toString().padLeft(2, "0"),
      "minutes": ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0"),
      "hours": ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0")
    };
  }

  void dispose() {
    _stopWatch.stop();
  }
}
