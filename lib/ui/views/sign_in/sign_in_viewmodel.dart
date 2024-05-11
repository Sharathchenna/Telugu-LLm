import 'dart:isolate';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/auth_service.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.form.dart';

class SignInViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _logger = getLogger("SignIn ViewModel");
  bool isFormSubmitted = false;
  bool isLoading = false;

  void signupAndNavigateToOtp() async {
    isFormSubmitted = true;
    if (isFormValid) {
      isLoading = true;
      rebuildUi();
      Map<String, dynamic> returnValue =
          await _authService.userAuth(userNameValue!, phoneNumberValue!);
      _logger.i(returnValue);
      if (returnValue["status"]) {
        _navigationService.navigateToOtpView(
            userId: returnValue["data"]["userId"]);
      } else {
        isLoading = false;
        rebuildUi();
      }
    }
  }
}
