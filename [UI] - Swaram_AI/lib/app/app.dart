import 'package:swaram_ai/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:swaram_ai/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:swaram_ai/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.dart';
import 'package:swaram_ai/ui/views/otp/otp_view.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SignInView),
    MaterialRoute(
      page: OtpView,
    ),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
