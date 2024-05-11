import 'dart:convert';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:appwrite/appwrite.dart';
import 'package:hive/hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/exception/appwrite_exception.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';
import 'package:swaram_ai/ui/common/snack_bar.dart';

class AuthService {
  final _client = locator<ClientService>();
  final _logger = getLogger("AuthService");
  late final Session session;

  Future<Map<String, dynamic>> userAuth(String name, String phoneNumber) async {
    phoneNumber = phoneNumber.startsWith("0")
        ? phoneNumber.replaceFirst('0', '+91')
        : phoneNumber;
    try {
      Execution requestOtpFunctions = await _client.getFunction.createExecution(
          functionId: appWriteRequestOtpFunctions,
          method: ExecutionMethod.pOST,
          path: '/',
          xasync: false,
          body: jsonEncode({"phone": phoneNumber, "name": name}));
      _logger.d(requestOtpFunctions.responseBody);
      _logger.d(requestOtpFunctions.responseStatusCode);
      Map<String, dynamic> parsedResponse =
          jsonDecode(requestOtpFunctions.responseBody);
      if (requestOtpFunctions.responseStatusCode == 200 &&
          parsedResponse["ok"]) {
        return {"data": parsedResponse["data"], "status": parsedResponse["ok"]};
      }
      return {"error": "Something went wrong", "status": parsedResponse["ok"]};
    } on AppwriteException catch (error) {
      var exceptionMessage =
          AppWriteExceptionHanlder().getExceptionMessage(error);
      SnackBarHelper.showSnackBar(
          message: exceptionMessage[1],
          contentType: ContentType.failure,
          title: exceptionMessage[0]);
      return {"data": "", "status": false};
    } catch (error) {
      _logger.e(error.toString());
      SnackBarHelper.showSnackBar(
          message: "Something went wrong! ", contentType: ContentType.failure);
      return {"data": "", "status": false};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
      {required String otpValue, required String userId}) async {
    Execution requestOtpFunctions = await _client.getFunction.createExecution(
        functionId: appWriteVerifyOtpFunctions,
        method: ExecutionMethod.pOST,
        path: '/',
        xasync: false,
        body: jsonEncode({"userId": userId, "otp": otpValue}));
    _logger.d(requestOtpFunctions.responseBody);
    _logger.d(requestOtpFunctions.responseStatusCode);
    Map<String, dynamic> parsedResponse =
        jsonDecode(requestOtpFunctions.responseBody);
    if (requestOtpFunctions.responseStatusCode == 200) {
      if (parsedResponse["ok"]) {
        var auth = await Hive.openBox(authBox);
        auth.put("auth", parsedResponse["data"]);
        return {"status": true, "message": ""};
      } else {
        return {"status": false, "message": "OTP failed to verify"};
      }
    }

    return {"status": false};
  }
}
