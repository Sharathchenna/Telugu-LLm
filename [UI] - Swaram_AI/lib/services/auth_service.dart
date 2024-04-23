import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/client_service.dart';

class AuthService {
  final _client = locator<ClientService>().getAppWriteClient;
  final _logger = getLogger("AuthService");

  Future<bool> userAuth(String name, String phoneNumber) async {
    Account account = Account(_client!);

    Token sessionToken = await account.createPhoneToken(
      userId: ID.unique(),
      phone: phoneNumber,
    );
    _logger.i(sessionToken.userId);
    return true;
  }
}
