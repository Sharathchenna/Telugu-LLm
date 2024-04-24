import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class RecordService with ListenableServiceMixin {
  final Storage? _storage = locator<ClientService>().getAppWriteStorage;

  Future<bool> uploadRecording(String filePath, String fileName) async {
    await _storage!.createFile(
        bucketId: appWriteRecordingBucketId,
        fileId: fileName,
        file: InputFile.fromPath(path: filePath));
    return true;
  }
}
