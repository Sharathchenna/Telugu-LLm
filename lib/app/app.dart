import 'package:record/record.dart';
import 'package:swaram_ai/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:swaram_ai/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:swaram_ai/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/ui/views/sign_in/sign_in_view.dart';
import 'package:swaram_ai/ui/views/otp/otp_view.dart';
import 'package:swaram_ai/ui/views/dashboard/dashboard_view.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:swaram_ai/services/auth_service.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/services/record_service.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/ui/views/memo/memo_view.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/ui/bottom_sheets/sucess/sucess_sheet.dart';
import 'package:swaram_ai/ui/dialogs/confirm/confirm_dialog.dart';
import 'package:swaram_ai/services/stopwatch_service.dart';
import 'package:swaram_ai/ui/views/video_recording/video_recording_view.dart';
import 'package:swaram_ai/ui/views/memo_detail/memo_detail_view.dart';
import 'package:swaram_ai/services/util_service.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SignInView),
    MaterialRoute(
      page: OtpView,
    ),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: MemoView),
    MaterialRoute(page: VideoRecordingView),
    MaterialRoute(page: MemoDetailView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TimerService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ClientService),
    LazySingleton(classType: RecordService),
    LazySingleton(classType: CategoryService),
    LazySingleton(classType: NetworkService),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: StopwatchService),
    LazySingleton(classType: AudioRecorder),
    LazySingleton(classType: UtilService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: SuccessSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDialog),
// @stacked-dialog
  ],
)
class App {}
