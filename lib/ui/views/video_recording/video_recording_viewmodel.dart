import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
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
import 'package:swaram_ai/ui/utils/permissions_util.dart';

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
  Timer? _timer;
  bool isRecordingStarted = false;

  VideoRecordingViewModel() {
    getPermissionStatus();
  }

  getPermissionStatus() async {
    var status =
        await PermissionsHandlerUtil.checkAndRequestCameraPermission() &&
            await PermissionsHandlerUtil.checkAndRequestMicroPhonePermission();
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
      _logger.i("isRecordingInProgress $isRecordingInProgress");
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
      isRecordingStarted = false;
      _timer?.cancel();
      XFile? rawVideo = await stopVideoRecording();
      File videoFile = File(rawVideo!.path);
      String dirPath = videoFile.parent.path;

      String fileFormat = videoFile.path.split('.').last;
      String userId = userBox.get("auth")["userId"];
      userId = userId.substring(userId.length - 10);
      int currentUnix = DateTime.now().millisecondsSinceEpoch;

      var fileName = "Video_${userId}_$currentUnix";
      fileName = _utilService.sanitizeFileId(fileName);
      fileName = "$fileName.$fileFormat";

      _videoFile = File("$dirPath/$fileName");

      _videoFile = await videoFile.rename(_videoFile.path);
      _logger.i("Video File Path: ${_videoFile.path}");
      _hiveService.saveRecordings(
        recording: Recording(
            id: fileName,
            path: _videoFile.path,
            name: fileName,
            status: onDevice,
            created: DateTime.now().toIso8601String(),
            isVideo: true),
      );

      SnackBarHelper.showSnackBar(
          title: "Video Saved",
          message: "Your video has been successfuly saved!",
          contentType: ContentType.success);

      // _startVideoPlayer();
    } else {
      await startVideoRecording();
      _timer = Timer.periodic(const Duration(seconds: 10), ((timer) {
        uploadVideoAtEverySixtySeconds();
      }));
    }
  }

  void uploadVideoAtEverySixtySeconds() async {
    final CameraController? cameraController = controller;
    if (isRecordingInProgress) {
      final userBox = await Hive.openBox(authBox);
      if (isRecordingInProgress) {
        isRecordingStarted = true;
        XFile? rawVideo = await stopVideoRecording();
        File videoFile = File(rawVideo!.path);
        String dirPath = videoFile.parent.path;

        String fileFormat = videoFile.path.split('.').last;
        String userId = userBox.get("auth")["userId"];
        userId = userId.substring(userId.length - 10);
        int currentUnix = DateTime.now().millisecondsSinceEpoch;

        var fileName = "Video_${userId}_$currentUnix";
        fileName = _utilService.sanitizeFileId(fileName);
        fileName = "$fileName.$fileFormat";

        _videoFile = File("$dirPath/$fileName");

        _videoFile = await videoFile.rename(_videoFile.path);
        _logger.i("Video File Path: ${_videoFile.path}");
        _hiveService.saveRecordings(
          recording: Recording(
              id: fileName,
              path: _videoFile.path,
              name: fileName,
              status: onDevice,
              created: DateTime.now().toIso8601String(),
              isVideo: true),
        );

        if (cameraController != null) {
          await cameraController.startVideoRecording();
          isRecordingInProgress = true;
          _timerService.videoRecordingStarted = true;
        } else {}
      }
    }
  }

  Future<XFile?> stopVideoRecordingSixtySeonds() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      XFile file = await controller!.stopVideoRecording();
      isRecordingInProgress = false;
      _logger.i(isRecordingInProgress);

      return file;
    } on CameraException catch (e) {
      _logger.d(e);
      _logger.e("Error stopping video recording: $e");
      // SnackBarHelper.showSnackBar(
      //     message: "Something went wrong", contentType: ContentType.failure);
      return null;
    }
  }

  @override
  void dispose() {
    isRecordingStarted = false;
    _timer?.cancel();
    controller?.dispose();
    super.dispose();
  }
}
