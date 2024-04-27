import 'package:appwrite/models.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    var auth = await Hive.openBox(authBox);
    var sessionMap = auth.get("auth");
    if (sessionMap == null) {
      _navigationService.replaceWithSignInView();
    } else {
      Session session = Session.fromMap(Map<String, dynamic>.from(sessionMap));
      DateTime expiryDate = DateTime.parse(session.expire);
      if (expiryDate.isBefore(DateTime.now())) {
        _navigationService.replaceWithSignInView();
      }
      _navigationService.replaceWithDashboardView();
    }

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
  }
}
