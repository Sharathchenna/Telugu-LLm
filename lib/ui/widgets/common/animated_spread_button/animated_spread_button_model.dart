import 'package:stacked/stacked.dart';

class AnimatedSpreadButtonModel extends BaseViewModel {
  bool micButtonPressed = false;
  startOrStopRecording() {
    micButtonPressed = !micButtonPressed;
    rebuildUi();
  }
}
