import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.dialogs.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';

class RecordingModel extends ReactiveViewModel {
  final _timerService = locator<TimerService>();
  final _categoryService = locator<CategoryService>();
  bool get isRecordStarted => _timerService.isRecordingStarted;
  final _dialogService = locator<DialogService>();
  final _logger = getLogger("Recording Model");

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_timerService, _categoryService];

  Future<void> toggleRecording() async {
    if (!isRecordStarted) {
      await handleNewRecordingRequest();
    } else {
      await startOrStopCurrentRecording();
    }
  }

  Future<void> handleNewRecordingRequest() async {
    DialogResponse<bool>? isVideoRequested = await _dialogService.showCustomDialog(
        variant: DialogType.confirm,
        title: "You can record video too!",
        description:
            "Video recording is available. Do you want to access camera and start recording?",
        mainButtonTitle: "Access camera",
        barrierDismissible: true,
        useSafeArea: true,
        secondaryButtonTitle: "Maybe later");

    if (isVideoRequested!.confirmed) {
      navigateToVideoRecordingView();
    } else {
      await startOrStopCurrentRecording();
    }
  }

  void navigateToVideoRecordingView() {
    _logger.i("Video requested");
    _navigationService.navigateToVideoRecordingView();
  }

  Future<void> startOrStopCurrentRecording() async {
    _logger.i("Start or Stop recording requested");
    await _timerService.startOrStopRecording();
  }

  String get headerText => _categoryService.showFront
      ? "Say something, start recording."
      : "Start narrating a fables now!";

  String get subTitleText => _categoryService.showFront
      ? "Already know what to speak, just go ahead and record!"
      : "";

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
