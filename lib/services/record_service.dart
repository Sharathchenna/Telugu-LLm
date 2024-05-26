import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class RecordService with ListenableServiceMixin {
  final Storage _storage = locator<ClientService>().getAppWriteStorage;
  final _logger = getLogger("Record Service");

  uploadRecording(String filePath, String fileName,
      Function(UploadProgress)? onProgress) async {
    try {
      _logger.d("Started the recording");
      var fileExist = await checkFileExist(filePath);
      _logger.i("File Exist: $fileExist");
      if (fileExist) {
        await _storage.createFile(
            bucketId: appWriteRecordingBucketId,
            fileId: fileName,
            file: InputFile.fromPath(path: filePath, filename: fileName),
            onProgress: onProgress);
        _logger.d("Successfully uploaded");
      }
    } on AppwriteException catch (e) {
      _logger.e("Appwrite exception| ${e.toString()}");
      rethrow;
    } catch (e) {
      _logger.e("Exception| ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> checkFileExist(String filePath) async {
    File file = File(filePath);
    _logger.i(await file.length());
    return await file.exists();
  }
}
