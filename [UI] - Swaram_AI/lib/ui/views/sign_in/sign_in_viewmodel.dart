import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.form.dart';

class SignInViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _logger = getLogger("SignIn View Model");
  final _bottomSheet = locator<BottomSheetService>();

  void navigateToOtpView() {
    _bottomSheet.showBottomSheet(
        elevation: 3.0,
        title: "Form field message",
        description:
            'User Name: $userNameValue\nPhone Number: $phoneNumberValue');
    _navigationService.navigateToOtpView();
  }
}
