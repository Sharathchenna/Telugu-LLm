import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/auth_service.dart';
import 'package:swaram_ai/ui/common/snack_bar.dart';

class OtpViewModel extends BaseViewModel {
  final _logger = getLogger("OtpViewModel");
  String userId = "", otpValue = "";
  bool isLoading = false;

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
    isLoading = true;
    rebuildUi();
    try {
      Map<String, dynamic> verifyResponse =
          await _authService.verifyOtp(otpValue: otpValue, userId: userId);
      _logger.d(verifyResponse);
      if (verifyResponse["status"]) {
        _navigationService.replaceWithDashboardView();
      } else {
        isLoading = false;
        _logger.i("Wrong otp");
        SnackBarHelper.showSnackBar(
            title: "Verification Error",
            message:
                "The OTP you entered is incorrect. Please check the OTP and try again.",
            contentType: ContentType.failure);
        _logger.i("Wrong Otp enter ${verifyResponse['message']}");
      }
    } catch (e) {
      _logger.e("Exception occurred: ${e.toString()}");
      SnackBarHelper.showSnackBar(
          message: "Something went wrong", contentType: ContentType.failure);
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }
}
