import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';

class SignInViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToOtpView() {
    _navigationService.navigateToOtpView();
  }
}
