import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:hive/hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class AuthService {
  final _client = locator<ClientService>();
  final _logger = getLogger("AuthService");
  late final Session session;

  Account get _getAccount => Account(_client.getAppWriteClient);

  Future<Map<String, dynamic>> userAuth(String name, String phoneNumber) async {
    phoneNumber = phoneNumber.startsWith("0")
        ? phoneNumber.replaceFirst('0', '+91')
        : phoneNumber;
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
    if (requestOtpFunctions.responseStatusCode == 200 && parsedResponse["ok"]) {
      return {"data": parsedResponse["data"], "status": parsedResponse["ok"]};
    }
    return {"error": "Something went wrong", "status": parsedResponse["ok"]};
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
