class StopwatchService {
  final Stopwatch _stopWatch = Stopwatch();

  // Constants for time units
  static const int secondsInMinutes = 60;
  static const int minutesInHour = 60;

  void handleStartStop() {
    if (_stopWatch.isRunning) {
      _stopWatch.reset();
    } else {
      _stopWatch.start();
    }
  }

  Map<String, String> getTiming() {
    var elapsedSeconds = _stopWatch.elapsed.inSeconds;
    var totalMinutes = elapsedSeconds ~/ secondsInMinutes;
    var remainingSeconds = elapsedSeconds % secondsInMinutes;
    var totalHours = totalMinutes ~/ minutesInHour;
    var remainingMinutes = totalMinutes % minutesInHour;

    return {
      "hours": totalHours.toString().padLeft(2, "0"),
      "minutes": remainingMinutes.toString().padLeft(2, "0"),
      "seconds": remainingSeconds.toString().padLeft(2, "0"),
    };
  }

  void dispose() {
    _stopWatch.stop();
  }
}
