import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';

class SignInViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  // final _authService = locator<AuthService>();

  void signupAndNavigateToOtp() async {
    // bool returnvalue =
    //     await _authService.userAuth(userNameValue!, phoneNumberValue!);
    // if (returnvalue)
    _navigationService.navigateToOtpView();
  }
}
