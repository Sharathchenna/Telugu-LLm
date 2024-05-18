import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    var auth = await Hive.openBox(authBox);
    // auth.clear();
    var authMap = auth.get("auth");

    if (authMap == null) {
      _navigationService.replaceWithSignInView();
      return;
    } else {
      _navigationService.replaceWithDashboardView();
    }

    // _navigationService.replaceWithDashboardView();
  }
}
