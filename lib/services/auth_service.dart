import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hive/hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';

class AuthService {
  final _client = locator<ClientService>();
  final _logger = getLogger("AuthService");
  late final Session session;

  Account get _getAccount => Account(_client.getAppWriteClient);

  Future<bool> userAuth(String name, String phoneNumber) async {
    Account account = _getAccount;

    Token sessionToken = await account.createPhoneToken(
      userId: ID.unique(),
      phone: phoneNumber,
    );
    _logger.i(sessionToken.userId);
    return true;
  }

  Future<bool> emailAuth(String email, String password) async {
    Account account = _getAccount;

    session = await account.createEmailPasswordSession(
      email: email,
      password: password,
    );
    var auth = await Hive.openBox(authBox);

    await auth.put("auth", session.toMap());

    _logger.i(session.toMap());

    return true;
  }
}
