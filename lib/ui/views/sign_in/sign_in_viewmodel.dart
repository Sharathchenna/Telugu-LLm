import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/auth_service.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.form.dart';

class SignInViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  void signupAndNavigateToOtp() async {
    // bool returnValue =
    //     await _authService.emailAuth(userNameValue!, phoneNumberValue!);
    bool returnValue =
        await _authService.emailAuth(userNameValue!, phoneNumberValue!);
    if (returnValue) {
      _navigationService.replaceWithDashboardView();
    } else {
      // bool returnvalue =
      //     await _authService.userAuth(userNameValue!, phoneNumberValue!);
      // if (returnvalue)
      _navigationService.navigateToOtpView();
    }
  }
}
