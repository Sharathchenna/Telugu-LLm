import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.dialogs.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future<void> toggleRecording(BuildContext context) async {
    if (!isRecordStarted) {
      await handleNewRecordingRequest(context);
    } else {
      await startOrStopCurrentRecording();
    }
  }

  Future<void> handleNewRecordingRequest(BuildContext context) async {
    DialogResponse<bool>? isVideoRequested =
        await _dialogService.showCustomDialog(
      variant: DialogType.confirm,
      title: AppLocalizations.of(context)!.videomsg,
      description: AppLocalizations.of(context)!.videomsg2,
      mainButtonTitle: AppLocalizations.of(context)!.accessCamera,
      barrierDismissible: true,
      useSafeArea: true,
      secondaryButtonTitle: AppLocalizations.of(context)!.maybeLater,
    );

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

  String headerText(BuildContext context) => _categoryService.showFront
      ? AppLocalizations.of(context)!.recordingHeader
      : AppLocalizations.of(context)!.startNarating;

  String subTitleText(BuildContext context) => _categoryService.showFront
      ? AppLocalizations.of(context)!.recordingSubHeader
      : "";

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
