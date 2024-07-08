import 'dart:developer';
import 'package:camera/camera.dart';

class CameraUtils {
  static Future<CameraController?> initializeCamera() async {
    try {
      // Get available cameras
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        log('<<<< No cameras found on device');
        return null; // Handle no camera scenario
      }
      // Create a CameraController with desired resolution preset
      final controller = CameraController(cameras[1], ResolutionPreset.medium);

      // Initialize the controller
      await controller.initialize();

      return controller;
    } on CameraException catch (e) {
      log(e.description.toString()); // Log or handle camera errors
      return null;
    }
  }
}
