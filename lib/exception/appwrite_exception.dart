import 'package:appwrite/appwrite.dart';
import 'package:swaram_ai/app/app.logger.dart';

class AppWriteExceptionHanlder {
  final _logger = getLogger("AppWriteExceptionHandler");
  List<String> getExceptionMessage(AppwriteException exception) {
    _logger.e("Exception Message: ${exception.message}");
    _logger.e("Exception Status Code: ${exception.code}");
    _logger.e("Exception type: ${exception.type}");
    switch (exception.code) {
      case (200):
      default:
        return [
          "Connection Error",
          "We're sorry, but we encountered a problem connecting to our servers."
        ];
    }
  }
}
