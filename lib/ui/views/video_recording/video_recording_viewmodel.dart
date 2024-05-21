import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:swaram_ai/services/util_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

import 'package:swaram_ai/ui/common/snack_bar.dart';

class VideoRecordingViewModel extends BaseViewModel
    with WidgetsBindingObserver {
  final Logger _logger = getLogger("Camera Screen Model");
  final _navigationService = locator<NavigationService>();
  final _timerService = locator<TimerService>();
  final _hiveService = locator<HiveService>();
  final _utilService = locator<UtilService>();

  CameraController? controller;

  bool isOverlayOpen = true;
  bool isCameraInitialized = false;
  List<CameraDescription> cameras = [];
  bool isRearCameraSelected = true;
  bool isRecordingInProgress = false;
  File _videoFile = File('');
  bool isCameraPermissionGranted = false;

  VideoRecordingViewModel() {
    getPermissionStatus();
  }

  getPermissionStatus() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    var status = await Permission.camera.status.isGranted &&
        await Permission.microphone.status.isGranted;
    if (status) {
      _logger.i('Camera Permission: GRANTED');
      _logger.i('Microphone Permission: GRANTED');
      isCameraPermissionGranted = true;
      availableCameras().then((value) {
        cameras = value;
        _logger.d(cameras);
        onNewCameraSelected(cameras[0]);
      }).catchError((error) {
        _logger.e("Failed in fetching cameras: ${error.toString()}");
        SnackBarHelper.showSnackBar(
            message: "Error in fetching the cameras",
            contentType: ContentType.failure);
      });
      // Set and initialize the new camera
    } else {
      _logger.e('Camera Permission: DENIED');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  void toggleOverlay() {
    isOverlayOpen = !isOverlayOpen;
    rebuildUi();
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    //Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: true,
    );

    await previousCameraController?.dispose();
    controller = cameraController;
    rebuildUi();

    cameraController.addListener(() {
      rebuildUi();
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _logger.e("Failed in intializing the camera: ${e.toString()}");
      SnackBarHelper.showSnackBar(
          message: "Error in intializing camera",
          contentType: ContentType.failure);
    }
    isCameraInitialized = controller!.value.isInitialized;
    // rebuildUi();
  }

  void toggleCameraHandler() {
    isCameraInitialized = false;
    onNewCameraSelected(
      cameras[isRearCameraSelected ? 0 : 1],
    );
    isRearCameraSelected = !isRearCameraSelected;
    rebuildUi();
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;
    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {
      await cameraController!.startVideoRecording();
      isRecordingInProgress = true;
      _timerService.videoRecordingStarted = true;
      _logger.i(isRecordingInProgress);

      rebuildUi();
    } on CameraException catch (e) {
      _logger.e("Error in stating to record video: $e");
      SnackBarHelper.showSnackBar(
          message: "Something went wrong", contentType: ContentType.failure);
    }
  }

  void closeTapHandler() {
    stopVideoRecording();
    _navigationService.back();
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      XFile file = await controller!.stopVideoRecording();
      _timerService.videoRecordingStarted = false;
      isRecordingInProgress = false;
      _logger.i(isRecordingInProgress);
      rebuildUi();
      return file;
    } on CameraException catch (e) {
      _logger.e("Error stopping video recording: $e");
      SnackBarHelper.showSnackBar(
          message: "Something went wrong", contentType: ContentType.failure);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }
    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      _logger.e("Error pausing video recording: $e");
      SnackBarHelper.showSnackBar(
          message: "Something went wrong", contentType: ContentType.failure);
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }
    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      _logger.e("Error resuming video recording: $e");
      SnackBarHelper.showSnackBar(
          message: "Something went wrong", contentType: ContentType.failure);
    }
  }

  void videoTapHandler() async {
    final userBox = await Hive.openBox(authBox);
    if (isRecordingInProgress) {
      XFile? rawVideo = await stopVideoRecording();
      File videoFile = File(rawVideo!.path);

      final directory = await getApplicationDocumentsDirectory();
      String fileFormat = videoFile.path.split('.').last;
      var userId = userBox.get("auth")["userId"];
      var fileName = "Video_${userId}_${_utilService.generateUniqueId()}";
      fileName = _utilService.sanitizeFileId(fileName);

      _videoFile = await videoFile.copy(
        '${directory.path}/$fileName.$fileFormat',
      );
      _logger.i("Video File Path: $_videoFile");
      _hiveService.saveRecordings(
          recording: Recording(
              id: fileName,
              path: _videoFile.path,
              name: fileName,
              status: onDevice,
              totalTime: "",
              isVideo: true));

      SnackBarHelper.showSnackBar(
          title: "Video Saved",
          message: "Your video has been successfuly saved!",
          contentType: ContentType.success);

      // _startVideoPlayer();
    } else {
      await startVideoRecording();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
