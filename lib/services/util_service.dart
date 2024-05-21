import 'dart:math';

import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class UtilService {
  final _logger = getLogger("Util Service");
  String generateUniqueId() {
    // Get the current timestamp in milliseconds since the Unix epoch
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Convert the timestamp to a base 36 string (numbers + letters) to reduce its length
    String shortTimestamp = timestamp.toRadixString(36);

    // Limit the length to 10 characters by taking a substring
    // This step assumes the timestamp will be significantly shorter than 10 characters after conversion
    String truncatedShortTimestamp =
        shortTimestamp.substring(0, min(shortTimestamp.length, 10));

    // Generate a random component to add to the timestamp
    // We use a simple method to generate a random number between 0 and 9999
    // Then convert it to a base 36 string to match the timestamp format
    int randomNumber = Random.secure().nextInt(10000);
    String randomComponent = randomNumber.toRadixString(36);

    // Combine the timestamp and random component
    // Ensure the combined string is at least 10 characters long
    // If not, pad it with zeros or another character until it reaches the desired length
    String uniqueId = '$truncatedShortTimestamp$randomComponent';

    // Pad the ID if it's less than 10 characters
    while (uniqueId.length < 10) {
      uniqueId += '0'; // Or choose another padding character
    }

    return uniqueId;
  }

  String sanitizeFileId(String fileId) {
    // Ensure fileId does not exceed 36 characters
    if (fileId.length > 36) {
      _logger.e("Validation Error | Exceeds the length of 36");
      fileId = fileId.substring(0, 36);
    }

    // Check if fileId starts with a special character and remove it if so
    RegExp specialChars = RegExp(r'^[._-]');
    if (specialChars.hasMatch(fileId)) {
      _logger.e("Validation Error | Special characters");
      fileId = fileId.substring(1);
    }

    // Replace any invalid characters
    fileId = fileId.replaceAll(RegExp(r'[^a-zA-Z0-9_.\-]'), '');

    return fileId;
  }
}
