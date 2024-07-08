import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SwechaFooterModel extends BaseViewModel {
  Future<void> launchInBrowser() async {
    if (!await launchUrl(
      Uri.parse(privacyURL),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $privacyURL');
    }
  }
}
