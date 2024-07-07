import 'package:permission_handler/permission_handler.dart';

class PermissionsHandlerUtil {
  static Future<bool> checkAndRequestCameraPermission() async {
    final status = await Permissions().hasCameraPermission();
    if (!status) {
      final requestResult = await Permissions().requestCameraPermission();
      if (requestResult == PermissionStatus.granted) {
        // Use the camera functionality here
      } else if (requestResult == PermissionStatus.permanentlyDenied) {
        // Handle permanently denied cases
      } else {
        // Handle other possible statuses
      }
    }
    return status;
  }

  static Future<bool> checkAndRequestMicroPhonePermission() async {
    final status = await Permissions().hasMicroPhonePermission();
    if (!status) {
      final requestResult = await Permissions().requestMicroPhonePermission();
      if (requestResult == PermissionStatus.granted) {
        // Use the microphone functionality here
      } else if (requestResult == PermissionStatus.permanentlyDenied) {
        // Handle permanently denied cases
      } else {
        // Handle other possible statuses
      }
    }
    return status;
  }
}

class Permissions {
  // Check camera permission status
  Future<bool> hasCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  // Request camera permission
  Future<PermissionStatus> requestCameraPermission() async {
    if (await hasCameraPermission()) {
      return PermissionStatus.granted;
    }
    final requestResult = await Permission.camera.request();
    return requestResult;
  }

  Future<bool> hasMicroPhonePermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted;
  }

  Future<PermissionStatus> requestMicroPhonePermission() async {
    if (await hasMicroPhonePermission()) {
      return PermissionStatus.granted;
    }
    final requestResult = await Permission.microphone.request();
    return requestResult;
  }
}
