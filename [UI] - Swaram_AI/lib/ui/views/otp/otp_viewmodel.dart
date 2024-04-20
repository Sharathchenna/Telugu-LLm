import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/app/app.router.dart';

class OtpViewModel extends BaseViewModel {
  final logger = getLogger("OtpViewModel");
  final _navigationService = locator<NavigationService>();
  void navigateToDashboardView() {
    _navigationService.replaceWithDashboardView();
  }
}
