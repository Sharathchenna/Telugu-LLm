import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/auth_service.dart';

class OtpViewModel extends BaseViewModel {
  final _logger = getLogger("OtpViewModel");
  String userId = "", otpValue = "";

  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  void onPinCompletedHandler(String pin) {
    _logger.i("On Pin submit: $pin");
    otpValue = pin;
    //verify entered otp
  }

  void onChangePinHandler(String pin) {
    _logger.i("On chage pin $pin");
  }

  void verifyOtpHandler() async {
    if (otpValue.length != 6) return;
    Map<String, dynamic> verifyResponse =
        await _authService.verifyOtp(otpValue: otpValue, userId: userId);
    if (verifyResponse["status"]) {
      _navigationService.replaceWithDashboardView();
    } else {
      _logger.e("Something went wrong ${verifyResponse['message']}");
    }
  }
}
