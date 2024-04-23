import 'package:stacked/stacked.dart';
import 'package:record/record.dart';

class RecordService with ListenableServiceMixin {
  AudioRecorder recorder = AudioRecorder();
  double volume = 0.0;
  double minVolume = -45.0;
}
